Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Feb 2008 23:34:38 +0000 (GMT)
Received: from smtp-OUT05A.alice.it ([85.33.3.5]:28677 "EHLO
	smtp-OUT05A.alice.it") by ftp.linux-mips.org with ESMTP
	id S20031910AbYBLXea (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Feb 2008 23:34:30 +0000
Received: from FBCMMO01.fbc.local ([192.168.68.195]) by smtp-OUT05A.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 13 Feb 2008 00:34:21 +0100
Received: from FBCMCL01B06.fbc.local ([192.168.69.87]) by FBCMMO01.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 13 Feb 2008 00:34:24 +0100
Received: from [192.168.0.3] ([79.19.188.10]) by FBCMCL01B06.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 13 Feb 2008 00:34:21 +0100
From:	Matteo Croce <rootkit85@yahoo.it>
To:	linux-mips@linux-mips.org
Subject: Can't execute any MIPS  binary
Date:	Wed, 13 Feb 2008 00:34:24 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20080118.763038)
X-Face:	"(Z-sNp?}dL;GW1HP?5[[fZUP?g3$O&zLD:A-aRnqZ`<=?utf-8?q?54v=24w/ieZ+MrAPeae*a9=238uAUG=0A=09=25Bywb=5FV=5Dtn?=)]@R'L*vMngY"aGt~ZH-#5RV}4ZJ.*7c3`/*{?G_6ng]t8p;+TdB^vv:5?B<=?utf-8?q?=0A=09z=5FA?=)iR0_B5kp
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200802130034.25052.rootkit85@yahoo.it>
X-OriginalArrivalTime: 12 Feb 2008 23:34:23.0861 (UTC) FILETIME=[CC9DCA50:01C86DCF]
Return-Path: <rootkit85@yahoo.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rootkit85@yahoo.it
Precedence: bulk
X-list: linux-mips

Hi,
I have a machine, an AR7 MIPS router I want to hack, but I'm unable
to run _any_ executable on that machine outside the ones in the firmware.
I tried building a static mips1 binary, but it fails so:

# /var/test.bin
/var/test.bin: 1: Syntax error: "(" unexpected

so I downloaded a binary builtin in the firmware and I compared it to my own:

$ file busybox.bin test.bin
busybox.bin: ELF 32-bit LSB executable, MIPS, MIPS-I version 1 (SYSV), dynamically linked (uses shared libs), stripped
test.bin:    ELF 32-bit LSB executable, MIPS, version 1 (SYSV), statically linked, stripped

busybox.bin is the builtin busybox while test.bin is a static HelloWorld

I ran readelf on it:

$ readelf -h busybox.bin
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x4037e0
  Start of program headers:          52 (bytes into file)
  Start of section headers:          337304 (bytes into file)
  Flags:                             0x5, noreorder, cpic, mips1
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         6
  Size of section headers:           40 (bytes)
  Number of section headers:         21
  Section header string table index: 20
$ readelf -h test.bin
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x400140
  Start of program headers:          52 (bytes into file)
  Start of section headers:          11780 (bytes into file)
  Flags:                             0x50001007, noreorder, pic, cpic, o32, mips32
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         3
  Size of section headers:           40 (bytes)
  Number of section headers:         17
  Section header string table index: 16
$ diff -u <(readelf -h busybox.bin) <(readelf -h test.bin)
--- /dev/fd/63  2008-02-13 00:26:48.880261477 +0100
+++ /dev/fd/62  2008-02-13 00:26:48.880261477 +0100
@@ -8,13 +8,13 @@
   Type:                              EXEC (Executable file)
   Machine:                           MIPS R3000
   Version:                           0x1
-  Entry point address:               0x4037e0
+  Entry point address:               0x400140
   Start of program headers:          52 (bytes into file)
-  Start of section headers:          337304 (bytes into file)
-  Flags:                             0x5, noreorder, cpic, mips1
+  Start of section headers:          11780 (bytes into file)
+  Flags:                             0x50001007, noreorder, pic, cpic, o32, mips32
   Size of this header:               52 (bytes)
   Size of program headers:           32 (bytes)
-  Number of program headers:         6
+  Number of program headers:         3
   Size of section headers:           40 (bytes)
-  Number of section headers:         21
-  Section header string table index: 20
+  Number of section headers:         17
+  Section header string table index: 16

The router firmware uses:
# cat /proc/version
Linux version 2.4.17_mvl21-malta-mips_fp_le (root@localhost.localdomain) (gcc version 2.95.3 20010315 (release/MontaVista)) #1 Fri Mar 18 11:00:12 EST 2005

While I have a gcc-4.2.3 toolchain with 2.6.24 headers.


How can I build a mips1 binary instead of the mips32 I make? Can I disable o32?

Best Regards,
Matteo Croce
