Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3KJKvk04660
	for linux-mips-outgoing; Fri, 20 Apr 2001 12:20:57 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3KJKsM04649;
	Fri, 20 Apr 2001 12:20:54 -0700
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f3KJGY004020;
	Fri, 20 Apr 2001 12:16:34 -0700
Message-ID: <3AE08BA4.1B46655C@mvista.com>
Date: Fri, 20 Apr 2001 12:19:00 -0700
From: Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Florian Lohoff <flo@rfc822.org>, linux-mips@oss.sgi.com
Subject: Re: Illegal instruction - a workaround or fix ?
References: <20010311191639.A8587@paradigm.rfc822.org> <20010312122134.B1235@bacchus.dhis.org> <20010312144131.C7715@paradigm.rfc822.org> <3AE0885F.D1A3D26@mvista.com> <20010420161820.B5375@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Fri, Apr 20, 2001 at 12:05:03PM -0700, Pete Popov wrote:
> 
> > I'm bringing this up again because none of the related patches on this
> > topic have been applied to the latest cvs kernel.  The patch Florian
> > refers to above oopses for me as well.  This patch below, from Florian,
> > but updated against the latest cvs kernel, works (at least the few
> > simple tests I've run do work now).
> 
> This patch is broken for small negative numbers in the memory.
> 
> Florian now has a better patch that should be correct.

Are you talking about the fast_sysmips patch Florian posted? 

Florian, if you have a newer patch than what you last posted on the
mailing list, would you mind sending it?

Thanks,

Pete
