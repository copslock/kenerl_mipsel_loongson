Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 13:30:21 +0100 (BST)
Received: from p508B7E7F.dip.t-dialin.net ([IPv6:::ffff:80.139.126.127]:59479
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224828AbUHRMaQ>; Wed, 18 Aug 2004 13:30:16 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7ICUEcE015714
	for <linux-mips@linux-mips.org>; Wed, 18 Aug 2004 14:30:14 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7ICUE6s015713
	for linux-mips@linux-mips.org; Wed, 18 Aug 2004 14:30:14 +0200
Date: Wed, 18 Aug 2004 14:30:14 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: Branch bug in gas on MIPS
Message-ID: <20040818123014.GA15627@linux-mips.org>
References: <20040817160110.GA32594@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817160110.GA32594@linux-mips.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5673
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 17, 2004 at 06:01:10PM +0200, Ralf Baechle wrote:

I've uploaded fixed rpm packages of cross-binutils built on Fedora Core 2
for i386 to ftp.linux-mips.org which fix the swapped branch bug which I
posted yesterday.

03347fbaefda6451ad025e05dd43fc79  binutils-mips-linux-2.13.2.1-4.i386.rpm
6d3f22d1666497d6d02e2a2534426709  binutils-mips64-linux-2.13.2.1-4.i386.rpm
aca35612fa321ca01b02e84512cd2ae7  binutils-mips64el-linux-2.13.2.1-4.i386.rpm
1e87615b74173a2a2c5b94b60dc4bb2e  binutils-mipsel-linux-2.13.2.1-4.i386.rpm
a26ba1110361c2c167223ad01ed1acc2  cross-binutils-2.13.2.1-4.src.rpm

Please verify the checksums; for about 2h before this announcement I had
broken rpm packages online.

The unbundled fix (credits for which belong to Thiemo Seufer) is below.

  Ralf

diff -urN binutils-2.13.2.1.orig/gas/config/tc-mips.c binutils-2.13.2.1/gas/config/tc-mips.c
--- binutils-2.13.2.1.orig/gas/config/tc-mips.c	2002-11-05 23:03:40.000000000 +0100
+++ binutils-2.13.2.1/gas/config/tc-mips.c	2004-08-18 13:15:31.553748456 +0200
@@ -2466,6 +2466,7 @@
 	  prev_insn_reloc_type[1] = BFD_RELOC_UNUSED;
 	  prev_insn_reloc_type[2] = BFD_RELOC_UNUSED;
 	  prev_insn_extended = 0;
+	  prev_insn_is_delay_slot = 1;
 	}
       else
 	{
