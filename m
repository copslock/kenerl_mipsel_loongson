Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2009 09:35:34 +0100 (CET)
Received: from mail-px0-f173.google.com ([209.85.216.173]:33517 "EHLO
        mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492190AbZK0Ifa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2009 09:35:30 +0100
Received: by pxi3 with SMTP id 3so1011919pxi.22
        for <multiple recipients>; Fri, 27 Nov 2009 00:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=bLm9EbdKoVv8/atLqy/5Stm6kYNfQwf26RaT+Ux9BKo=;
        b=o8OIq6dHsTgI6Ptr2LxZpUeOwxyRvoz2QYxwumoA3FEm9dm6iWjTB4geOAwd+S5wmG
         4ELJtO0VnRmwMGHAV8Y+xqIIWuNbm3VOTqZKSXz7wrFfhGrjHmwgHdwYz3Yqgp49oRkm
         9S3AI8zO1qoA8atzrG2H3HVjvDFw1GXT8VopA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=IO1X912BqL5sF719tfAADF6I9OlFz7dEdSRBidTkYLjE+AH+2z2fv8eXKBIlR2xg36
         CyVCrcBMphE3lIDZ08DuVQcFMdlMt7NgFLHALBY8GyeeV2PanhXqmHf2yFyECvr080kZ
         4cgRfc2cXlqfUY039GplTr1EqcZVcBr90fAEk=
Received: by 10.114.18.37 with SMTP id 37mr1514291war.143.1259310923028;
        Fri, 27 Nov 2009 00:35:23 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1077579pxi.8.2009.11.27.00.35.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 00:35:22 -0800 (PST)
Subject: Re: [PATCH v5] MIPS: Add a high resolution sched_clock() via
 cnt32_to_63().
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <david.s.daney@gmail.com>,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        Ingo Molnar <mingo@elte.hu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Michal Simek <monstr@monstr.eu>
In-Reply-To: <4B0F595C.5000204@gmail.com>
References: <39b95d02b37cd75d275b231c31abb00aefda9078.1258972025.git.wuzhangjin@gmail.com>
         <4B0A8A0B.60405@ru.mvista.com>  <4B0EC5CB.5060701@ru.mvista.com>
         <1259291134.3197.86.camel@falcon.domain.org>  <4B0F595C.5000204@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 27 Nov 2009 16:35:02 +0800
Message-ID: <1259310902.3197.97.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Ralf

This patch is not applicable, please ignore it!

Thanks!
	Wu Zhangjin

On Thu, 2009-11-26 at 20:45 -0800, David Daney wrote:
> On 11/26/2009 07:05 PM, Wu Zhangjin wrote:
> > On Thu, 2009-11-26 at 21:15 +0300, Sergei Shtylyov wrote:
> [...]
> >>>
> >>>     I don't think this is really good name for this file (one might think
> >>> that this is another implementation of clocksource instead of some
> >>> sched_clock() code tied to this particular clocksource), and I don't
> >>>        
> >>      Seriously, if this file have to live a life of its own, name it like
> >> sched-r4k.c but not the way you named it -- this is not another clocksource
> >> module...
> >>
> >>      
> > Hello, Sergei Shtylyov, I will use hres_sched_clock.c instead of
> > sched-r4k.c, is it okay?
> >
> > Hi, Ralf, which one will you apply? If hres_sched_clock.c is okay, I
> > will resend it asap.
> >    
> 
> Like Sergei, I think putting this in a seperate file is a bad idea.  
> This sched_clock is just a slightly different view of the csrc-r4k.c  
> put it in there.
> 
> Octeon has its own clock source (cavium-octeon/scrc-octeon.c) and 
> doesn't use csrc-r4k, so if you put it in a seperate file, there will 
> have to be makefile hackery to keep this thing out of an octeon kernel.
> 
> When and if you add this to csrc-r4k, I will submit the patch (already 
> written) that adds a high resolution sched_clock() to csrc-octeon.c.
> 
> Thanks,
> David Daney
> 
> 
> 
> 
