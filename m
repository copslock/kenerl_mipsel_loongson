Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 03:43:01 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:38064 "EHLO
	mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492792AbZKKCmz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 03:42:55 +0100
Received: by gxk2 with SMTP id 2so621659gxk.4
        for <multiple recipients>; Tue, 10 Nov 2009 18:42:48 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=dp05kroZcZ1sp7uQqMtvBNMb5hMKNLtAKZE760yyJ78=;
        b=WNFS1XnwnaHy/C0vDR40Dqgnc8pOIOktlElGMkiChwR6w5uBbbdPf4rReDgDyDrc0g
         zo9Lssu11h50OuzkIN7OEtzwqRH+dsPU6htn2d1aTC89yJM1M2sqoE8rXAWUmx9eXrnV
         JLaQ/ZzphG9Kr9o8BhSiwYkFgPAheF0I4cKwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Kwr7UZRpU4UaYoI0jPthy5DM4kHUs0QBX8/6XBUim1YxbzpMBeefpYlfJbZvjbH6fX
         u0tO9vEfcE37tY2mJMcQeRvZ14H+smfghH5LoH6LISfGY9H/0qxm0LgZqqMUXn+As4gt
         EwYXZm3jBV1Cyh+aXLSVHFBj4udU4i8/YvhSQ=
Received: by 10.90.166.2 with SMTP id o2mr1392887age.93.1257907367717;
        Tue, 10 Nov 2009 18:42:47 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm636545yxe.2.2009.11.10.18.42.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 18:42:45 -0800 (PST)
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
In-Reply-To: <4AF99848.9090000@caviumnetworks.com>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1257779502.git.wuzhangjin@gmail.com>
	 <b99c08397d9ff92ac5a72bda9131df41b702fc71.1257779502.git.wuzhangjin@gmail.com>
	 <8f579e2cece16cd22358a4ec143ef6a8c462639b.1257779502.git.wuzhangjin@gmail.com>
	 <cefe074f5eb3cfbc2e0bb41b0c1f61fcd0190d90.1257779502.git.wuzhangjin@gmail.com>
	 <4AF8B31C.5030802@caviumnetworks.com>
	 <1257814817.2822.3.camel@falcon.domain.org>
	 <4AF99848.9090000@caviumnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Wed, 11 Nov 2009 10:42:31 +0800
Message-ID: <1257907351.2922.37.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24827
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Tue, 2009-11-10 at 08:43 -0800, David Daney wrote:
[...]
> >>> +ifndef CONFIG_FUNCTION_TRACER
> >>>  cflags-y := -ffunction-sections
> >>> +else
> >>> +cflags-y := -mlong-calls
> >>> +endif
> >>>  cflags-y += $(call cc-option, -mno-check-zero-division)
> >>>  
> >> That doesn't make sense to me.  Modules are already compiled with 
> >> -mlong-calls.  The only time you would need the entire kernel compiled 
> >> with -mlong-calls is if the tracer were in a module.  The logic here 
> >> doesn't seem to reflect that.
> > 
> > Yes, I knew the module have gotten the -mlong-calls, Here we just want
> > to use -mlong-calls for the whole kernel, and then we get the same
> > _mcount stuff in the whole kernel, at last, we can use the same
> > scripts/recordmcount.pl and ftrace_make_nop & ftrace_make_call for the
> > dynamic ftracer.
> > 
> 
> -mlong-calls really degrades performance.  I have seen things like 6% 
> drop in network packet forwarding rates with -mlong-calls.
> 

so much drop? seems only two instructions added for it: lui, addi. from
this view point, I think the -fno-omit-frame-pointer(add, sd, move...)
will also bring with much drop.

It's time to remove them? -mlong-calls, -fno-omit-frame-pointer.

> It would be better to fix all the tools so that they could handle both 
> -mlong-calls and -mno-long-calls code.
> 

It's totally possible, will try to make it work later. I just wanted the
stuff simple, but if it really brings us with much drop, it's time to
fix it.

Regards,
	Wu Zhangjin
