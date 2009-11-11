Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 14:52:23 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:50009 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492790AbZKKNwQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 14:52:16 +0100
Received: by pwi15 with SMTP id 15so707485pwi.24
        for <multiple recipients>; Wed, 11 Nov 2009 05:52:07 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=zXrDHWZ4417tnWwvfZTFEinXmI6csje3JgGTBSmY+10=;
        b=viZk4jlqkt1QmDM3sfJwidU6cnzDjAdIRIU+oxpJjTKv4m0JG740OIf13334nezCoY
         XIK6+Jhc93BOXVxPkHR5BYVaU8JaEvf3Z38qwfNjbiLMjc2EYPN9rglh6yRAK1e1WhgP
         sw8ttDK9d+u4ng1r08Ilwh0ht526djJE8WfcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=MBQG5lnLJ4E6JP9r+HkH8EBh4gcNusqVnMPaX3V+Q52sXKGRTtkvWP0+PGQwnNBMNb
         L1RwiEwuGPZ3y2WbGYHdnIeSAhxxH2kptzSrKhEKSmlX4t262WIq0dOtFV1Cdh0Jmhk5
         gOyrG4Z/cDMcg7O+XH2IBchI0oIeuVOtdaFvU=
Received: by 10.115.114.18 with SMTP id r18mr3313865wam.24.1257947527131;
        Wed, 11 Nov 2009 05:52:07 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm1028283pzk.4.2009.11.11.05.51.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 05:52:06 -0800 (PST)
Subject: Re: [PATCH v7 04/17] tracing: add static function tracer support
 for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, zhangfx@lemote.com, zhouqg@gmail.com,
	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
In-Reply-To: <alpine.LFD.2.00.0911111309170.10184@eddie.linux-mips.org>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>
	 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com>
	 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com>
	 <cefe074f5eb3cfbc2e0bb41b0c1f61fcd0190d90.1257779502.git.wuzhangjin@gmail.com>
	 <4AF8B31C.5030802@caviumnetworks.com>
	 <1257814817.2822.3.camel@falcon.domain.org>
	 <4AF99848.9090000@caviumnetworks.com>
	 <1257907351.2922.37.camel@falcon.domain.org>
	 <alpine.LFD.2.00.0911111309170.10184@eddie.linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 11 Nov 2009 21:51:53 +0800
Message-ID: <1257947513.7308.8.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Wed, 2009-11-11 at 13:15 +0000, Maciej W. Rozycki wrote:
> On Wed, 11 Nov 2009, Wu Zhangjin wrote:
> 
> > > -mlong-calls really degrades performance.  I have seen things like 6% 
> > > drop in network packet forwarding rates with -mlong-calls.
> > > 
> > 
> > so much drop? seems only two instructions added for it: lui, addi. from
> > this view point, I think the -fno-omit-frame-pointer(add, sd, move...)
> > will also bring with much drop.
> 
>  No, register jumps cannot be predicted -- this is where the performance 
> goes on any serious processor -- the two extra instructions are nothing 
> compared to that.  OTOH frame pointer calculations are pure arithmetic, so 
> you only lose time incurred by the instructions themselves.

Yes, I only mean the -mlong-calls and the original -mno-long-calls with
-pg.

The orignal one looks like this:

move ra, at
jal _mcount

The new one with -mlong-calls looks like this:

lui v1, HI_16BIT_OF_MCOUNT
addiu v1, v1, LOW_16BIT_OF_MCOUNT
move ra, at
jalr v1

both of them have a "jump" instruciton, so, only two lui, addiu added
for -mlong-calls ;)

what about the difference between that "jal _mcount"  and "jalr v1"?

Regards,
	Wu Zhangjin
