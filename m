Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 18:54:35 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:39529 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492639Ab0EFQya (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 18:54:30 +0200
Received: by pxi1 with SMTP id 1so71635pxi.36
        for <multiple recipients>; Thu, 06 May 2010 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=3nx5AUqB8CiibyPqOU15BPwCbsDVJmHxsjGtA3EqHpw=;
        b=Uk8NhkgQHW7rfbm+c+BXiZpSPXJxMgT1GnH1ftXWHlQooMaw8OAi1eKthiRAQSic9+
         T27S2jz8h93iNRS2znmKCShTuKQXowRFamLXi8Z/VhllxZ4Hg4hKhAVGdmv5PNYhiQXB
         6LORsJQH2NgH5pY0sTN82h1HaHlGy/DXK5LTI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=fytqpxSFS909hmnziX1Dn/dEi8RB3+/rgaD9WkshrsCo9QkAmVmWrmJ+5EiGrRarFd
         E4shsWy2iLDnuRFZvAZ8Xbuvh4IqGuIycmzqfOhmQMt+1c8W6nEBRxX8OLGqf3AanwOn
         1yJfHuIoOPmQrv4ltFWSBoR5GYNL+jwAl5Qfw=
Received: by 10.114.187.37 with SMTP id k37mr2445929waf.37.1273164858961;
        Thu, 06 May 2010 09:54:18 -0700 (PDT)
Received: from [192.168.2.201] ([202.201.14.140])
        by mx.google.com with ESMTPS id c1sm5113308wam.19.2010.05.06.09.54.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 09:54:18 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] MIPS/Oprofile: extract PMU defines/helper
 functions for sharing
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com
In-Reply-To: <1273162909.23734.4.camel@localhost>
References: <1273067734-4758-1-git-send-email-dengcheng.zhu@gmail.com>
         <1273067734-4758-2-git-send-email-dengcheng.zhu@gmail.com>
         <1273162909.23734.4.camel@localhost>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 07 May 2010 00:54:12 +0800
Message-ID: <1273164852.23734.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2010-05-07 at 00:21 +0800, Wu Zhangjin wrote:
> Hi,
> 
> On Wed, 2010-05-05 at 21:55 +0800, Deng-Cheng Zhu wrote:
> > Moving performance counter/control defines/helper functions into a single
> > header file, so that software using the MIPS PMU can share the code.
> > 
> > Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
> > ---
> >  arch/mips/include/asm/pmu.h             |  244 +++++++++++++++++++++++++++++++
> >  arch/mips/oprofile/op_model_loongson2.c |   23 +---
> >  arch/mips/oprofile/op_model_mipsxx.c    |  164 +---------------------
> >  arch/mips/oprofile/op_model_rm9000.c    |   16 +--
> >  4 files changed, 247 insertions(+), 200 deletions(-)
> >  create mode 100644 arch/mips/include/asm/pmu.h
> > 
> > diff --git a/arch/mips/include/asm/pmu.h b/arch/mips/include/asm/pmu.h
> [...]
> > +
> > +#ifndef __MIPS_PMU_H__
> > +#define __MIPS_PMU_H__
> > +
> > +#if defined(CONFIG_CPU_MIPS32) || defined(CONFIG_CPU_MIPS64) || \
> > +    defined(CONFIG_CPU_R10000) || defined(CONFIG_CPU_SB1)
> [...]
> > +static int (*save_perf_irq)(void);
> 
> For we will use the save_perf_irq in the common function:
> mipspmu_get_irq() of the next patch, so, we need to move the definition
> of it out of the #if ... and put it before the #if:
> 
> ...
> +static int (*save_perf_irq)(void);
> 
> #if defined(CONFIG_CPU_MIPS32)
> ...

oh, no, For Oprofile not use it, we can define it before
mipspmu_get_irq() directly.

> 
> Regards,
> 	Wu Zhangjin
