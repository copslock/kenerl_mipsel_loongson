Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 02:34:37 +0100 (CET)
Received: from mail-yw0-f173.google.com ([209.85.211.173]:55698 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493988AbZKCBea (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2009 02:34:30 +0100
Received: by ywh3 with SMTP id 3so5671634ywh.22
        for <multiple recipients>; Mon, 02 Nov 2009 17:34:24 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=VTjuaelzKNhTSnmPbqbzgjbKBfDrQkNEYVgHu4u4oKo=;
        b=X2EQDShms7onFZCf5ecCYk1rfNHWR1jp+eKSqS1J56w29IUB4xJlTAPuExX6cRkO4f
         REkj1aOT1mUUynKiCQKf+26MLL3Izw4vm4wrlCZgRIAmmCfAuSumaNWBzZckTvuAni6A
         V9+s57jtP24gQG3Po+7CFoiTL2Dyq+sIJcWb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=TSjcCbXGOGyRkeDD3YAsrym5JhnFS1pJ96OWyZRQGj4smkXOS1dJYLioDgXHCZNtoD
         GSBMYIPsNf8pjYK9cNMkpWMXj6JOYdXV0x8vMGzV2Gss+i/MWJzPo05eBwzd+8JUf9FU
         sf17ooykN/OLqEF/HYNdy2Xtr+DAcMfjAHb60=
Received: by 10.150.104.13 with SMTP id b13mr9380356ybc.17.1257212063834;
        Mon, 02 Nov 2009 17:34:23 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm2306120ywh.0.2009.11.02.17.34.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Nov 2009 17:34:23 -0800 (PST)
Subject: Re: [PATCH -v5 08/11] tracing: not trace mips_timecounter_init()
 in MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Frederic Weisbecker <fweisbec@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
In-Reply-To: <20091102214351.GI4880@nowhere>
References: <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
	 <3e0c2d7d8b8f196a8153beb41ea7f3cbf42b3d84.1256483735.git.wuzhangjin@gmail.com>
	 <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com>
	 <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com>
	 <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com>
	 <cover.1256483735.git.wuzhangjin@gmail.com>
	 <6140dd8f4e1783e5ac30977cf008bb98e4698322.1256483735.git.wuzhangjin@gmail.com>
	 <49b3c441a57f4db423732f81432a3450ccb3240e.1256483735.git.wuzhangjin@gmail.com>
	 <c62985530910251727o23beafcco539870e4b2f84637@mail.gmail.com>
	 <1256550156.5642.148.camel@falcon>  <20091102214351.GI4880@nowhere>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Tue, 03 Nov 2009 09:34:25 +0800
Message-ID: <1257212065.3528.28.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 2009-11-02 at 22:43 +0100, Frederic Weisbecker wrote:
[...]
> > > > -static inline u64 mips_timecounter_read(void)
> > > > +static inline u64 notrace mips_timecounter_read(void)
> > > 
> > > 
> > > You don't need to set notrace functions, unless their addresses
> > > are referenced somewhere, which unfortunately might happen
> > > for some functions but this is rare.
> > > 
> > 
> > Okay, Will remove it.
> 
> 
> 
> Oops, a word has escaped from my above sentence. I wanted to say:
> 
> "You don't need to set notrace to inline functions" :)
> 
> 

Thanks ;)

I have got your meaning at that time, and have removed them with inline
functions.

> > > But I would rather see a __mips_notrace on these two core functions.
> > 
> > What about this: __arch_notrace? If the arch need this, define it,
> > otherwise, ignore it! if only graph tracer need it, define it in "#ifdef
> > CONFIG_FUNCTION_GRAPH_TRACER ... #endif".
> 
> The problem is that archs may want to disable tracing on different
> places.
> For example mips wants to disable tracing in timecounter_read_delta,
> but another arch may want to disable tracing somewhere else.
> 
> We'll then have several unrelated __arch_notrace. One that is relevant
> for mips, another that is relevant for arch_foo, but all of them will
> apply for all arch that have defined a __arch_notrace.
> 
> It's true that __mips_notrace is not very elegant as it looks like
> a specific arch annotation intruder.
> 
> But at least that gives us a per arch filter granularity.
> 
> If only static ftrace could disappear, we could keep only dynamic
> ftrace and we would then be able to filter dynamically.
> But I'm not sure it's a good idea for archs integration.
> 

Got it.

Thanks & Regards,
	Wu Zhangjin
