Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Sep 2011 04:50:14 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:58014 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490953Ab1IXCuH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Sep 2011 04:50:07 +0200
Received: by yxi11 with SMTP id 11so3760837yxi.36
        for <multiple recipients>; Fri, 23 Sep 2011 19:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BgqOJk7VdvwbOdYw2f/CKitPfbD33WUhDiB1ZMiNmqc=;
        b=X+2JKURbVmIG9yXFcQSTL5lT8g+b3tTeOUfLSBJck1nWyS4wItd2VF54/4rc8p8SZk
         WMQ9rKRcgWztlGec45+B0JlT3BOi3pgumtS13lPBBHaA1TgGoACj4sUEyQA8xO88Khck
         TbF1kb+l5Q8dgFwg9dEEDmIC3Xke7vBXHPPNU=
MIME-Version: 1.0
Received: by 10.236.129.165 with SMTP id h25mr25814973yhi.38.1316832601686;
 Fri, 23 Sep 2011 19:50:01 -0700 (PDT)
Received: by 10.236.69.232 with HTTP; Fri, 23 Sep 2011 19:50:01 -0700 (PDT)
In-Reply-To: <1316712378-7282-4-git-send-email-david.daney@cavium.com>
References: <1316712378-7282-1-git-send-email-david.daney@cavium.com>
        <1316712378-7282-4-git-send-email-david.daney@cavium.com>
Date:   Sat, 24 Sep 2011 10:50:01 +0800
Message-ID: <CAOfQC98+G6Ar8RAT8697GS3MMhEQH86WSyrGjPAo4ELMCWzJHw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] MIPS: perf: Reorganize contents of perf support files.
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dezhong Diao <dediao@cisco.com>,
        Gabor Juhos <juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 31145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13761

2011/9/23 David Daney <david.daney@cavium.com>
>
> The contents of arch/mips/kernel/perf_event.c and
> arch/mips/kernel/perf_event_mipsxx.c were divided in a seemingly ad
> hoc manner, with the first including the second.
>
> I moved all the hardware counter support code to perf_event_mipsxx.c
> and removed the gating #ifdefs to the Kconfig and Makefile.
>
> Now perf_event.c contains only the callchain support, everything else
> is in perf_event_mipsxx.c
>

Sorry for my late comment. I personally don't think it's a bad idea to
use the original gating #ifdefs, because it allows sharing common code
among different types of MIPS PMUs. Also, using CPU types as compiling
conditions seems make sense. If you move the common hunk to
perf_event_mipsxx.c, other CPUs like loognson series will have to duplicate
these stuff.


Deng-Cheng
