Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 13:56:45 +0100 (CET)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:41284 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492621AbZKIM4i (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 13:56:38 +0100
Received: from [127.0.0.1] (really [74.67.89.75])
          by hrndva-omta03.mail.rr.com with ESMTP
          id <20091109125631332.KYRI6318@hrndva-omta03.mail.rr.com>;
          Mon, 9 Nov 2009 12:56:31 +0000
Subject: Re: [PATCH -v5 08/11] tracing: not trace mips_timecounter_init()
 in MIPS
From:	Steven Rostedt <rostedt@goodmis.org>
To:	wuzhangjin@gmail.com
Cc:	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
In-Reply-To: <1257741072.3451.27.camel@falcon.domain.org>
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
	 <1257741072.3451.27.camel@falcon.domain.org>
Content-Type: text/plain
Date:	Mon, 09 Nov 2009 07:54:48 -0500
Message-Id: <1257771288.2845.11.camel@frodo>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 (2.26.3-1.fc11) 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips

On Mon, 2009-11-09 at 12:31 +0800, Wu Zhangjin wrote:

> I think if we use something like __mips_notrace here, we may get lots of
> __ARCH_notraces here too, 'Cause some other platforms(at least, as I
> know, Microblaze will do it too) may also need to add one here, it will
> become:
> 
> __mips_notrace __ARCH1_notrace __ARCH2_notrace .... foo() {...}
> 
> A little ugly ;)

I agree, that is ugly.

> 
> and If a new platform need it's __ARCH_notrace, they need to touch the
> common part of ftrace, more side-effects!
> 
> but with __arch_notrace, the archs only need to touch it's own part,
> Although there is a side-effect as you mentioned above ;)
> 
> So, what should we do?

Just do it in the Makefile. We can add __arch_notrace, and then in the
Makefile define it with the arch.

ifeq ($(ARCH), MIPS)
	CFLAGS_foo.o = -D__arch_notrace=notrace
endif

And we can simply define __arch_notrace in a header:

#ifndef __arch_notrace
# define __arch_notrace
#endif

I much rather uglify the Makefile than the code. 

-- Steve
