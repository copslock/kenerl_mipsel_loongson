Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Dec 2012 12:42:30 +0100 (CET)
Received: from mail.nanl.de ([217.115.11.12]:58265 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823018Ab2LPLm3w4ZAB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 16 Dec 2012 12:42:29 +0100
Received: from mail-oa0-f49.google.com (mail-oa0-f49.google.com [209.85.219.49])
        by mail.nanl.de (Postfix) with ESMTPSA id B97EE40572;
        Sun, 16 Dec 2012 11:41:49 +0000 (UTC)
Received: by mail-oa0-f49.google.com with SMTP id l10so5108719oag.36
        for <multiple recipients>; Sun, 16 Dec 2012 03:42:25 -0800 (PST)
Received: by 10.60.0.165 with SMTP id 5mr9214289oef.128.1355658145159; Sun, 16
 Dec 2012 03:42:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.28.70 with HTTP; Sun, 16 Dec 2012 03:42:05 -0800 (PST)
In-Reply-To: <1355547967-13779-1-git-send-email-sjhill@mips.com>
References: <1355547967-13779-1-git-send-email-sjhill@mips.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sun, 16 Dec 2012 12:42:05 +0100
Message-ID: <CAOiHx==V+owqPzFRgSYqz2VYtQoq8XevpJgfmwQLyxdLZ-52qQ@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: dsp: Add assembler support for DSP ASEs.
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 15 December 2012 06:06, Steven J. Hill <sjhill@mips.com> wrote:
> (snip)
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 33a96a9..c3c8cba 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -98,4 +98,31 @@ obj-$(CONFIG_HW_PERF_EVENTS) += perf_event_mipsxx.o
>
>  obj-$(CONFIG_JUMP_LABEL)       += jump_label.o
>
> +#
> +# DSP ASE supported for MIPS32 or MIPS64 Release 2 cores only
> +#
> +ifeq ($(CONFIG_CPU_MIPSR2), y)
> +CFLAGS_DSP                     = -DHAVE_AS_DSP

24K (non-E) is MIPS32r2, but not not implement any DSP ASEs, is this a
problem here?


Jonas
