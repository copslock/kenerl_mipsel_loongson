Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 05:30:11 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:41476 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490969Ab0D2DaH convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Apr 2010 05:30:07 +0200
Received: by gyb11 with SMTP id 11so7823196gyb.36
        for <multiple recipients>; Wed, 28 Apr 2010 20:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5sVHpaFvDyDd6bGSYtOV5jdKHIf8gWA3MmPCnC6b4jQ=;
        b=xsaZ7RzHGYWEp7p0qrsrRIDnDz08qtDQEIcNwUmmnTDmxXfsS90efaRRV6ZVkXwYx5
         nF104g8CyyTc0Rb2jgmi8sJONNEp+O7Kkiz4y6Ct5OaOvBlj7f8gNbzmPQUivJ8gvNpG
         jBoJURSiyeY4NnhaSGVbmCv2MKwlkfOEVVy08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jVMlM/5yLNMNR4PqIj6X52ozgK7zWyiMkDrvXqV67kV/t4a/jeu7tU96nnymIBRQr0
         TUVLeDlCTyFAl3hJOTP8ysdaetk/ZuyGoAnGIVpHA1+DyBF7KDAxNUAS8VUd9i38yuXU
         TBGhJsW1G3pAes1AqaXWJ7VIKY+bWEbHDdZVA=
MIME-Version: 1.0
Received: by 10.150.118.14 with SMTP id q14mr995843ybc.291.1272511800013; Wed, 
        28 Apr 2010 20:30:00 -0700 (PDT)
Received: by 10.150.122.11 with HTTP; Wed, 28 Apr 2010 20:29:59 -0700 (PDT)
In-Reply-To: <1272468077-12292-1-git-send-email-wuzhangjin@gmail.com>
References: <1272468077-12292-1-git-send-email-wuzhangjin@gmail.com>
Date:   Thu, 29 Apr 2010 11:29:59 +0800
Message-ID: <o2h1b4d75291004282029m19d46c01hb44bab3893395bae@mail.gmail.com>
Subject: Re: [PATCH] Loongson2: add a primary perf support (not applicable)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     loongson-dev <loongson-dev@googlegroups.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        Zhang Le <r0bertz@gentoo.org>, yajin <yajinzhou@vm-kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

> And then you need to compile the user-space tools/perf with the following steps
> if want to local-compile it:

And if you want to cross compile it, besides changing
tools/perf/perf.h, tools/perf/Makefile also needs to have proper
CFLAGS/LDFLAGS for headers and libs. Then it's OK to fire "make
CROSS_COMPILE=$toolchain_prefix".

> Currently, seems "./perf record" and lots of software events not work, anybody
> have interest in playing with it can refer to {tools/perf/Documentation,
> arch/mips/kernel/perf_event*, arch/mips/include/asm/pmu.h,
> arch/x86/kernel/cpu/perf_event*, arch/arm/kernel/perf_event* ...}.

"perf record" works fine on 24K/34K/74K cores. In addition, If you are
seeing the message "Couldn't record kernel reference relocation
symbol", and your kernel symbols only have _stext (without _text),
then search "_text" in builtin-record.c and replace with "_stext".
Here is the link: http://lkml.org/lkml/2010/1/18/177

For software events, it should be able to work without specific
changes for loongson, I suppose. Because changes have been done to
common MIPS code to support software events.

>  config HW_PERF_EVENTS
>        bool "Enable hardware performance counter support for perf events"
> -       depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n && CPU_MIPS32
> +       depends on PERF_EVENTS && !MIPS_MT_SMTC && OPROFILE=n
>        default y
>        help
>          Enable hardware performance counter support for perf events. If

How about adding CPU_LOONGSON2* instead of deleting CPU_MIPS32?
Because we want the perf functionality to be available when we are
able to choose it..
