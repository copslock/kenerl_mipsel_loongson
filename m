Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IHcdd08417
	for linux-mips-outgoing; Wed, 18 Apr 2001 10:38:39 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IHccM08414
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 10:38:38 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f3IHXi029471;
	Wed, 18 Apr 2001 10:33:44 -0700
Message-ID: <3ADDCFAB.549DA4FA@mvista.com>
Date: Wed, 18 Apr 2001 10:32:27 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: Scott A McConnell <samcconn@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: kernel/printk.c problem
References: <Pine.GSO.4.10.10104180852450.17832-100000@escobaria.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert Uytterhoeven wrote:
> 
> On Tue, 17 Apr 2001, Scott A McConnell wrote:
> > struct console *console_drivers = NULL;                          <----
> > Need the NULL.
> >
> > Otherwise, bad things can happen on the following statement in printk
> >
> > ~line 311
> >
> >        if ((c->flags & CON_ENABLED) && c->write){
> 
> Current policy is not explicitly initializing variables to zero. If this causes
> problems, there's a bug in the routine that clears the BSS on kernel entry.
> 

Interesting.  What is the reason behind the policy?  Is that because
initialized variable are put in a different section that takes more size in
the image?

Jun
