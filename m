Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 03:36:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34564 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492756AbZGABgb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2009 03:36:31 +0200
Date:	Wed, 1 Jul 2009 02:36:31 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus (v2).
In-Reply-To: <4A4AB845.1030906@caviumnetworks.com>
Message-ID: <alpine.LFD.2.00.0907010234320.23134@eddie.linux-mips.org>
References: <1246294455-26866-1-git-send-email-ddaney@caviumnetworks.com> <20090629193454.GA23430@linux-mips.org> <alpine.LFD.2.00.0907010132500.23134@eddie.linux-mips.org> <4A4AB845.1030906@caviumnetworks.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 30 Jun 2009, David Daney wrote:

> The problem with CPU_MIPS64_R2 in the kernel is that it means two unrelated
> things:
> 
> 1) The cpu can execute all mips64r2 ISA instructions.
> 
> 2) The cpu requires that all worse case cache and execution hazards are
> handled.
> 
> In the case of the Octeon processors, #1 is true, but we can get better
> performance by omitting many of the hazard barriers because they are unneeded.

 Which is why I think a split of the semantics would be a good idea.

  Maciej
