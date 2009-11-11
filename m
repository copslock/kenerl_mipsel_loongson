Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 15:27:37 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:58125 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492744AbZKKO1a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 15:27:30 +0100
Received: by pxi6 with SMTP id 6so1088859pxi.0
        for <multiple recipients>; Wed, 11 Nov 2009 06:27:23 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=AgS6PVZy+E4UNm0+XbYCvvArXUU2YEO7bhkvRKMihT4=;
        b=bEz6LFtLVRSLwNGW6Uivq+SKTT9MoE+X/WKyPFInJhesCF4t3EXziEuA7HF2OfW4X5
         8eMvRjfu1B1BfTHoKtqeF/EvIgomndQ3VpTGkU+CSIcoTZjcXFB3u/rLbATolEtEID3P
         2xNWZf1FNyGnJ9QeZ5MiiqlZLj1E8kqlu2SCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=s+S9NahehyCdzkDzES46rgVcV7/uvUs3lEaaspkxvHpL9hAY2aP93qPsJ+RJMkuZ07
         waZJJ9J6OY3s/P5RavMP8jiyR8c3ThO7sVYmQJl++qNOtHBF+TzAD8nDFnlShPEov0l9
         rjtBSj9vwFHBETkzWhIQJ9QW1gUGy6yjslFGY=
Received: by 10.115.85.16 with SMTP id n16mr3333322wal.123.1257949643589;
        Wed, 11 Nov 2009 06:27:23 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1040577pzk.3.2009.11.11.06.27.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 06:27:22 -0800 (PST)
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
In-Reply-To: <alpine.LFD.2.00.0911111413560.10184@eddie.linux-mips.org>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>
	 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com>
	 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com>
	 <cefe074f5eb3cfbc2e0bb41b0c1f61fcd0190d90.1257779502.git.wuzhangjin@gmail.com>
	 <4AF8B31C.5030802@caviumnetworks.com>
	 <1257814817.2822.3.camel@falcon.domain.org>
	 <4AF99848.9090000@caviumnetworks.com>
	 <1257907351.2922.37.camel@falcon.domain.org>
	 <alpine.LFD.2.00.0911111309170.10184@eddie.linux-mips.org>
	 <1257947513.7308.8.camel@falcon.domain.org>
	 <alpine.LFD.2.00.0911111413560.10184@eddie.linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 11 Nov 2009 22:27:13 +0800
Message-ID: <1257949633.7308.20.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-11-11 at 14:18 +0000, Maciej W. Rozycki wrote:
> On Wed, 11 Nov 2009, Wu Zhangjin wrote:
> 
> > >  No, register jumps cannot be predicted -- this is where the performance 
> > > goes on any serious processor -- the two extra instructions are nothing 
> > > compared to that.  OTOH frame pointer calculations are pure arithmetic, so 
> > > you only lose time incurred by the instructions themselves.
> > 
> > Yes, I only mean the -mlong-calls and the original -mno-long-calls with
> > -pg.
> > 
> > The orignal one looks like this:
> > 
> > move ra, at
> > jal _mcount
> > 
> > The new one with -mlong-calls looks like this:
> > 
> > lui v1, HI_16BIT_OF_MCOUNT
> > addiu v1, v1, LOW_16BIT_OF_MCOUNT
> > move ra, at
> > jalr v1
> > 
> > both of them have a "jump" instruciton, so, only two lui, addiu added
> > for -mlong-calls ;)
> > 
> > what about the difference between that "jal _mcount"  and "jalr v1"?
> 
>  As I say, the latter cannot be predicted and will incur a stall for any 
> decent pipeline.  With the former the target address of the jump can be 
> calculated early and the instruction fetch unit can start feeding 
> instructions from there into the pipeline even before the jump has reached 
> the execution stage.
> 

Get it, thanks!

Regards,
	Wu Zhangjin
