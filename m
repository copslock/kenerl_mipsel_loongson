Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 May 2003 01:27:37 +0100 (BST)
Received: from bay1-f6.bay1.hotmail.com ([IPv6:::ffff:65.54.245.6]:8456 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225206AbTEEA1f>;
	Mon, 5 May 2003 01:27:35 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Sun, 4 May 2003 17:27:26 -0700
Received: from 4.42.101.130 by by1fd.bay1.hotmail.msn.com with HTTP;
	Mon, 05 May 2003 00:27:25 GMT
X-Originating-IP: [4.42.101.130]
X-Originating-Email: [michaelanburaj@hotmail.com]
From: "Michael Anburaj" <michaelanburaj@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Date: Sun, 04 May 2003 17:27:25 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F6t67zLTJTBUsl000074ca@hotmail.com>
X-OriginalArrivalTime: 05 May 2003 00:27:26.0232 (UTC) FILETIME=[1A9F5180:01C3129D]
Return-Path: <michaelanburaj@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michaelanburaj@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Finally, I could compile vmlinux. I thought of booting this RAM image (or 
its SREC equivalent) using the onboard YAMON (in BIG endian mode - I am 
having trouble building Redboot in BIG endian mode <issue ported at ecos 
forum>, so for now thought of using YAMON). After downloding the 
vmlinux.srec over the serial port (Starting at 0x80100000), I issued the go 
command to run the image. I get the following message:

YAMON> go

LINUX started...

* Exception (user) : Reserved instruction *
BadVAddr = 0x00000000  Cause    = 0x00808028
Compare  = 0x00061a80  Config   = 0x80038083
Config1  = 0x1e9b4d8a  Context  = 0x63800000
Count    = 0xb9188fd8  DEPC     = 0x21424255
Debug    = 0x0400dc0b  EPC      = 0x80122258
EntryHi  = 0x00000068  EntryLo0 = 0x028ff72e
EntryLo1 = 0x035a241f  ErrorEPC = 0x8003add0
Index    = 0x0000000b  PRId     = 0x00018001
PageMask = 0x01b90000  Random   = 0x0000000d
Status   = 0x00000402  WatchHi  = 0x00000000
WatchLo  = 0x00000000  Wired    = 0x00000000
Hi       = 0x00000000  Lo       = 0x04000000

$ 0(zr):0x00000000  $ 8(t0):0x00000000  $16(s0):0x802d810a  
$24(t8):0xffffffff
$ 1(at):0x80280000  $ 9(t1):0x00000000  $17(s1):0x802d810c  
$25(t9):0x802c1e94
$ 2(v0):0x0000000a  $10(t2):0x8024f401  $18(s2):0x00000400  
$26(k0):0x00000000
$ 3(v1):0x00000000  $11(t3):0x00000000  $19(s3):0x00000001  
$27(k1):0x00000000
$ 4(a0):0x00000000  $12(t4):0x00000000  $20(s4):0x0000001a  
$28(gp):0x802c0000
$ 5(a1):0x80280000  $13(t5):0x00000000  $21(s5):0x0000000a  
$29(sp):0x802c1f58
$ 6(a2):0x8024385a  $14(t6):0x802d8109  $22(s6):0x0000003e  
$30(s8):0x800b1080
$ 7(a3):0x00000000  $15(t7):0xfffffffe  $23(s7):0x0000003c  
$31(ra):0x80122230


The linux image started fine, but caused an exception after a while. Is this 
because Linux is not compatible with YAMON? If so, what are the possible 
monitor programs that can go with Linux? Please point me to the documents in 
this regard (documents on running Linux executable on Atlas 4Kc board).

Or will Linux work with any ROM monitor? If so, please let me know the 
reason for the exception.

Thanks a lot,
-Mike.

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail
