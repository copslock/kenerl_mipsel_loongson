Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9CHiPx26337
	for linux-mips-outgoing; Fri, 12 Oct 2001 10:44:25 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9CHiHD26331;
	Fri, 12 Oct 2001 10:44:17 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9CHkiB05140;
	Fri, 12 Oct 2001 10:46:44 -0700
Message-ID: <3BC72BE8.F50C2001@mvista.com>
Date: Fri, 12 Oct 2001 10:44:08 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Ralf Baechle <ralf@oss.sgi.com>,
   Gerald Champagne <gerald.champagne@esstech.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Remove ifdefs from setup_arch()
References: <Pine.GSO.4.21.0110121350300.20566-100000@mullein.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert Uytterhoeven wrote:
> 
> On Wed, 3 Oct 2001, Jun Sun wrote:
> > I talked about machine detection a while back.  My idea is following:
> >
> > 0. all machines that are *configured* into the image will supply <my>_detect()
> > and <my>_setup() functions.
> >
> > 1. at MIPS start up, we loop through all <my>_detect(), which returns three
> > values, a) run-time detection negative, b) run-time detection positive, and c)
> > no run-time detection code, but I return positive because I am configured in.
> >
> > 2. the startup code resolves conflicts (which sometimes may panic); and decide
> > on one machine.
> >
> > 3. then the startup code calls the right <my>_setup() code which will set up
> > the mach_type and other stuff.
> 
> Nice!
> 
> I suppose you want to have struct containing pointers to both the detect() and
> setup() functions, so you know which setup() function you have to call?
> 

The actual mechanism can vary and be flexible, but here is more detail what I
had in mind:

1. <my>_detect is placed in a special ELF section (mips_mach_detect), using
similar mechanism as .initcall.init section and __setup() macro.

2. in addition to the 3 possible return value, <my>_detect also returns a
function pointer to <my>_setup.  Once a final candidate is chosen, the machine
detection code will issue the right <my>_setup call.

There are probably some other related changes which need to be made, (e.g.,
prom_init() may be eliminated, etc).

It seems like I get more and more positive feedbacks on this idea.  We should
try to implement this in 2.5.

Jun
