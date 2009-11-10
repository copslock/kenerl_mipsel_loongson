Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2009 02:00:53 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:45922 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493525AbZKJBAr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Nov 2009 02:00:47 +0100
Received: by yxe42 with SMTP id 42so4964412yxe.22
        for <multiple recipients>; Mon, 09 Nov 2009 17:00:38 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=mDwtSTB3qZzfOtn1AbAEVcPDxEji8AeruxNszCyTTBg=;
        b=mzztZ9JqbcKjWvYOTHaiqVqWpihaNBbqtnF/+TjwNoY/4Xw//UT8qOqDrArGOR1zZx
         oEKrxAOwxZo7M0Mm+jpBdETKW/u18fv9akYkZq+RQXoV+z+bl+Ad6WiWn6QuQmmCm18h
         kuoQt5G4GEL1ZkLehj4Rfu3WJK+NGHHUcIsxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=hxIq2hk3MRo8VA68it9d8yzfLwzn0RLuPfXbeiMbZt51eNqot+XM8sxkTNm2ZchL0b
         AZQp6qcLX4R8bMaKOZApqILLOjXq1bfuqwcumtr+ac9yrHkM++04UOC50W5xUN7jslD1
         JRuoFBE0IiqsefqVaPx2QrqqlwythJUHLn1nA=
Received: by 10.150.238.18 with SMTP id l18mr4006983ybh.14.1257814837980;
        Mon, 09 Nov 2009 17:00:37 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm88322ywh.46.2009.11.09.17.00.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 17:00:37 -0800 (PST)
Subject: Re: [PATCH v7 04/17] tracing: add static function tracer support
 for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com,
	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>
In-Reply-To: <4AF8B31C.5030802@caviumnetworks.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>
	 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com>
	 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com>
	 <cefe074f5eb3cfbc2e0bb41b0c1f61fcd0190d90.1257779502.git.wuzhangjin@gmail.com>
	 <4AF8B31C.5030802@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Tue, 10 Nov 2009 09:00:17 +0800
Message-ID: <1257814817.2822.3.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24806
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 2009-11-09 at 16:26 -0800, David Daney wrote: 
> Wu Zhangjin wrote:
> 
> >  
> > +ifndef CONFIG_FUNCTION_TRACER
> >  cflags-y := -ffunction-sections
> > +else
> > +cflags-y := -mlong-calls
> > +endif
> >  cflags-y += $(call cc-option, -mno-check-zero-division)
> >  
> 
> That doesn't make sense to me.  Modules are already compiled with 
> -mlong-calls.  The only time you would need the entire kernel compiled 
> with -mlong-calls is if the tracer were in a module.  The logic here 
> doesn't seem to reflect that.

Yes, I knew the module have gotten the -mlong-calls, Here we just want
to use -mlong-calls for the whole kernel, and then we get the same
_mcount stuff in the whole kernel, at last, we can use the same
scripts/recordmcount.pl and ftrace_make_nop & ftrace_make_call for the
dynamic ftracer.

And seems we only need to enable it for the dynamic one. So, I will
split it out into it's own patch later.

Thanks & Regards,
	Wu Zhangjin
