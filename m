Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2RCM1Q03665
	for linux-mips-outgoing; Wed, 27 Mar 2002 04:22:01 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2RCLuq03661
	for <linux-mips@oss.sgi.com>; Wed, 27 Mar 2002 04:21:56 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.27])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id NAA06294;
	Wed, 27 Mar 2002 13:23:28 +0100 (MET)
Date: Wed, 27 Mar 2002 13:23:27 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Y.H. Ku" <iskoo@ms45.hinet.net>
cc: Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: RE: BootLoader on MIPS
In-Reply-To: <NGBBILOAMLLIJMLIOCADCEOKCCAA.iskoo@ms45.hinet.net>
Message-ID: <Pine.GSO.4.21.0203271322310.9224-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 27 Mar 2002, Y.H. Ku wrote:
> What I want to know is how PMON jump to linux kernel image,
> 
> when mips.S function "_go" execute "j k0" command, 
> (k0 is assigned by LREG(k0,R_EPC,gp)  /* EPC */)
> k0 will be 40*(DBGREG)=40* (0x7ff00bad), 
> 
> the address is kuseg's domain. is it really work to turnin linux kernel image??
> (In common case, linux kernl image always start from 0x100000)
> 
> any suggestion?
> I just want to know MORE about the LINK method between PMON and MIPS-Linux?

On NEC DDB Vrc-5074, I always used something like

    call kernel_entry -s 'console=ttyS4'

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
