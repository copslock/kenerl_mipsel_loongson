Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 13:08:30 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:36249 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492423AbZKIMIX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 13:08:23 +0100
Received: by pxi26 with SMTP id 26so1859746pxi.21
        for <multiple recipients>; Mon, 09 Nov 2009 04:08:14 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=/dOneUS5w7sOBx3RMIXYja4CZpuYlgCEjbgm5jnk008=;
        b=qpd8O3BByEz7NZumyqETt3DuVJSYjFBIrnNL6S87ydIWJgZY6Mhk+Uv7dm9gCFgWXi
         Mmany3xuv99yE0J7AZlGsC3eUed0JucB2lnN9F0pzGTJkzSBg7RZSYsS8W7XZxlITE0K
         Ope8934b0LVqdYiflmoErbncPqkhOzg3brvgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=r1sbIxhT14CZNB094+aXIrnyfiuiGVektxBj1WS/1l7RNOp5v04d6vdgxeS7KEoaL4
         KXrnSOBELKhJl8NohNbwANqLKSa9VlHAaEdkbC9AcpPe5/jqeXuL7K3hGMY9RAk2rQ00
         iPoONBrMkzba74i5w/tQLd7YZ9uy0NNexoZKM=
Received: by 10.114.237.19 with SMTP id k19mr13635408wah.69.1257768494573;
        Mon, 09 Nov 2009 04:08:14 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm2061071pxi.11.2009.11.09.04.08.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 04:08:14 -0800 (PST)
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
In-Reply-To: <20091109115303.GB5206@nowhere>
References: <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com>
	 <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com>
	 <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com>
	 <cover.1256483735.git.wuzhangjin@gmail.com>
	 <6140dd8f4e1783e5ac30977cf008bb98e4698322.1256483735.git.wuzhangjin@gmail.com>
	 <49b3c441a57f4db423732f81432a3450ccb3240e.1256483735.git.wuzhangjin@gmail.com>
	 <c62985530910251727o23beafcco539870e4b2f84637@mail.gmail.com>
	 <1256550156.5642.148.camel@falcon> <20091102214351.GI4880@nowhere>
	 <1257741072.3451.27.camel@falcon.domain.org>
	 <20091109115303.GB5206@nowhere>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Mon, 09 Nov 2009 20:08:07 +0800
Message-ID: <1257768487.3451.64.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-11-09 at 12:53 +0100, Frederic Weisbecker wrote:
> On Mon, Nov 09, 2009 at 12:31:12PM +0800, Wu Zhangjin wrote:
> > I think if we use something like __mips_notrace here, we may get lots of
> > __ARCH_notraces here too, 'Cause some other platforms(at least, as I
> > know, Microblaze will do it too) may also need to add one here, it will
> > become:
> > 
> > __mips_notrace __ARCH1_notrace __ARCH2_notrace .... foo() {...}
> > 
> > A little ugly ;)
> 
> 
> Yeah :)
> I thought Mips would be the only one to do that.
> 
>  
> > and If a new platform need it's __ARCH_notrace, they need to touch the
> > common part of ftrace, more side-effects!
> > 
> > but with __arch_notrace, the archs only need to touch it's own part,
> > Although there is a side-effect as you mentioned above ;)
> >
> > So, what should we do?
> > 
> > Regards,
> > 	Wu Zhangjin
> >
> 
> Why not __time ?
> As it's normal that such few functions that are used to read the timecounter
> have fair chances to be __no_trace on archs like MIPS. Interested
> archs would just need to override a default stub __time.
> 

Good pointer, will apply it ;)

Regards,
	Wu Zhangjin
