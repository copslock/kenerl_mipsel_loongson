Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2011 01:44:48 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:38862 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491139Ab1JYXok (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Oct 2011 01:44:40 +0200
Received: by iagz35 with SMTP id z35so1388580iag.36
        for <multiple recipients>; Tue, 25 Oct 2011 16:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=EB60+bydwMo+4xJ2p0A09rShn92azJjSO0PkdXv5EPY=;
        b=h0rX5NBSB/sBbFMpNOw1D8WLFzFV2x0RclnoCm/g5VBYPr4Ig3IDRiLlg+UrXeLEHT
         pUtlA3lBmqHokkWEyEMWY4U6G9AJ3HSpA0QIxowPQskG8nD3lUW0gcSilH/KSBKYUbvS
         XbHIMQ3CacA7/qGVffIfRFcIdN7A3s9paMRao=
Received: by 10.42.132.10 with SMTP id b10mr47706925ict.18.1319586274213; Tue,
 25 Oct 2011 16:44:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.203.74 with HTTP; Tue, 25 Oct 2011 16:44:14 -0700 (PDT)
In-Reply-To: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
From:   Mike Frysinger <vapier@gentoo.org>
Date:   Tue, 25 Oct 2011 19:44:14 -0400
X-Google-Sender-Auth: LMr4bVRSB-8Ew7ws3UQ_80sfyZk
Message-ID: <CAJaTeTp2w85UHnmH-PPMZsQGQMNa-93kw-tjmDxA_wjJXkYQcQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
To:     Mark Brown <broonie@opensource.wolfsonmicro.com>
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
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18537

On Tue, Oct 25, 2011 at 03:33, Mark Brown wrote:
> Rather than requiring architectures that use gpiolib but don't have any
> need to define anything custom to copy an asm/gpio.h provide a Kconfig
> symbol which architectures must select in order to include gpio.h and
> for other architectures just provide the trivial implementation directly.

i don't think this is generally how asm-generic is handled.  instead, how about:
 - move the duplicate code to asm-generic/gpio.h
 - have the arches which merely need asm-generic/gpio.h add "generic-y
+= gpio.h" to their include/asm/Kbuild
 - for arches which need to override these common funcs in some way,
add #ifdef protection to the asm-generic/gpio.h

and it seems like with slightly more work, this path allow you to
merge most of arch/sh/include/asm/gpio.h.  and it has the advantage of
not needing new Kconfig symbols.

for example, with asm-generic/atomic.h, it does:
#ifndef atomic_sub_return
static inline int atomic_sub_return(int i, atomic_t *v)
{ ... common implementation ... }
#endif

and then any arch that wants to override it does:
#define atomic_sub_return atomic_sub_return
static inline int atomic_sub_return(int i, atomic_t *v) { weirdness }
#include <asm-generic/atomic.h>
-mike
