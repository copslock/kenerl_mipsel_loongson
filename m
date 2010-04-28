Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 15:14:28 +0200 (CEST)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:63037 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492325Ab0D1NOY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 15:14:24 +0200
Received: by wwb24 with SMTP id 24so27053wwb.36
        for <multiple recipients>; Wed, 28 Apr 2010 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=SUJ88Z7gp0zd/VIcutveMhORY/8mdk5b6LvxZIksp2o=;
        b=gcKXN35BhhlyBWYu1svVdbB/Mudpnx7JwOrajF/sX4l7qepq6UYGATxJRDOwx8wmUr
         hqifwI4Zhj9l7/nivKqSbOZmfehl5OBgxBysFjTiy6Y3LIilUjRjpEfQRRPK/vPkih6b
         DsQuGs04GMnql04SIao1tCTGk+Ws4WUmL8s8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=waGszlmrJuLxx0IZY3lGJtBosfI/U5avlr1Y/97eDsFK4hOCpBXuGky4ChLqSFngNb
         vHKOy4aHwjnqTdiLnoEq6ih8MnhjxH2/Uyk0q0jodkskzj6Fz0rxlFmHICa/79EFsKz0
         219rdjt21bCL66eKqNhVA/2V0WRZmRrh81buQ=
Received: by 10.216.87.205 with SMTP id y55mr1042875wee.88.1272460457747;
        Wed, 28 Apr 2010 06:14:17 -0700 (PDT)
Received: from [192.168.2.210] ([202.201.14.140])
        by mx.google.com with ESMTPS id z34sm13813813wbv.20.2010.04.28.06.14.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Apr 2010 06:14:16 -0700 (PDT)
Subject: Re: [PATCH] Perf-tool/MIPS: support cross compiling of tools/perf
 for MIPS
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     ralf@linux-mips.org, ddaney@caviumnetworks.com,
        linux-mips@linux-mips.org
In-Reply-To: <1272455674-4725-1-git-send-email-dengcheng.zhu@gmail.com>
References: <1272455674-4725-1-git-send-email-dengcheng.zhu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Wed, 28 Apr 2010 21:14:07 +0800
Message-ID: <1272460447.21867.31.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26495
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2010-04-28 at 19:54 +0800, Deng-Cheng Zhu wrote:
> With the kernel facility of Linux performance counters, we want the user
> level tool tools/perf to be cross compiled for MIPS platform. To do this,
> we need to include unistd.h, add rmb() and cpu_relax() in perf.h.
> 

Just found local-compiling also need rmb().

BTW: for local-compiling in a debian linux on MIPS machines, we need to
copy linux-source-code/{tools/perf, include, lib} to the machine and
install libdw-dev and libelf-dev, so the basic procedure for making perf
work on a debian/MIPS:

0. prepare

For tools/perf

  copy the directory {tools/perf, include, lib} of linux
  $ apt-get install libdw-dev libelf-dev

For the kernel support

  apply deng-cheng's latest patch and ensure CONFIG_HW_PERF_EVENTS=y
  then boot into the new kernel.

1. compile tools/perf

$ ls
include lib tools
$ ls tools/
perf
$ cd tools/perf
$ make

2. usage

$ ./perf list

For a non-raw event

$ ./perf stat -e cycles ls -l

For a raw event

$ ./perf stat -e r120 ls -l

Regard,

> Your review comments are especially required for the definition of rmb():
> In perf.h, we need to have a proper rmb() for _all_ MIPS platforms. And
> we don't have CONFIG_* things for use in here. Looking at barrier.h,
> rmb() goes into barrier() and __sync() for CAVIUM OCTEON and other CPUs,
> respectively. What's more, __sync() has different versions as well.
> Referring to BARRIER() in dump_tlb.c, I propose the "common" definition
> for perf tool rmb() in this patch. Do you have any comments?
> 
> In addition, for testing the kernel part code I sent several days
> ago, I was using the "particular" rmb() version for 24K/34K/74K cores:
> 
> #define rmb()           asm volatile(                           \
>                                 ".set   push\n\t"               \
>                                 ".set   noreorder\n\t"          \
>                                 ".set   mips2\n\t"              \
>                                 "sync\n\t"                      \
>                                 ".set   pop"                    \
>                                 : /* no output */               \
>                                 : /* no input */                \
>                                 : "memory")
> 
> This is the definition of __sync() for CONFIG_CPU_HAS_SYNC.
> 
> 
> Thanks,
> 
> Deng-Cheng
> 
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
> ---
>  tools/perf/perf.h |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
> index 6fb379b..cd05284 100644
> --- a/tools/perf/perf.h
> +++ b/tools/perf/perf.h
> @@ -69,6 +69,18 @@
>  #define cpu_relax()	asm volatile("":::"memory")
>  #endif
>  
> +#ifdef __mips__
> +#include "../../arch/mips/include/asm/unistd.h"
> +#define rmb()		asm volatile(					\
> +				".set	noreorder\n\t"			\
> +				"nop;nop;nop;nop;nop;nop;nop\n\t"	\
> +				".set	reorder"			\
> +				: /* no output */			\
> +				: /* no input */			\
> +				: "memory")
> +#define cpu_relax()	asm volatile("" ::: "memory")
> +#endif
> +
>  #include <time.h>
>  #include <unistd.h>
>  #include <sys/types.h>
