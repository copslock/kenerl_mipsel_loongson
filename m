Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAUIp5u27103
	for linux-mips-outgoing; Fri, 30 Nov 2001 10:51:05 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAUIoxo27100
	for <linux-mips@oss.sgi.com>; Fri, 30 Nov 2001 10:50:59 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fAUHpMB02497;
	Fri, 30 Nov 2001 09:51:22 -0800
Subject: Re: pcmcia
From: Pete Popov <ppopov@mvista.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Guillermo A. Loyola" <gmo@broadcom.com>,
   linux-mips
	 <linux-mips@oss.sgi.com>,
   sforge <linux-mips-kernel@lists.sourceforge.net>
In-Reply-To: <E169rrU-0004GN-00@the-village.bc.nu>
References: <E169rrU-0004GN-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 30 Nov 2001 09:50:51 -0800
Message-Id: <1007142651.6016.148.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2001-11-30 at 09:54, Alan Cox wrote:
> > > We need the same here, how about doing this instead:
> > > 
> > > #ifdef __i386__
> > > typedef u_short   ioaddr_t;
> > > #else
> > > typedef u_int	ioaddr_t;
> > > #endif
> > 
> > That probably makes more sense.  I wasn't sure if it's only x86 that
> > needs? ioaddr_t to be a 16 bit type.  
> 
> Is there any platform where making it int actually -breaks-. 

I can't see how it would break anything ... but I've said that before. 
It's not a variable which maps a hardware register, a protocol field,
etc, so it should be safe to just make it an int.  

> At least for 2.5 it would seem a lot saner to just make it bigger and see

Pete
