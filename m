Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DIXDm16491
	for linux-mips-outgoing; Mon, 13 Aug 2001 11:33:13 -0700
Received: from t111.niisi.ras.ru (IDENT:root@[193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DIX1j16486;
	Mon, 13 Aug 2001 11:33:01 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id WAA05730;
	Mon, 13 Aug 2001 22:32:55 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id WAA01452; Mon, 13 Aug 2001 22:13:38 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id WAA08135; Mon, 13 Aug 2001 22:24:56 +0400 (MSD)
Message-ID: <3B781BF5.9FF57CF8@niisi.msk.ru>
Date: Mon, 13 Aug 2001 22:27:01 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, Harald Koerfgen <hkoerfg@web.de>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
References: <Pine.GSO.3.96.1010813182811.23241P-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk



"Maciej W. Rozycki" wrote:
> 
> On Mon, 13 Aug 2001, Ralf Baechle wrote:
> 
> > >  The following patch exports mips_machtype to modules.  Please apply.
> >
> > Ok - but I'd like to burry the whole mips_machtype mechanism in 2.5.  To
> > messy and requires a central authority to allocate machine types.  What
> > do you think?
> 
>  No idea at the moment.  For DECs things are pretty easy.  The firmware
> returns a unique system ID for each different kind of hardware.  It can be
> used instead (actually mips_machtype is initialized bazed on what firmware
> reports).  The ID is mostly useful for system-specific stuff, e.g. onboard
> devices that cannot be identified or probed in another way.
> 
>  Note that for PCI-based systems, there is usually no problem -- PCI IDs
> can be used instead in most cases.
> 

How? In fact, I've got two different boards with the same Ethernet chip.
Moreover, mach type shall be known as early as possible, early than pci
init for sure. Just imagine, I need a way to identify PCI controller by
mach type, so I need to scan pci busses for specific ID. Boom. :-) Did I
miss something in your proposal?

BTW, in my Baget case, I just need a number for mach type. I can ask to
change my prom in worst case.

Regards,
Gleb.
