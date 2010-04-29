Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 06:10:32 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:62789 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491070Ab0D2EK3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 06:10:29 +0200
Received: by gwb1 with SMTP id 1so1617817gwb.36
        for <multiple recipients>; Wed, 28 Apr 2010 21:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=IhCsiiKJ05RN0cDEMZaohgaG3HpfFJOruHf+MvGA/T4=;
        b=FrGZ8CJ1M72/eS3jNpM10inuv7ldKJxG7e1edLbzJq8nHIbqlHK7/sQb43zrMM0teR
         ezo7/Csz2Wn4bZ6WmThcDZNRiWnRv4Fua8wBz5TGHF+Sx8fRPd4yfr1qS7frX/wGxSf3
         fA1x7ey6l41Gk/gn77VSl/lywDPmbt8eGGWOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=mqN54XRC6BF/bPGB+SOuYIuYsOG5MaIauHDdKp29PyrvfSy/pLcxlesawYvKY24ftF
         ozr4Q9yAM10zz+Rf5N0eCaAcx82L7IZt9OOotB65sZ+DI98TGSfJzXYkcorbw6RBwed2
         zOLVWsJc/DewBNpMVbVhRQI3h12orD/zK6bu0=
Received: by 10.150.159.11 with SMTP id h11mr118241ybe.62.1272514222989;
        Wed, 28 Apr 2010 21:10:22 -0700 (PDT)
Received: from [192.168.2.218] ([202.201.14.140])
        by mx.google.com with ESMTPS id 16sm298603gxk.5.2010.04.28.21.10.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Apr 2010 21:10:21 -0700 (PDT)
Subject: Re: [PATCH] Loongson2: add a primary perf support (not applicable)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
Cc:     loongson-dev <loongson-dev@googlegroups.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        Zhang Le <r0bertz@gentoo.org>, yajin <yajinzhou@vm-kernel.org>
In-Reply-To: <o2h1b4d75291004282029m19d46c01hb44bab3893395bae@mail.gmail.com>
References: <1272468077-12292-1-git-send-email-wuzhangjin@gmail.com>
         <o2h1b4d75291004282029m19d46c01hb44bab3893395bae@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 29 Apr 2010 12:10:12 +0800
Message-ID: <1272514212.24709.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2010-04-29 at 11:29 +0800, Deng-Cheng Zhu wrote:
> > And then you need to compile the user-space tools/perf with the following steps
> > if want to local-compile it:
> 
> And if you want to cross compile it, besides changing
> tools/perf/perf.h, tools/perf/Makefile also needs to have proper
> CFLAGS/LDFLAGS for headers and libs. Then it's OK to fire "make
> CROSS_COMPILE=$toolchain_prefix".
> 
> > Currently, seems "./perf record" and lots of software events not work, anybody
> > have interest in playing with it can refer to {tools/perf/Documentation,
> > arch/mips/kernel/perf_event*, arch/mips/include/asm/pmu.h,
> > arch/x86/kernel/cpu/perf_event*, arch/arm/kernel/perf_event* ...}.
> 
> "perf record" works fine on 24K/34K/74K cores. In addition, If you are
> seeing the message "Couldn't record kernel reference relocation
> symbol", and your kernel symbols only have _stext (without _text),
> then search "_text" in builtin-record.c and replace with "_stext".
> Here is the link: http://lkml.org/lkml/2010/1/18/177

Yeah, I have seen the message but have not looked into it, thanks!

> 
> For software events, it should be able to work without specific
> changes for loongson, I suppose. Because changes have been done to
> common MIPS code to support software events.
> 

Perhaps need to enable some related kernel options for the "kmem:..." is
not in the result of "./perf list", I will check it later.

> >  config HW_PERF_EVENTS
> >        bool "Enable hardware performance counter support for perf events"
> > -       depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n && CPU_MIPS32
> > +       depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n
> >        default y
> >        help
> >          Enable hardware performance counter support for perf events. If
> 
> How about adding CPU_LOONGSON2* instead of deleting CPU_MIPS32?
> Because we want the perf functionality to be available when we are
> able to choose it..

Okay, will apply it in the next revision.

BTW: After comparing this patch and your
arch/mips/kernel/perf_event_mipsxx.c, perhaps we can share more common
functions, such as hw_perf_event_destroy(), hw_perf_enable(),
hw_perf_disable() and handle_associated_event()...

Thanks & Regards,
	Wu Zhangjin
