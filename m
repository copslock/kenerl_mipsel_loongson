Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2008 00:20:23 +0100 (BST)
Received: from [217.169.26.26] ([217.169.26.26]:10412 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S28581651AbYHSXUP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Aug 2008 00:20:15 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m7JNKALG015582;
	Wed, 20 Aug 2008 00:20:13 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m7JNK8RE015581;
	Wed, 20 Aug 2008 00:20:08 +0100
Date:	Wed, 20 Aug 2008 00:20:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Ignore vmlinux.lds generated files
Message-ID: <20080819232008.GA15564@linux-mips.org>
References: <200808192128.21386.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200808192128.21386.florian.fainelli@telecomint.eu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20279
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 19, 2008 at 09:28:21PM +0200, Florian Fainelli wrote:

> This patch adds the proper .gitignore file to ignore
> vmlinux.lds generated in arch/mips/kernel/.

Thanks, applied.

  Ralf
