Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g01KYYv26332
	for linux-mips-outgoing; Tue, 1 Jan 2002 12:34:34 -0800
Received: from ns1.ltc.com (vsat-148-63-243-254.c3.sb4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g01KYLg26328
	for <linux-mips@oss.sgi.com>; Tue, 1 Jan 2002 12:34:24 -0800
Received: from prefect (unknown [10.1.1.86])
	by ns1.ltc.com (Postfix) with SMTP
	id EFFD5590A9; Tue,  1 Jan 2002 14:30:11 -0500 (EST)
Message-ID: <016d01c192fb$518a9dd0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: "Jun Sun" <jsun@mvista.com>, "Jim Paris" <jim@jtan.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
   "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Linux/MIPS Development" <linux-mips@oss.sgi.com>
References: <Pine.GSO.4.21.0112191456410.28777-100000@vervain.sonytel.be> <E16HSHp-0000ay-00@the-village.bc.nu> <20011221134452.A21586@neurosis.mit.edu> <20020101112223.A14847@mvista.com>
Subject: Re: ISA
Date: Tue, 1 Jan 2002 14:34:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

----- Original Message -----
From: "Jun Sun" <jsun@mvista.com>
To: "Jim Paris" <jim@jtan.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; "Geert Uytterhoeven"
<Geert.Uytterhoeven@sonycom.com>; "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>;
"Linux/MIPS Development" <linux-mips@oss.sgi.com>
Sent: Tuesday, January 01, 2002 2:22 PM
Subject: Re: ISA


> 1. each address space has an id.
> 2. kernel pre-defines a couple of well-known ones, 0 for CPU physical,
>    1 for virtual, etc.
> 3. When drivers discover the devices, they get the address and also
>    the address space id where the address resides.
> 4. there are a set of macro's that converts/maps an address or an
>    address region from one space to another.

The first thing that jumps out at me is that now every bus access has an
added switch in it.

Either that or drivers would get back access function pointers, but that
eliminates the chance to inline trivial bus accesses.

Regards,
Brad
