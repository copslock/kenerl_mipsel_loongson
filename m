Received:  by oss.sgi.com id <S42261AbQILBHo>;
	Mon, 11 Sep 2000 18:07:44 -0700
Received: from kayak.mcgary.org ([63.227.80.137]:65037 "EHLO kayak.mcgary.org")
	by oss.sgi.com with ESMTP id <S42241AbQILBH2>;
	Mon, 11 Sep 2000 18:07:28 -0700
Received: (from gkm@localhost)
	by kayak.mcgary.org (8.9.3/8.9.3) id SAA31731;
	Mon, 11 Sep 2000 18:07:17 -0700
Date:   Mon, 11 Sep 2000 18:07:17 -0700
Message-Id: <200009120107.SAA31731@kayak.mcgary.org>
X-Authentication-Warning: kayak.mcgary.org: gkm set sender to greg@mcgary.org using -f
From:   Greg McGary <greg@mcgary.org>
To:     linux-mips@oss.sgi.com
Subject: do_page_fault crash on Indigo2
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I built a kernel from the CVS trunk, updated as of last night (2000-09-10).

Here's my Indigo2 HW config (I pulled the G3-Elan board):

>> hinv
                   System: IP22
                Processor: 134 Mhz R4600, with FPU
     Primary I-cache size: 16 Kbytes
     Primary D-cache size: 16 Kbytes
     Secondary cache size: 512 Kbytes
              Memory size: 64 Mbytes
                SCSI Disk: scsi(0)disk(4)
                    Audio: Iris Audio Processor: version A2 revision 1.1.0


When I boot (passing init=/bin/sh), this happens:

------------------------------------------------------------------------------
...
Linux version 2.4.0-test8-pre1 (gkm@kayak.mcgary.org) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #1 Sun Sep 10 11:25:43 MST 2000
... many messages omitted ...
VFS: Mounted root (nfs filesystem) readonly.
Freeing prom memory: 0kb freed
Freeing unused kernel memory: 68k freed
------------------------------------------------------------------------------

Now it hangs, and when I hit <RETURN> at the serial console, I get this:

------------------------------------------------------------------------------
Unable to handle kernel paging request at virtual address 00000000, epc == 88026e10, ra == 880e058c
Oops in fault.c:do_page_fault, line 158:
$0 : 00000000 1000fc00 8818c62c 00000000
$4 : 8818c634 00000023 00000000 00000001
$8 : 884ee520 88009ed0 00000000 03f48000
$12: 8817f010 8818c634 8818c638 1000fc00
$16: 00000001 88185cf8 ffffffdf 0000000d
$20: 00000004 a8746e60 9fc56d94 00000000
$24: 00000000 00000001
$28: 88008000 88009e68 88009e68 880e058c
epc   : 88026e10
Status: 1000fc02
Cause : 00000008
Process swapper (pid: 0, stackpage=88008000)
Stack: 8817c000 881b4fa4 00000007 00000001 00000000 88033678 8802f31c 00000001
       8000000b 881a6cb0 80008000 887fe234 0019b3b0 00000001 881a6cb8 887fe234
       a87489f0 887fe53c 887fec20 881347ac 00008000 887fe234 a87489f0 887fe53c
       00000400 88134a78 88010c88 0000218c 00000f00 00000000 88009f88 0000218c
       00000000 88180000 880114d8 88186ac4 00000019 00000000 1000fc01 ffff00ff
       88009fe0 ...
Call Trace: [<88033678>] [<8802f31c>] [<881347ac>] [<88134a78>] [<88010c88>] [<88009f88>] [<880114d8>] [<88009fe0>] [<88008000>] [<88009f80>] [<8800f78c>] [<880114dc>] [<88135ce0>] [<880025c4>]
Code: 26315cf8  24100001  8c460004 <8cc30000> 00721024  00451024  1040005f  8dad0000  1320000e 
------------------------------------------------------------------------------

I get the exact same failure with both the hardhat-sgi-5.1 root FS and
with the simple/userland-0.2b root FS.

I found reference on the list archives to a possibly related problem
on R5000 Indys some months ago, but the system doesn't live long
enough to add swap space, and besides, the system shouldn't be
consuming all 64 MB so early.

Clues?

Greg
