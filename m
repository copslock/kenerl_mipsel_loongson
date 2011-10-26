Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2011 09:34:27 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46937 "EHLO
        opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490955Ab1JZHeT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Oct 2011 09:34:19 +0200
Received: from finisterre.wolfsonmicro.main (unknown [85.13.70.251])
        by opensource.wolfsonmicro.com (Postfix) with ESMTPSA id 13E91110511;
        Wed, 26 Oct 2011 08:34:13 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.76)
        (envelope-from <broonie@opensource.wolfsonmicro.com>)
        id 1RIxzj-0000oB-5F; Wed, 26 Oct 2011 09:33:51 +0200
Date:   Wed, 26 Oct 2011 09:33:50 +0200
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Mike Frysinger <vapier@gentoo.org>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Grant Likely <grant.likely@secretlab.ca>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
Message-ID: <20111026073348.GB2915@opensource.wolfsonmicro.com>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAJaTeTp2w85UHnmH-PPMZsQGQMNa-93kw-tjmDxA_wjJXkYQcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJaTeTp2w85UHnmH-PPMZsQGQMNa-93kw-tjmDxA_wjJXkYQcQ@mail.gmail.com>
X-Cookie: You will be divorced within a year.
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31306
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18699

On Tue, Oct 25, 2011 at 07:44:14PM -0400, Mike Frysinger wrote:

> i don't think this is generally how asm-generic is handled.  instead, how about:
>  - move the duplicate code to asm-generic/gpio.h
>  - have the arches which merely need asm-generic/gpio.h add "generic-y
> += gpio.h" to their include/asm/Kbuild
>  - for arches which need to override these common funcs in some way,
> add #ifdef protection to the asm-generic/gpio.h

> and it seems like with slightly more work, this path allow you to
> merge most of arch/sh/include/asm/gpio.h.  and it has the advantage of
> not needing new Kconfig symbols.

That's really not how gpiolib is currently handled, unfortunately -
trying to transition over to that model in one patch would be way too
much.  

The goal here from that point of view is to make transitioning to
something more sensible easier by getting rid of the boilerplate code,
it makes doing the more invasive changes like you're suggesting much
easier as we're only dealing with the architectures that are actually
doing something.  It also means that we're able to immediately work on
turning on gpiolib on random architectures which is a definite win.
