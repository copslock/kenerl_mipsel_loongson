Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2004 17:01:19 +0100 (BST)
Received: from p508B75A1.dip.t-dialin.net ([IPv6:::ffff:80.139.117.161]:51274
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225201AbUHQQBP>; Tue, 17 Aug 2004 17:01:15 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7HG1D1M000334;
	Tue, 17 Aug 2004 18:01:13 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7HG1AoF000331;
	Tue, 17 Aug 2004 18:01:10 +0200
Date: Tue, 17 Aug 2004 18:01:10 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org, binutils@sources.redhat.com
Subject: Branch bug in gas on MIPS
Message-ID: <20040817160110.GA32594@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Below little test case demonstrates a gas bug that results in swapping
of the two branch instructions and use of bogus destination addresses
for the first of the two branches.

[ralf@lappi tmp]$ cat s.s
1:      beqzl   $2, 1b
        beq     $4, $5, 1b
[ralf@lappi tmp]$ mips-linux-as -mips2 -o s.o s.s
[ralf@lappi tmp]$ mips-linux-objdump -d s.o
 
s.o:     file format elf32-tradbigmips
 
Disassembly of section .text:
 
00000000 <.text>:
   0:   1085ffff        beq     a0,a1,0x0
   4:   00000000        nop
   8:   50400000        beqzl   v0,0xc
   c:   00000000        nop

Have a nice day ;-)

  Ralf
