import Result "mo:base/Result";
import Debug "mo:base/Debug";
import Error "mo:base/Error";
import Blob "mo:base/Blob";
import Option "mo:base/Option";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Icrc1Ledger "canister:icrc1_ledger_canister";

actor {

  type Account = {
    owner : Principal;
    subAccount : ? [Nat8];
  };  

  type TransferArgs = {
    amount : Nat;
    toAccount : Account;
  };

  public shared ({caller}) func transfer(args : TransferArgs) : async Result.Result<Icrc1Ledger.BlockIndex, Text> {
    Debug.print(
      "Transferring" 
      # debug_show(args.amount) 
      # "token to account" 
      # debug_show(args.toAccount)
    );
  };

  let transferArgs : Icrc1Ledger.TransferArgs = {
    memo = null;
    amount = args.amount;
    from_subAccount = null;
    fee = null;
    to = args.toAccount;
    created_at_time = null;
  };

  try {
    let transferResult = await Icrc1Ledger.icrc1_transfer(transferArgs);

    switch (transferResult) {
      case (#Err(transferError)) {
        return #err("Could not transfer funds: \n" # debug_show(transferError));
      };
      case (#Ok(blockIndex)) {
        return #ok(blockIndex);
      };
    };
  } catch (error: Error) {
    return #err("Reject Message: " # Error.message(error));
  };
}