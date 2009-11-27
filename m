Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2009 02:10:13 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:42388 "EHLO
        mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493858AbZK0BKK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2009 02:10:10 +0100
Received: by gxk2 with SMTP id 2so474046gxk.4
        for <multiple recipients>; Thu, 26 Nov 2009 17:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Rg+pFBIQJh31MVwBmgCE44rZDMyH0+t6iZzAbnIFBWU=;
        b=NIKmIh7GDZoEkddPBakcPh2SzHr1EgYl/VGLloIPnNsFrBQM8K5qmGz1fOIZHjB21y
         zqBCSNZluWbD1nuXl77qqrUwbuKx9eknOEl8xlFkDdd/7YTLs9ekKrvng0UpgAlb0k1Z
         bE4/XAFB2ALRNPai2/oAbKjPwwRJiuc9Q9FbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=b6k/3BI05oO/OHbqj+G7ihUyxIbxByGwckdZLeDuaRyBw6ZUj13feNnuHBVzbKHQiy
         pGFHwOhJ7xh4CJmj3z7rABfooSsXGJ6u2p/eymhS3/xW439jjJ8BqkRCKb2zwPRYBpjb
         LgH2xfJlZcMs+YkSrBU217m7gzviyhFReLjmI=
Received: by 10.90.180.16 with SMTP id c16mr746690agf.15.1259284204190;
        Thu, 26 Nov 2009 17:10:04 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 39sm587297yxd.9.2009.11.26.17.09.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Nov 2009 17:10:03 -0800 (PST)
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
Date:   Fri, 27 Nov 2009 09:07:15 +0800
Message-ID: <1259284035.1936.3.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25163
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
> WBR, Sergei

okay, later.

Thanks,
	Wu Zhangjin
