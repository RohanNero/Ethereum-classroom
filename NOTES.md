# Quick notes

### Suicide

Issues testing this contract because of the old solidity version, `getCode()` was a proposed solution to this issue but not sure it will work for my situation.
https://github.com/foundry-rs/foundry/issues/326
https://github.com/foundry-rs/foundry/pull/440
https://book.getfoundry.sh/cheatcodes/get-code
https://book.getfoundry.sh/reference/forge-std/deployCode

When in doubt, I'll write a deploy script for it, then the test will just call the deploy script and make function calls that way.
