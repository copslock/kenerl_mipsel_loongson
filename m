Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Aug 2004 01:28:48 +0100 (BST)
Received: from web50307.mail.yahoo.com ([IPv6:::ffff:206.190.38.61]:52093 "HELO
	web50307.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225204AbUH0A2o>; Fri, 27 Aug 2004 01:28:44 +0100
Message-ID: <20040827002837.82864.qmail@web50307.mail.yahoo.com>
Received: from [66.237.41.195] by web50307.mail.yahoo.com via HTTP; Thu, 26 Aug 2004 17:28:37 PDT
Date: Thu, 26 Aug 2004 17:28:37 -0700 (PDT)
From: usha davuluri <ranidavuluri@yahoo.com>
Subject: Vmlinux-2.4.18 booting problems on Malta
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ranidavuluri@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ranidavuluri@yahoo.com
Precedence: bulk
X-list: linux-mips

* Exception (user) : Reserved instruction *
BadVAddr = 0x1ab0fe99  Cause    = 0x10808028
Compare  = 0x31a7e5fd  Config   = 0x80030083
Config1  = 0x1e9b4d8a  Context  = 0x7f0d5870
Count    = 0xf7cab5a2  DEPC     = 0x9bef8df4
Debug    = 0x0000dc3f  EPC      = 0x802e0024
EntryHi  = 0xa2fa40b3  EntryLo0 = 0x03ec7dee
EntryLo1 = 0x0290455c  ErrorEPC = 0x8002c34c
Index    = 0x0000000f  PRId     = 0x00018001
PageMask = 0x01974000  Random   = 0x00000007
Status   = 0x10002c02  WatchHi  = 0x00000000
WatchLo  = 0x00000000  Wired    = 0x00000000
Hi       = 0x00000013  Lo       = 0x53f7ceea

$ 0(zr):0x00000000  $ 8(t0):0x00000000 
$16(s0):0x00000000  $24(t8):0x00000000
$ 1(at):0x00000000  $ 9(t1):0x00000000 
$17(s1):0x00000000  $25(t9):0x00000000
$ 2(v0):0x00000000  $10(t2):0x00000000 
$18(s2):0x00000000  $26(k0):0x00000000
$ 3(v1):0x00000000  $11(t3):0x00000000 
$19(s3):0x00000000  $27(k1):0x00000000
$ 4(a0):0x00000002  $12(t4):0x10002c00 
$20(s4):0x00000000  $28(gp):0x802e0000
$ 5(a1):0x800a9770  $13(t5):0x1000001f 
$21(s5):0x00000000  $29(sp):0x800b3840
$ 6(a2):0x8006a4f0  $14(t6):0x00000000 
$22(s6):0x00000000  $30(s8):0x800b3840
$ 7(a3):0x04000000  $15(t7):0x00000000 
$23(s7):0x00000000  $31(ra):0x8003bd60

Hi all,
 I am getting the above error output when I say go
(starting address) after loading the kernel source.
please help me on this.
Thank you,
 Usha.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
