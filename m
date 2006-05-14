Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 May 2006 15:51:18 +0200 (CEST)
Received: from eastrmmtao01.cox.net ([68.230.240.38]:56562 "HELO
	eastrmmtao01.cox.net") by ftp.linux-mips.org with SMTP
	id S8127173AbWENNvK (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 May 2006 15:51:10 +0200
Received: from hermes.mountolympos.net ([70.160.186.45])
          by eastrmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514135102.VCNU17255.eastrmmtao01.cox.net@hermes.mountolympos.net>
          for <linux-mips@linux-mips.org>; Sun, 14 May 2006 09:51:02 -0400
Received: from zeus.mountolympos.net (zeus.mountolympos.net [192.168.2.2])
	by hermes.mountolympos.net (Postfix) with ESMTP id 5BC1C1677D
	for <linux-mips@linux-mips.org>; Sun, 14 May 2006 09:51:02 -0400 (EDT)
Received: from [192.168.2.3] (kronos.mountolympos.net [192.168.2.3])
	by zeus.mountolympos.net (Postfix) with ESMTP id 494AF100A118
	for <linux-mips@linux-mips.org>; Sun, 14 May 2006 09:51:02 -0400 (EDT)
Message-ID: <446735C6.2080306@mountolympos.net>
Date:	Sun, 14 May 2006 09:51:02 -0400
From:	John Miller <jamiller1110@cox.net>
User-Agent: Thunderbird 1.5 (X11/20060402)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Instruction error with cache opcode
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <jamiller1110@cox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamiller1110@cox.net
Precedence: bulk
X-list: linux-mips

I am attempting to write a routine to initialize the cache for a MIPS
4kc core to get Linux 2.6.16.14 to compile.  I am sure someone has
probably already done this, but I am doing it for educational reasons. 
I am receiving the following error:

arch/mips/kernel/head.S: Assembler messages:
arch/mips/kernel/head.S:131: Error: Instruction cache requires absolute
expression

From the following code section:

	li	t0, 0x80000000  		# start address (KSEG0)
	addu	t1,t0,0x2000			# 8KB I-cache
1:	addu	t0,0x10				# 16B line size
	cache	Index_Store_Tag_I,-4(t0)	# clear tag
	nop
	cache	Fill_I,-4(t0)			# fill line
	nop
	bne	t0,t1,1b
	cache	Index_Store_Tag_I,-4(t0)

 I copied the code section from See MIPS Run, so I know the code must be
correct.  What am I doing wrong?
