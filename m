Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MAHwS28835
	for linux-mips-outgoing; Tue, 22 Jan 2002 02:17:58 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MAHiP28831
	for <linux-mips@oss.sgi.com>; Tue, 22 Jan 2002 02:17:45 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA27584;
	Tue, 22 Jan 2002 10:17:20 +0100 (MET)
Date: Tue, 22 Jan 2002 10:17:20 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Bryan Chua <chua@ayrnetworks.com>
cc: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: arch/mips/setup.c
In-Reply-To: <3C4C8FE2.9090800@ayrnetworks.com>
Message-ID: <Pine.GSO.4.21.0201221016380.26741-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 21 Jan 2002, Bryan Chua wrote:
> I recall a bunch of disussion about changing arch/mips/setup.c to 
> simplify adding vendor-specific platform code in setup_arch, but to date 
> nothing has come of it.  So while this is a dramatic oversimplification 
> of the various proposals, how about this for now --
> 
> just a vendor-defined function "platform_setup (void)" and it is up to 
> the vendor to figure out what to do from there.
> 
> -- bryan
> 
> 
> Index: arch/mips/kernel/setup.c
> ===================================================================
> RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
> retrieving revision 1.96.2.3
> diff -u -r1.96.2.3 setup.c
> --- arch/mips/kernel/setup.c	2001/12/26 23:27:02	1.96.2.3
> +++ arch/mips/kernel/setup.c	2002/01/21 22:55:35
> @@ -666,6 +666,7 @@
>    	void it8172_setup(void);
>   	void swarm_setup(void);
>   	void hp_setup(void);
> + 
> void platform_setup (void);
> 
>   	unsigned long bootmap_size;
>   	unsigned long start_pfn, max_pfn, first_usable_pfn;
> @@ -793,7 +794,8 @@
>                   break;
>   #endif
>   	default:
> - 
> 	panic("Unsupported architecture");
> + 
>          platform_setup ();
> + 

At first I thought: he's adding code after a call to panic(), but it turns out
your mailer screwed your patch...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
