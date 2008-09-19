Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 11:58:35 +0100 (BST)
Received: from mail2.miwe.de ([62.225.191.126]:13760 "EHLO mail2.miwe.de")
	by ftp.linux-mips.org with ESMTP id S29051694AbYISK6T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Sep 2008 11:58:19 +0100
Received: from MAS15.arnstein.miwe.de ([172.16.100.182]) by
 MAS15.arnstein.miwe.de ([172.16.100.182]) with mapi; Fri, 19 Sep 2008
 12:58:13 +0200
From:	Klatt Uwe <U.Klatt@miwe.de>
To:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Date:	Fri, 19 Sep 2008 12:58:12 +0200
Subject: =?iso-8859-1?Q?AW:_Same_mipsel_binary_f=FCr_2.4_and_2.6_kernel_possible?=
 =?iso-8859-1?Q?=3F?=
Thread-Topic: =?iso-8859-1?Q?Same_mipsel_binary_f=FCr_2.4_and_2.6_kernel_possible=3F?=
Thread-Index: AckaO/o7ILgaat76TZ2bC2XA+4NL0gAAVx+gAAJIWtA=
Message-ID: <A1F06CF959C7E14EAC28F277F368175805686A8D70@MAS15.arnstein.miwe.de>
Accept-Language: de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage:	de-DE
x-pmwin-version: 3.0.2.0, Antivirus-Engine: 2.78.0, Antivirus-Data: 4.33E
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <U.Klatt@miwe.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: U.Klatt@miwe.de
Precedence: bulk
X-list: linux-mips

Hello Markus,

I use kernel 2.6.22.6 (this version is a special version from
hardware manufacturer).
I have complete source and can build this kernel without
problems (crosscompiled on x86).

I think the kernel should have fp emulator:
"Algorithmics/MIPS FPU Emulator v1.5" is displayed on boot.

Uwe

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Looks like the FPU-Emulator isn't working. Which kernel versions are
> you using?
>
> //Markus
>
> Klatt Uwe wrote:
> > Hello,
> >
> > I have a custom hardware (AU1100) with kernel 2.4 and an
> working binary
> using floats (compiled with gcc 3.3.5).
> > Now I am testing with kernel 2.6.
> >
> > When I use the old binary, float math isn't working anymore.
> > I have to recompile the source with new gcc 4.1.2 but then the new
> binary is working only on kernel 2.6.
> >
> > Can somebody give me some hints, how to chage settings for
> kernel 2.6
> creation or compiler settings to generate an universal binary.
> >
> > Thanks
> > Uwe
> >
>
>
> - --
> _______________________________________
>
> Mr Markus Gothe
> Software Engineer
>
> Phone: +46 (0)13 21 81 20 (ext. 1046)
> Fax: +46 (0)13 21 21 15
> Mobile: +46 (0)70 348 44 35
> Diskettgatan 11, SE-583 35 Linköping, Sweden
> www.27m.com
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iD8DBQFI03Pn6I0XmJx2NrwRCH4eAJwMWR2/SrFaWRJAWMul9sK/GvATdQCaAgmJ
> LnzfYvUmO6mzyV5QMKtCmKs=
> =dP4U
> -----END PGP SIGNATURE-----
>
>
