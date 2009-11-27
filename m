Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2009 04:06:11 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:54848 "EHLO
        mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493877AbZK0DGE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2009 04:06:04 +0100
Received: by pxi3 with SMTP id 3so875989pxi.22
        for <multiple recipients>; Thu, 26 Nov 2009 19:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=IfA+xRzsy8v5rTiU3S0PTpXA3Db5JrCmAeE2RJlwCuA=;
        b=T98hKnxluSha1BnMXg5xhUDbiWGRBSFsLZz/QUlSzIePJSlLacYi3SqrxHE3kwL0y8
         I5kiKA75l90svUSXMzxfhcIl6wycAXFGd47vGONogpvTDAPMbbliKl+bPWr7/rEnHRYS
         UFGl+Qq1eeKkFJuE8EgbqerWUVpzSO1rDbzHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Yo2LMCgfI1Z49dnZCZnVo09L2T47//QmRE16x66K871wUCMmit//WxG6EGBlYKtuVV
         tsQEzlx7OR+kC0SyLSNu/ozHS5G4eoAjbtgiUEGsAFPSS60tfKEUQEaYhGQTg9Pqh6dS
         3mD7MeWviZll84090cWG5flZc2hcmrUFyok78=
Received: by 10.114.215.6 with SMTP id n6mr890993wag.158.1259291157975;
        Thu, 26 Nov 2009 19:05:57 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm891963pzk.7.2009.11.26.19.05.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 19:05:57 -0800 (PST)
Subject: Re: [PATCH v5] MIPS: Add a high resolution sched_clock() via
 cnt32_to_63().
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>
In-Reply-To: <4B0EC5CB.5060701@ru.mvista.com>
References: <39b95d02b37cd75d275b231c31abb00aefda9078.1258972025.git.wuzhangjin@gmail.com>
         <4B0A8A0B.60405@ru.mvista.com>  <4B0EC5CB.5060701@ru.mvista.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 27 Nov 2009 11:05:34 +0800
Message-ID: <1259291134.3197.86.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-11-26 at 21:15 +0300, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> >> (This v5 revision incorporates with the feedbacks from Ingo.)
> 
> >> This patch adds a cnt32_to_63() and MIPS c0 count based sched_clock(),
> >> which provides high resolution. and also, one new kernel option
> >> (HR_SCHED_CLOCK) is added to enable/disable this sched_clock().
> 
> >> Without it, the Ftrace for MIPS will give useless timestamp information.
> 
> >> Because cnt32_to_63() needs to be called at least once per half period
> >> to work properly, Differ from the old version, this v2 revision set up a
> >> kernel timer to ensure the requirement of some MIPSs which have short c0
> >> count period.
> 
> >> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> >> diff --git a/arch/mips/kernel/csrc-r4k-hres.c 
> >> b/arch/mips/kernel/csrc-r4k-hres.c
> >> new file mode 100644
> >> index 0000000..2fe8be7
> >> --- /dev/null
> >> +++ b/arch/mips/kernel/csrc-r4k-hres.c
> > 
> > 
> >    I don't think this is really good name for this file (one might think 
> > that this is another implementation of clocksource instead of some 
> > sched_clock() code tied to this particular clocksource), and I don't 
> 
>     Seriously, if this file have to live a life of its own, name it like 
> sched-r4k.c but not the way you named it -- this is not another clocksource 
> module...
> 

Hello, Sergei Shtylyov, I will use hres_sched_clock.c instead of
sched-r4k.c, is it okay?

Hi, Ralf, which one will you apply? If hres_sched_clock.c is okay, I
will resend it asap.
 
Thakns & Regards,
	Wu Zhangjin
