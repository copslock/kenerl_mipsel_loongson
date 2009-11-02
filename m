Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 22:44:09 +0100 (CET)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:56555 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493403AbZKBVoC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 2 Nov 2009 22:44:02 +0100
Received: by ewy10 with SMTP id 10so6183175ewy.33
        for <multiple recipients>; Mon, 02 Nov 2009 13:43:55 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=OgCrKQYn9/oybKjIMgyo8odG+anVCej79+JUffsvlBk=;
        b=WFwEfg4GHRtMUYjC2sL4T4UY3ksu9WYWylAGb17GOoPRvNwxoPVEgIp6fT5PfxeqYQ
         CBkEoHfvaryaLaig6sYhFR/zzzZ5kiOL9jrZxQjY0knyaR5Yz8PqNBmY0bVw8pwX83VF
         BO3dgKvSmcr8jMGwOcm9eLRRcXQ2JYnamaZx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=F6wh4sZinmOFvy2YheS+kAVAzANDnMjvIFqg10SQatyZDqepDolyEHYTCCY8efeG7d
         GqQfspsrpK+biSmcbcm0Sf5amsIJq08/i+rzoFaah8/ViTMi7dFXnu6VGIEVQh0EGjPp
         kL3OVI476Xboa19AjxzX2zHkfJ3D1orJOd3ls=
Received: by 10.216.85.197 with SMTP id u47mr5329765wee.133.1257198235670;
        Mon, 02 Nov 2009 13:43:55 -0800 (PST)
Received: from nowhere (ADijon-552-1-8-120.w92-138.abo.wanadoo.fr [92.138.147.120])
        by mx.google.com with ESMTPS id 23sm9161166eya.44.2009.11.02.13.43.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Nov 2009 13:43:53 -0800 (PST)
Received: by nowhere (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher RC4-MD5 (128/128 bits))
	fweisbec@gmail.com; Mon,  2 Nov 2009 22:43:56 +0100 (CET)
Date:	Mon, 2 Nov 2009 22:43:55 +0100
From:	Frederic Weisbecker <fweisbec@gmail.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Subject: Re: [PATCH -v5 08/11] tracing: not trace mips_timecounter_init()
	in MIPS
Message-ID: <20091102214351.GI4880@nowhere>
References: <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com> <3e0c2d7d8b8f196a8153beb41ea7f3cbf42b3d84.1256483735.git.wuzhangjin@gmail.com> <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com> <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com> <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com> <cover.1256483735.git.wuzhangjin@gmail.com> <6140dd8f4e1783e5ac30977cf008bb98e4698322.1256483735.git.wuzhangjin@gmail.com> <49b3c441a57f4db423732f81432a3450ccb3240e.1256483735.git.wuzhangjin@gmail.com> <c62985530910251727o23beafcco539870e4b2f84637@mail.gmail.com> <1256550156.5642.148.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1256550156.5642.148.camel@falcon>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Oct 26, 2009 at 05:42:36PM +0800, Wu Zhangjin wrote:
> On Mon, 2009-10-26 at 01:27 +0100, Frederic Weisbecker wrote:
> > 2009/10/25 Wu Zhangjin <wuzhangjin@gmail.com>:
> > > -static inline u64 mips_timecounter_read(void)
> > > +static inline u64 notrace mips_timecounter_read(void)
> > 
> > 
> > You don't need to set notrace functions, unless their addresses
> > are referenced somewhere, which unfortunately might happen
> > for some functions but this is rare.
> > 
> 
> Okay, Will remove it.



Oops, a word has escaped from my above sentence. I wanted to say:

"You don't need to set notrace to inline functions" :)


> > Hmm yeah this is not very nice to do that in core functions because
> > of a specific arch problem.
> > At least you have __notrace_funcgraph, this is a notrace
> > that only applies if CONFIG_FUNCTION_GRAPH_TRACER
> > so that it's still traceable by the function tracer in this case.
> > 
> > But I would rather see a __mips_notrace on these two core functions.
> 
> What about this: __arch_notrace? If the arch need this, define it,
> otherwise, ignore it! if only graph tracer need it, define it in "#ifdef
> CONFIG_FUNCTION_GRAPH_TRACER ... #endif".



The problem is that archs may want to disable tracing on different
places.
For example mips wants to disable tracing in timecounter_read_delta,
but another arch may want to disable tracing somewhere else.

We'll then have several unrelated __arch_notrace. One that is relevant
for mips, another that is relevant for arch_foo, but all of them will
apply for all arch that have defined a __arch_notrace.

It's true that __mips_notrace is not very elegant as it looks like
a specific arch annotation intruder.

But at least that gives us a per arch filter granularity.

If only static ftrace could disappear, we could keep only dynamic
ftrace and we would then be able to filter dynamically.
But I'm not sure it's a good idea for archs integration.
