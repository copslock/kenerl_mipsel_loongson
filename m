Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9J6DWP17189
	for linux-mips-outgoing; Thu, 18 Oct 2001 23:13:32 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9J6DUD17186
	for <linux-mips@oss.sgi.com>; Thu, 18 Oct 2001 23:13:30 -0700
Received: from adsl.pacbell.net ([10.2.2.20])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9J6FBB18238;
	Thu, 18 Oct 2001 23:15:11 -0700
Subject: Re: [Linux-mips-kernel]PATCH
From: Pete Popov <ppopov@mvista.com>
To: Geoffrey Espin <espin@idiom.com>
Cc: linux-mips-kernel@lists.sourceforge.net, linux-mips@oss.sgi.com
X-Sieve: cmu-sieve 2.0
References: <3BC24525.8030201@mvista.com>
X-Mailer: Mutt 0.95.1i
In-Reply-To: <3BC24525.8030201@mvista.com>; from Pete Popov on Mon, Oct 08,
	2001 at 05:30:29PM -0700
In-Reply-To: <20011016115059.A29701@idiom.com>
References: <3BC24525.8030201@mvista.com>  <20011016115059.A29701@idiom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.09.08.08 (Preview Release)
Date: 18 Oct 2001 23:12:01 -0700
Message-Id: <1003471921.1184.4.camel@adsl.pacbell.net>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 2001-10-16 at 11:50, Geoffrey Espin wrote:
> Pete,
> 
> > I've attached a patch which adds zImage support for the Alchemy pb1000 board. 
> > The image is burned in flash and yamon can be used to just jump to that location 
> >... 
> > Feedback would be appreciated, including whether or not arch/mips/zboot is the 
> > most appropriate place to put the zImage support.
> 
> It ain't a pretty patch.  I do want to do this for the Korva-Markham
> board... either arch/arm/boot/compressed or arch/ppc/boot scheme
> would be nice to follow.  

I ported the code from arch/ppc/boot, so if you like that scheme, what 
is it that you don't like about the patch I sent?  The directory
structure is the same as arch/ppc/boot, and the generic code is the same
as well.

> I think arch/ppc/boot/mbx/Makefile does
> some of the magic offset stuff you need with quick `sh ` scripts
> and also includes piggyback initrd stuff!

I picked arch/ppc/boot/sandpoint, which does the offset stuff with
standard compiler tools, like objdump.  The initrd stuff can be added
easily.

Pete
