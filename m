Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Sep 2002 17:42:16 +0200 (CEST)
Received: from ip-161-71-171-238.corp-eur.3com.com ([161.71.171.238]:7613 "EHLO
	columba.www.eur.3com.com") by linux-mips.org with ESMTP
	id <S1122976AbSISPmP>; Thu, 19 Sep 2002 17:42:15 +0200
Received: from toucana.eur.3com.com (toucana.EUR.3Com.COM [140.204.220.50])
	by columba.www.eur.3com.com  with ESMTP id g8JFhAY3019030
	for <linux-mips@linux-mips.org>; Thu, 19 Sep 2002 16:43:48 +0100 (BST)
Received: from notesmta.eur.3com.com (eurmta1.EUR.3Com.COM [140.204.220.206])
	by toucana.eur.3com.com  with SMTP id g8JFgKu21000
	for <linux-mips@linux-mips.org>; Thu, 19 Sep 2002 16:42:20 +0100 (BST)
Received: by notesmta.eur.3com.com(Lotus SMTP MTA v4.6.3  (733.2 10-16-1998))  id 80256C39.0056AD3E ; Thu, 19 Sep 2002 16:46:44 +0100
X-Lotus-FromDomain: 3COM
From: "Jon Burgess" <Jon_Burgess@eur.3com.com>
To: linux-mips@linux-mips.org
Message-ID: <80256C39.0056AAAC.00@notesmta.eur.3com.com>
Date: Thu, 19 Sep 2002 16:40:05 +0100
Subject: Problem running Mips2 user space code
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=VbmIrTEGDLodNkTwcYXHOM2JzuWm2ArfCN5qSkMgYf5RhxsFNNb3qsf0"
Content-Disposition: inline
Return-Path: <Jon_Burgess@eur.3com.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jon_Burgess@eur.3com.com
Precedence: bulk
X-list: linux-mips

--0__=VbmIrTEGDLodNkTwcYXHOM2JzuWm2ArfCN5qSkMgYf5RhxsFNNb3qsf0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline



We have an product with an embedded Mips32 processor running CVS linux_2_4_17.
Everything seems to work well when we compile our user space code with the
default GCC options (i.e. producing mips1 code) but if we optimise the user
space code to use the same CPU flags as the kernel (-mips2 -mcpu=r4600) then
code crashes intermittently . Has anyone else tried running mips2 user mode
code?

Both the kernel and user space code are compiled with HJ Lu's toolchain 20020627
RPMs. This toolchain flags the binaries as 'mips2' so I had to copy the
include/asm/elf.h file from CVS HEAD to get them to execute. As far as I can
tell this should be OK. I can update the kernel to the latest CVS if required,
but I need to apply some board specific changes.

I have a developed a small (1kb source) test program which exhibits the problem.
This source build the executables 'mips1' & mips2'. When these are run the mips2
program iterates a few times but normally stops in a couple of seconds reporting
total=7, where as it should be 6. The mips1 program always gets the correct
answer and keeps on running. Does the same thing happen for anyone else?

I examined the instructions which are involved in causing the crashes and found
that it seems to be related to the use of the 'branch likely' instruction in the
Mips2 code, generated for the lines 'if (X) bar(X)' in the test program. The
same instructions run every loop iteration and it only occasionally gets the
wrong answer. The problem seems to be that the branch likely delay slot
instruction fails to get nullified even though the branch is not taken. Could a
task schedule or exception while executing the branch likely instruction cause a
problem?

I can send the compiled executable directly if anyone is interested in trying my
executables on another board/kernel (total about 16kb) -- just in case it is
caused by a toolchain problem. I just read Ralfs comment about not sending
files, tars or compressed files to the mailing list, hopefully he won't mind the
source.

     Jon

(See attached file: Makefile)(See attached file: bnel2.c)

--0__=VbmIrTEGDLodNkTwcYXHOM2JzuWm2ArfCN5qSkMgYf5RhxsFNNb3qsf0
Content-type: application/octet-stream; 
	name="Makefile"
Content-Disposition: attachment; filename="Makefile"
Content-transfer-encoding: base64

Q1JPU1NfQ09NUElMRSA6PSAvZXhwb3J0L3Rvb2xzL2Jpbi9taXBzLWxpbnV4LQoKQVMgICAgICAg
ICAgICAgIDo9ICQoQ1JPU1NfQ09NUElMRSlhcwpMRCAgICAgICAgICAgICAgOj0gJChDUk9TU19D
T01QSUxFKWxkCkNDICAgICAgICAgICAgICA6PSAkKENST1NTX0NPTVBJTEUpZ2NjCkNQUCAgICAg
ICAgICAgICA6PSAkKENDKSAtRQpBUiAgICAgICAgICAgICAgOj0gJChDUk9TU19DT01QSUxFKWFy
Ck5NICAgICAgICAgICAgICA6PSAkKENST1NTX0NPTVBJTEUpbm0KU1RSSVAgICAgICAgICAgIDo9
ICQoQ1JPU1NfQ09NUElMRSlzdHJpcApPQkpDT1BZICAgICAgICAgOj0gJChDUk9TU19DT01QSUxF
KW9iamNvcHkKT0JKRFVNUCAgICAgICAgIDo9ICQoQ1JPU1NfQ09NUElMRSlvYmpkdW1wCgpDRkxB
R1MgICAgICAgICs9IC1waXBlIC1PIC1XYWxsCgphbGw6IG1pcHMxIG1pcHMyCglAI2NwIC1mIG1p
cHMxIG1pcHMyIC90ZnRwYm9vdC8xNjEuNzEuNTQuMjMvc2Jpbi8KCUAjL2V4cG9ydC90b29scy9i
aW4vbWlwcy1saW51eC1vYmpkdW1wIC1kIC1tbWlwczppc2EzMiBtaXBzMgoKbWlwczE6IGJuZWwy
LmMKCSQoQ0MpICQoQ0ZMQUdTKSAtbyAkQCAkPAoKbWlwczI6IGJuZWwyLmMKCSQoQ0MpICQoQ0ZM
QUdTKSAtbWNwdT1yNDYwMCAtbWlwczIgLW8gJEAgJDwKCmNsZWFuOgoJcm0gLWYgbWlwczEgbWlw
czIK

--0__=VbmIrTEGDLodNkTwcYXHOM2JzuWm2ArfCN5qSkMgYf5RhxsFNNb3qsf0
Content-type: application/octet-stream; 
	name="bnel2.c"
Content-Disposition: attachment; filename="bnel2.c"
Content-transfer-encoding: base64

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHNp
Z25hbC5oPgoKdHlwZWRlZiBzdHJ1Y3QgewogIGNoYXIgc3BhY2VyWzB4MjhdOwogIGludCBwOwog
IGNoYXIgc3BhY2VyMls0MF07CiAgaW50IHI7CiAgY2hhciBtZXNzYWdlWzIxMDBdOwogIGludCBx
Owp9IHNfdGVzdDsKCmludCB0b3RhbDsKCnZvaWQgc3RhcnRfY2hpbGQoKQp7CiAgaW50IHBpZCA9
IGZvcmsoKTsKCiAgLyogUGFyZW50ICovCiAgaWYgKHBpZCkKICAgIHJldHVybjsKCiAgLyogQ2hp
bGQgKi8KICB3aGlsZSgxKQogICAgewogICAgICBzbGVlcCgxKTsKICAgICAgc3lzdGVtKCJscyAt
bCIpOwogICAgfQp9Cgp2b2lkIGJhcihpbnQgeCkKewogIHByaW50ZigiVmFyaWFibGUgaXMgJWRc
biIsIHgpOwogIHRvdGFsICs9IHg7Cn0KCnZvaWQgZm9vKHNfdGVzdCAqYSkKewogIHByaW50Zigi
cCA9ICVkXG4iLCBhLT5wKTsKICBwcmludGYoInEgPSAlZFxuIiwgYS0+cSk7CiAgcHJpbnRmKCJy
ID0gJWRcbiIsIGEtPnIpOwogIHByaW50ZigiTWVzc2FnZSBpcyAlc1xuIiwgYS0+bWVzc2FnZSk7
CgogIGlmIChhLT5wKQogICAgYmFyKGEtPnApOwoKICBpZiAoYS0+cSkKICAgIGJhcihhLT5xKTsK
CiAgaWYgKGEtPnIpCiAgICBiYXIoYS0+cik7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pCnsKICBjaGFyICpzdHJpbmcgPSAiSGVsbG8gd29ybGQiOwogIHNfdGVzdCBkYXRhOwoK
ICBkYXRhLnA9MTsKICBkYXRhLnE9MjsKICBkYXRhLnI9MzsKCiAgc3RyY3B5KGRhdGEubWVzc2Fn
ZSwgc3RyaW5nKTsKCiAgc3RhcnRfY2hpbGQoKTsKCiAgd2hpbGUoMSkKICAgIHsKICAgICAgdG90
YWwgPSAwOwoKICAgICAgZm9vKCZkYXRhKTsKCiAgICAgIHByaW50ZigiVG90YWwgJWRcbiIsIHRv
dGFsKTsKICAgICAgaWYgKHRvdGFsICE9IDYpCglicmVhazsKICAgIH0KCiAga2lsbCgwLCBTSUdI
VVApOyAKCiAgcmV0dXJuIDA7Cn0KCgo=

--0__=VbmIrTEGDLodNkTwcYXHOM2JzuWm2ArfCN5qSkMgYf5RhxsFNNb3qsf0--
