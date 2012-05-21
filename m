Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 20:15:43 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:41433 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903564Ab2EUSPj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 May 2012 20:15:39 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q4LIFbw1013996;
        Mon, 21 May 2012 19:15:37 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q4LIFa2X013978;
        Mon, 21 May 2012 19:15:36 +0100
Date:   Mon, 21 May 2012 19:15:36 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH 2/2] MIPS: bcm63xx: kbuild: remove -Werror
Message-ID: <20120521181536.GD15443@linux-mips.org>
References: <1335534510-12573-1-git-send-email-dedekind1@gmail.com>
 <1335534510-12573-2-git-send-email-dedekind1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1335534510-12573-2-git-send-email-dedekind1@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Apr 27, 2012 at 04:48:30PM +0300, Artem Bityutskiy wrote:

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
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  arch/mips/bcm63xx/boards/Makefile |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/bcm63xx/boards/Makefile b/arch/mips/bcm63xx/boards/Makefile
> index 9f64fb4..af07c1a 100644
> --- a/arch/mips/bcm63xx/boards/Makefile
> +++ b/arch/mips/bcm63xx/boards/Makefile
> @@ -1,3 +1 @@
>  obj-$(CONFIG_BOARD_BCM963XX)		+= board_bcm963xx.o
> -
> -ccflags-y := -Werror

There's been a whole bunch of other -Werrors below arch/mips some of
which even were combined with -Wall.  I removed all off them except the
central -Werror in arch/mips/Kbuild.  I'm pondering a better solution
for that one now.

  Ralf
