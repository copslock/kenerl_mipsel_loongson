Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 10:02:42 +0000 (GMT)
Received: from koto.vergenet.net ([210.128.90.7]:15239 "EHLO koto.vergenet.net")
	by ftp.linux-mips.org with ESMTP id S28603250AbYCFJ6K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Mar 2008 09:58:10 +0000
Received: from tabatha.lab.ultramonkey.org (vagw.valinux.co.jp [210.128.90.14])
	by koto.vergenet.net (Postfix) with ESMTP id B2902341BD;
	Thu,  6 Mar 2008 18:58:03 +0900 (JST)
Received: by tabatha.lab.ultramonkey.org (Postfix, from userid 7100)
	id 9EB944F8B5; Thu,  6 Mar 2008 18:58:03 +0900 (JST)
Message-Id: <20080306094637.669665743@vergenet.net>
User-Agent: quilt/0.46-1
Date:	Thu, 06 Mar 2008 18:46:37 +0900
From:	Simon Horman <horms@verge.net.au>
To:	kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc:	Tomasz Chmielewski <mangoo@wpkg.org>,
	Francesco Chiechi <francesco.chiechi@colibre.it>
Subject: [patch 00/12] Intention to merge mipsel into kexec-tools-testing
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

Hi,

Using qemu I have been able to satisfy myself that Francesco Chiechi's
patch to add mipsel to kexec-tools works.

I have upported this patch and made various cosmetic changes too it, as per
this series of patches. I intend to merge these patches.

One thing that clearly needs further work is the handling of the command
line passed to the second kernel. In preamble to his patch Francesco makes
mention that his patch uses elf boot nodes to pass the command line.
Inspection of the code reflects this.

However in my limited understanding this only supports a subset of mipsel
hardware. In particular, I notice that it does not use qemu. I wonder if
ultimately kexec-tools will need a --machine or --boot-protocol parameter
or something of that nature.

-- 
Horms
