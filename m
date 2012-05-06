Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 May 2012 09:06:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38291 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903611Ab2EFHGP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 May 2012 09:06:15 +0200
Date:   Sun, 6 May 2012 08:06:15 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Artem Bityutskiy <dedekind1@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 2/2] MIPS: bcm63xx: kbuild: remove -Werror
In-Reply-To: <1335534510-12573-2-git-send-email-dedekind1@gmail.com>
Message-ID: <alpine.LFD.2.00.1205060804400.19691@eddie.linux-mips.org>
References: <1335534510-12573-1-git-send-email-dedekind1@gmail.com> <1335534510-12573-2-git-send-email-dedekind1@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 33168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, 27 Apr 2012, Artem Bityutskiy wrote:

> From: Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>
> 
> I cannot build bcm963xx with the standard Kbuild W=1 switch:
> 
> arch/mips/bcm63xx/boards/board_bcm963xx.c: At top level:
> arch/mips/bcm63xx/boards/board_bcm963xx.c:647:5: error: no previous prototype for 'bcm63xx_get_fallback_sprom' [-Werror=missing-prototypes]
> cc1: all warnings being treated as errors
> 
> This patch removes the gcc switch to make W=1 work. Mips is the only
> architecture I know which does not build with W=1 and this upsets my aiaiai
> scripts. And in general, you never know which warnings newer versions of gcc
> will start emiting so having -Werror by default is not the best idea.

 If the function has no prototype, then it cannot be reasonably used from 
outside -- perhaps you meant to mark it static instead?

  Maciej
