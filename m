Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 16:21:39 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:58502 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492872AbZKPPVc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2009 16:21:32 +0100
Received: by pwi15 with SMTP id 15so3438975pwi.24
        for <multiple recipients>; Mon, 16 Nov 2009 07:21:23 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=qD2AajUsmqhtUTCf0p4LDlpx6y4SRgj+Z78WP62cjJA=;
        b=oR3iN7QMQvcKs0Y5QQ6b7nh3UpRiY4sNNhi6oXCICBiVIEcWQxhGytAnXspOyhp4BR
         VULkd8YlLPhEdnmP5enlz11GU4zXXIqk4qsV/r6KcYcxYL4xIp3qjt9EIwTi79X7z2o5
         JQfY8sE1ZWvq7p8Bz9QIPeC21iktKidbhbI5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=R5JEBSf3aZ0SChe1IcUpEcCX6b79HYiJ2qeqveam8KKOJIF1dY7lm6OGx/KnTXUD9/
         YffOBsWfhtO7YF1gI1McUSAyWy6KYpEND5mm0YDuPJVAo7sqljoiHxp0+DeDqe2w4HIM
         vxviFnV0pFB6RBWtRZ2b5ysGsYcYcH0qLUbfU=
Received: by 10.114.54.34 with SMTP id c34mr6755443waa.47.1258384883505;
        Mon, 16 Nov 2009 07:21:23 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1254858pxi.8.2009.11.16.07.21.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 07:21:22 -0800 (PST)
Subject: Re: [PATCH v8 01/16] tracing: convert trace_clock_local() as weak
 function
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Thomas Gleixner <tglx@linutronix.de>
Cc:	rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Michal Simek <monstr@monstr.eu>,
	"Maciej W . Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com
In-Reply-To: <alpine.LFD.2.00.0911161559280.24119@localhost.localdomain>
References: <cover.1258177321.git.wuzhangjin@gmail.com>
	 <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com>
	 <alpine.LFD.2.00.0911161559280.24119@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Mon, 16 Nov 2009 23:21:08 +0800
Message-ID: <1258384868.15821.9.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-11-16 at 16:07 +0100, Thomas Gleixner wrote:
> On Sat, 14 Nov 2009, Wu Zhangjin wrote:
> 
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > trace_clock_local() is based on the arch-specific sched_clock(), in X86,
> > it is tsc(64bit) based, which can give very high precision(about 1ns
> > with 1GHz). but in MIPS, the sched_clock() is jiffies based, which can
> > give only 10ms precison with 1000 HZ. which is not enough for tracing,
> > especially for Real Time system.
> > 
> > so, we need to implement a MIPS specific sched_clock() to get higher
> > precision. There is a tsc like clock counter register in MIPS, whose
> > frequency is half of the processor, so, if the cpu frequency is 800MHz,
> > the time precision reaches 2.5ns, which is very good for tracing, even
> > for Real Time system.
> > 
> > but 'Cause it is only 32bit long, which will rollover quickly, so, such
> > a sched_clock() will bring with extra load, which is not good for the
> > whole system. so, we only need to implement a arch-specific
> > trace_clock_local() for tracing. as a preparation, we convert it as a
> > weak function.
> 
> Hmm, I'm not convinced that this is really a huge overhead. 
> 
> First of all the rollover happens once every 10 seconds on a 800MHz
> machine. 
> 
> Secondly we have a lockless implementation of extending 32bit counters
> to 63 bit which is used at least by ARM to provide a high resolution
> sched_clock implementation. See include/linux/cnt32_63.h and the users
> in arch/
> 
> But that's a problem which can be discussed seperately and does not
> affect the rest of the tracing infrastructure. I really would
> recommend that you implement a sched_clock for the r4k machines based
> on cnt32_63 and measure the overhead. Having a fine granular
> sched_clock in general is probably not a bad thing.
> 

Thanks very much for your prompt, 

Will have a look at cnt32_to_63() in include/linux/cnt32_to_63.h later.

Thanks & Regards,
	Wu Zhangjin
