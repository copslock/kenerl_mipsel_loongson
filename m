Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7NBflq22931
	for linux-mips-outgoing; Thu, 23 Aug 2001 04:41:47 -0700
Received: from t111.niisi.ras.ru (IDENT:root@[193.232.173.111])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7NBffd22928;
	Thu, 23 Aug 2001 04:41:41 -0700
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id PAA19507;
	Thu, 23 Aug 2001 15:41:13 +0400
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id PAA04399; Thu, 23 Aug 2001 15:23:11 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34]) by niisi.msk.ru (8.8.8/8.8.8) with ESMTP id PAA20895; Thu, 23 Aug 2001 15:38:14 +0400 (MSD)
Message-ID: <3B84EB2C.7643F00B@niisi.msk.ru>
Date: Thu, 23 Aug 2001 15:38:20 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, Harald Koerfgen <hkoerfg@web.de>,
   linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
References: <Pine.GSO.3.96.1010814193527.5426C-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


"Maciej W. Rozycki" wrote:
> 
> On Mon, 13 Aug 2001, Gleb O. Raiko wrote:
> 
> > >  Note that for PCI-based systems, there is usually no problem -- PCI IDs
> > > can be used instead in most cases.
> >
> > How? In fact, I've got two different boards with the same Ethernet chip.
> > Moreover, mach type shall be known as early as possible, early than pci
> > init for sure. Just imagine, I need a way to identify PCI controller by
> > mach type, so I need to scan pci busses for specific ID. Boom. :-) Did I
> > miss something in your proposal?
> 
>  The PCI ID of a host bridge is usually sufficient to differentiate most
> systems for onboard devices that are not reported on PCI.  If it is not
> for your one, you just fall outside of the scope of "most cases" and you
> need a different way to identify a system.  Note I do not promote
> mips_machtype removal.

In order to read a PCI ID, you need to know how to do it. In pc world,
you may rely on configuation access types, at least, ports are known. On
other arches, you need to know where such "ports" are. Even if hardware
supports, say, configuration type 1 accesses, developers are free to put
port addresses anywhere.

> 
> > BTW, in my Baget case, I just need a number for mach type. I can ask to
> > change my prom in worst case.
> 
>  How do you set up mips_machtype on your system in the first place?  At
> kernel_entry the code does not know what machine it's running on anyway,
> so it has to set mips_machtype based on a detection algorithm.
> 

First, mips_machtype is accessed far later than kernel_entry is
executed. Personally, I am lucky :-), I may read firmware environment
variables.

Regards,
Gleb.
