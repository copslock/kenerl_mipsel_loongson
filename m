Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 11:29:28 +0100 (BST)
Received: from mout2.freenet.de ([IPv6:::ffff:194.97.50.155]:57490 "EHLO
	mout2.freenet.de") by linux-mips.org with ESMTP id <S8224861AbTENK3Y>;
	Wed, 14 May 2003 11:29:24 +0100
Received: from [194.97.50.144] (helo=mx1.freenet.de)
	by mout2.freenet.de with asmtp (Exim 4.15)
	id 19FtVi-00050C-Gx
	for linux-mips@linux-mips.org; Wed, 14 May 2003 12:29:22 +0200
Received: from p508f6cc2.dip.t-dialin.net ([80.143.108.194] helo=server.private.priv)
	by mx1.freenet.de with asmtp (ID aspam@freenet.de) (Exim 4.15 #3)
	id 19FtVi-00080d-2e
	for linux-mips@linux-mips.org; Wed, 14 May 2003 12:29:22 +0200
Received: from physik.private.priv (physik.private.priv [192.168.1.10])
	by server.private.priv (8.12.6/8.12.6) with SMTP id h4EATJqR079205
	for <linux-mips@linux-mips.org>; Wed, 14 May 2003 12:29:20 +0200 (CEST)
Date: Wed, 14 May 2003 12:31:44 +0200
From: Achim Hensel <achim.hensel@ruhr-uni-bochum.de>
To: linux-mips@linux-mips.org
Subject: Branch relocation fixing at Kernel-compiling with Debian-toolchain
Message-Id: <20030514123144.52da1d81.achim.hensel@ruhr-uni-bochum.de>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-portbld-freebsd4.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <achim.hensel@ruhr-uni-bochum.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: achim.hensel@ruhr-uni-bochum.de
Precedence: bulk
X-list: linux-mips

Hello, folks 

[I try to build Linux for a R4k Indigo1. I'm using as and ld of the
debian-toolchain with mips-linux-as/mips-linux-ld 2.13.90.0.18
20030121. At the moment, the kernel just compiles, but is not bootable
due to further adaption.]

As I'm not much into MIPS or gas assembler (most experience with 6502),
I would like to have some hints how to work around some kernel-compiling
errors:

When compiling the linux-mips.org kernel from the CVS-MAIN branch,
compiling stopped, as expected at the two assembler files 
entry.S and scall_o32.S in linux/arch/mips/kernel/ (both recent
versions) with a BFD-RELOC_16_PCREL_S2. 

The fix of combining global/local label, mentioned in 
http://sources.redhat.com/ml/binutils/2003-02/msg00205.htm
and other places, got me around the problem. Not every branch needed the
fix. Just one error remains:

In entry.S rev 1.49, around line 63, the branch target label
resume_kernel is defined by either a line statement
(ENTRY(resume_kernel), l.79) or a #definition from an other label (l.
52), depending on some #Config-options.

As work around I hardwired the branch label to one of them.

Any hints to adapt the fix to this problem? 
Diff/Patch for the rest will be posted if requested.

[Now working on with ELF2ECOFF converting]

CU,
	Achim
