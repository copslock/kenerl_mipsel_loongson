Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Mar 2009 14:53:59 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:7101 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20808646AbZCHOxz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Mar 2009 14:53:55 +0000
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id B701940055;
	Sun,  8 Mar 2009 15:53:46 +0100 (CET)
Received: from [192.168.10.105] (c-30bde555.035-105-73746f38.cust.bredbandsbolaget.se [85.229.189.48])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 990244004F;
	Sun,  8 Mar 2009 15:53:46 +0100 (CET)
Cc:	linux-mips@linux-mips.org
Message-Id: <F2075B11-1B80-4C7B-9316-C82A0CE448C1@lysator.liu.se>
From:	Markus Gothe <nietzsche@lysator.liu.se>
To:	Nils Faerber <nils.faerber@kernelconcepts.de>
In-Reply-To: <49B1510B.8020606@kernelconcepts.de>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3-518791976"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: Ingenic JZ4730 - illegal instruction
Date:	Sun, 8 Mar 2009 15:53:49 +0100
References: <49B1510B.8020606@kernelconcepts.de>
X-Pgp-Agent: GPGMail 1.2.0 (v56)
X-Mailer: Apple Mail (2.930.3)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <nietzsche@lysator.liu.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nietzsche@lysator.liu.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3-518791976
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit

Well, the Xburst-arch seems to be pretty fucked up beyond all repair.

//Markus

On 6 Mar 2009, at 17:36, Nils Faerber wrote:

> Hello!
> I am rather playing than really working on a Ingenic JZ4730 based
> device. The JZ4730 is a MIPS32 SOC included in many types of devices,
> like media players and thelike but also in small power efficient
> subnotebooks (this is the device I am trying to support based on the
> Ingebic Linux kernel patch).
>
> The current kernel patch from Ingenic
>
> http://www.ingenic.cn/eng/productServ/App/JZ4730/pfCustomPage.aspx
> or
> ftp://ftp.ingenic.cn/3sw/01linux/02kernel/linux-2.6.24/linux-2.6.24.3-jz-20090218.patch.gz
>
> for the patch (I used an even older patch to start my board support  
> but
> they basically only added newer CPU types in later patches).
>
> The support for my board is almost in place but I see from time to  
> time
> failing applications with "illegal instruction" faults. Most shell
> applications work pretty fine, especially more complex GUI  
> applications
> seem to fail, like a webbrowser or such.
> I also tested this with different GCC and glibc version which makes me
> pretty sure that I am seeing a kernel problem here rather than a
> userspace problem.
>
> I am pretty clueless how to debug this. Apropos debig as another hint:
> Some application work if I start them in GDB but fail outside.
>
> Any hint how to start debugging this would be greatly appreciated!  
> And a
> fix would be like a dream ;)
>
> Many thanks!
>
> Cheers
>  nils faerber
>
> -- 
> kernel concepts GbR        Tel: +49-271-771091-12
> Sieghuetter Hauptweg 48    Fax: +49-271-771091-19
> D-57072 Siegen             Mob: +49-176-21024535
> http://www.kernelconcepts.de
>


--Apple-Mail-3-518791976
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (Darwin)

iEYEARECAAYFAkmz2/0ACgkQ6I0XmJx2NrwsGgCffg2xSRrF2Efmtt53fBsrG51+
NQ4AnjDzkdqiqqL7OwFJUYAMH6We6mOh
=z60D
-----END PGP SIGNATURE-----

--Apple-Mail-3-518791976--
