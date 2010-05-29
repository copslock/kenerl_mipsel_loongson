Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2010 05:06:16 +0200 (CEST)
Received: from mail-yw0-f201.google.com ([209.85.211.201]:47381 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab0E2DGN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 May 2010 05:06:13 +0200
Received: by ywh39 with SMTP id 39so1498811ywh.21
        for <multiple recipients>; Fri, 28 May 2010 20:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=I/lR0JlmGPPUr3cWle8YNlJtm5k6bxlsu8HwB/xb7Qg=;
        b=JnA6dYlZ1O5Wo6AXnOEet1xTipQo33YUAEQsvaC3LVoCd9N4S+ZCnWEvlHlHy83KAN
         NJEq2RWxWG7VXECeIDBZpyLHDtBDfQCo4dNL87RhkbYWLelPHifnu+mMxxH1QOPDxTef
         O5shGKg/YF76bUqnBf6wuf8uxt99L3VlNteaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VXIPc3cSQOdJOOw/wiFqetgBF6hwFp70aSpLNtBAUlmq+d9PQpHHirSj3UDy84kPVa
         hGQYsLa/bTAnLPqArlD6HrF8zcx2dkiYFOw2N9IVk9sBnSZqI9VfnPpfWo8SG5RRcppE
         IzaDfat5M159D8LcdZVVsjpIeVQJByMrHzirs=
MIME-Version: 1.0
Received: by 10.150.254.7 with SMTP id b7mr2536818ybi.293.1275102365290; Fri, 
        28 May 2010 20:06:05 -0700 (PDT)
Received: by 10.150.157.8 with HTTP; Fri, 28 May 2010 20:06:05 -0700 (PDT)
In-Reply-To: <4BFEE8B6.6040605@gmail.com>
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>
        <1274965420-5091-2-git-send-email-dengcheng.zhu@gmail.com>
        <4BFEE8B6.6040605@gmail.com>
Date:   Sat, 29 May 2010 11:06:05 +0800
Message-ID: <AANLkTilx-yMwFE0cj3jQu1BZEx_XW2_sj-lRAfzNO88o@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] MIPS/Oprofile: extract PMU defines/helper 
        functions for sharing
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     David Daney <david.s.daney@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, David


Thanks for your comments! I'm replying to you in the patch order. If my
comments are wrong or are bad ideas, please point out.


2010/5/28 David Daney <david.s.daney@gmail.com>:
> Why predicate the entire contents of the file?
>
> In any event, if you keep it, it shold probably be something like:
>
>    #if defined(CONFIG_CPU_MIPSR1) || defined(CONFIG_CPU_MIPSR2)
[DC]:
1) This line is not for the "entire" contents of the file, other CPUs
LOONGSON2 and RM9000 are here.
2) The CONFIG_CPU* came from the Makefile of oprofile. If other CPUs are
newly supported, we can add into the #if #elif.
3) The perf counter helper functions are special to mipsxx/loongson2/rm9000
espcially the reset_counter() will be implemented respectively. Although
they will be moved to perf_event_$cpu.c when Oprofile uses Perf-events as
backend, they are currently shared by Oprofile and Perf-events to reduce
code copying.


> Some or all of that should probably go in asm/mipsregs.h
[DC]: Now that we create pmu.h and these #define's are originally in
op_model_$cpu.c not in mipsregs.h, how about keeping them here? BTW, after
making Oprofile use Perf-events as backend (patches 8~12 do this), pmu.h
will only contain register definitions (no static function definitions),
then we can consider deleting pmu.h and moving its contents to mipsregs.h,
is it OK?


> Are 0 and 1 really the only conceivable values?
[DC]: This is also from Oprofile. If we use:
#define vpe_id()       (cpu_has_mipsmt_pertccounters ? \
                       0 : cpu_data[smp_processor_id()].vpe_id)
The possible return value is supposed to be 0 or 1.


Deng-Cheng
