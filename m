Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Oct 2009 19:58:40 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:35645 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493252AbZJVR6d (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Oct 2009 19:58:33 +0200
Received: from [192.168.23.10] (really [74.67.89.75])
          by hrndva-omta02.mail.rr.com with ESMTP
          id <20091022175823646.IKN1670@hrndva-omta02.mail.rr.com>;
          Thu, 22 Oct 2009 17:58:23 +0000
Subject: Re: [PATCH -v4 9/9] tracing: add function graph tracer support for
 MIPS
From:	Steven Rostedt <rostedt@goodmis.org>
Reply-To: rostedt@goodmis.org
To:	wuzhangjin@gmail.com
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <1256233198.23653.0.camel@falcon>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
	 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
	 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
	 <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
	 <5dda13e8e3a9c9dba4bb7179183941bda502604f.1256135456.git.wuzhangjin@gmail.com>
	 <af3ec1b5cd06b6f6a461c9fa7d09a51fabccb08d.1256135456.git.wuzhangjin@gmail.com>
	 <a6f2959a69b6a77dd32cc36a5c8202f97d524f1e.1256135456.git.wuzhangjin@gmail.com>
	 <53bdfdd95ec4fa00d4cc505bb5972cf21243a14d.1256135456.git.wuzhangjin@gmail.com>
	 <1256141540.18347.3118.camel@gandalf.stny.rr.com>
	 <1256233198.23653.0.camel@falcon>
Content-Type: text/plain
Organization: Kihon Technologies Inc.
Date:	Thu, 22 Oct 2009 13:58:22 -0400
Message-Id: <1256234302.20866.795.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.3 
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips


FYI:

One of the comments made at the kernel summit, was to have people trim
email when sending. It makes it a lot easier to reply then to scroll
down lots of lines of quoted text just to read something that only
references part of the email.

Don't be afraid to cut out quoted text. It does help (as I did in this
reply).

On Fri, 2009-10-23 at 01:39 +0800, Wu Zhangjin wrote:

> > >  	.set reorder
> > > diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
> > > index 162b299..f25df73 100644
> > > --- a/arch/mips/kernel/vmlinux.lds.S
> > > +++ b/arch/mips/kernel/vmlinux.lds.S
> > > @@ -46,6 +46,7 @@ SECTIONS
> > >  		SCHED_TEXT
> > >  		LOCK_TEXT
> > >  		KPROBES_TEXT
> > > +		IRQENTRY_TEXT
> > 
> > This looks like it should be in a separate patch. I don't see where you
> > explain this?
> > 
> 
> This is used to fix this error:
> 
> kernel/built-in.o: In function `print_graph_irq':
> trace_functions_graph.c:(.text+0x82f40): undefined reference to
> `__irqentry_text_start'
> trace_functions_graph.c:(.text+0x82f48): undefined reference to
> `__irqentry_text_start'
> trace_functions_graph.c:(.text+0x82f70): undefined reference to
> `__irqentry_text_end'
> trace_functions_graph.c:(.text+0x82f74): undefined reference to
> `__irqentry_text_end'

Right, and this should be in a separate patch, showing this error in the
change log.

Thanks,

-- Steve
