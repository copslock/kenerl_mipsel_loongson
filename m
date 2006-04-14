Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Apr 2006 23:01:56 +0100 (BST)
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:38062 "EHLO
	ms-smtp-02.nyroc.rr.com") by ftp.linux-mips.org with ESMTP
	id S8133482AbWDNWBi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Apr 2006 23:01:38 +0100
Received: from [192.168.23.10] (cpe-24-94-51-176.stny.res.rr.com [24.94.51.176])
	by ms-smtp-02.nyroc.rr.com (8.13.4/8.13.4) with ESMTP id k3EMCO9t012386;
	Fri, 14 Apr 2006 18:12:25 -0400 (EDT)
Date:	Fri, 14 Apr 2006 18:12:24 -0400 (EDT)
From:	Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To:	Andrew Morton <akpm@osdl.org>
cc:	linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@elte.hu,
	tglx@linutronix.de, ak@suse.de, mj@atrey.karlin.mff.cuni.cz,
	bjornw@axis.com, schwidefsky@de.ibm.com,
	benedict.gaster@superh.com, lethal@linux-sh.org, chris@zankel.net,
	marc@tensilica.com, joe@tensilica.com, davidm@hpl.hp.com,
	rth@twiddle.net, spyro@f2s.com, starvik@axis.com,
	tony.luck@intel.com, linux-ia64@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	grundler@parisc-linux.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, linux390@de.ibm.com,
	davem@davemloft.net
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <20060414150625.3ba369d2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0604141806480.18329@gandalf.stny.rr.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
 <20060414150625.3ba369d2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
Precedence: bulk
X-list: linux-mips



On Fri, 14 Apr 2006, Andrew Morton wrote:

> Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Example:
> >
> >  DEFINE_PER_CPU(int, myint);
> >
> >  would now create a variable called per_cpu_offset__myint in
> > the .data.percpu_offset section.
>
> Suppose two .c files each have
>
> 	DEFINE_STATIC_PER_CPU(myint)
>
> Do we end up with two per_cpu_offset__myint's in the same section?
>

Both variables are defined as static:

ie.
  #define DEFINE_STATIC_PER_CPU(type, name) \
    static __attribute__((__section__(".data.percpu_offset"))) unsigned long *per_cpu_offset__##name; \
    static __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name

So the per_cpu_offset__myint is also static, and gcc should treat it
properly.  Although, yes there are probably going to be two variables
named per_cpu_offset__myint in the same section, but the scope of those
should only be visible by who sees the static.

Works like any other variable that's static, and even the current way
DEFINE_PER_CPU works with statics.

Thanks,

-- Steve
