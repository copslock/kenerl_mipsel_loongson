Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 12:24:43 +0200 (CEST)
Received: from mail-gx0-f228.google.com ([209.85.217.228]:51098 "EHLO
        mail-gx0-f228.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492434Ab0D2KYk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 12:24:40 +0200
Received: by gxk28 with SMTP id 28so67505gxk.7
        for <multiple recipients>; Thu, 29 Apr 2010 03:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=eFmv7vlTv7r8aHuvn1l3Qj2cfeaAKM4+5N+OlxeymLw=;
        b=A50O7CNRiL5Xlo+9lhVhonpn7dqfAJNuQo6FAbX2kOduNBeK3tvc9s4BDBu996yJ51
         TZPQmn76CQUJRqc6KoHhjZVmo1XF1IBzV4sw14ruaRzkBguhHl33iFCr97vZdDLLKYaL
         DL7lP1HTtzdoVT/4KSm7KEf7p68onQfp0CbS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OD3+dFk67do1HLioL47/PeoKrszbHRBqVCxnNwGO2AZP9nMyHjbWGVfCM9sc9IABk1
         B4KOm9TMPKrqPYbLTQRIfed9QLkbOQAL/uRTVREKr8AWn7mFpsym/V5Xyain0AXlJnMP
         0OC7dcTnN44ee1/WI/iG23m3XFrT440SmK2WE=
MIME-Version: 1.0
Received: by 10.151.59.18 with SMTP id m18mr746133ybk.194.1272536672852; Thu, 
        29 Apr 2010 03:24:32 -0700 (PDT)
Received: by 10.150.122.11 with HTTP; Thu, 29 Apr 2010 03:24:32 -0700 (PDT)
In-Reply-To: <1272514212.24709.18.camel@localhost>
References: <1272468077-12292-1-git-send-email-wuzhangjin@gmail.com>
         <o2h1b4d75291004282029m19d46c01hb44bab3893395bae@mail.gmail.com>
         <1272514212.24709.18.camel@localhost>
Date:   Thu, 29 Apr 2010 18:24:32 +0800
Message-ID: <m2x1b4d75291004290324t37d6cffz2b4acc02ad199b13@mail.gmail.com>
Subject: Re: [PATCH] Loongson2: add a primary perf support (not applicable)
From:   Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
To:     wuzhangjin@gmail.com
Cc:     loongson-dev <loongson-dev@googlegroups.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        Zhang Le <r0bertz@gentoo.org>, yajin <yajinzhou@vm-kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dengcheng.zhu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@gmail.com
Precedence: bulk
X-list: linux-mips

> BTW: After comparing this patch and your
> arch/mips/kernel/perf_event_mipsxx.c, perhaps we can share more common
> functions, such as hw_perf_event_destroy(), hw_perf_enable(),
> hw_perf_disable() and handle_associated_event()...
hw_perf_event_destroy(): OK, if reset_counters() will be also
implemented in non-mipsxx.
hw_perf_enable()/hw_perf_disable(): OK. Initially I thought there
could be different implementations for these 2 functions in non-mipsxx
depending on the very different perf control regs and the use of
saved_ctrl. But you are right, we can, and had better to move these
up.
handle_associated_event(): OK.

Thanks! I'll apply these in v3.
