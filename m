Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Aug 2007 03:25:41 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:63178 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20021996AbXH2CZd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Aug 2007 03:25:33 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 9C328200A21D;
	Wed, 29 Aug 2007 04:25:31 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 16665-01; Wed, 29 Aug 2007 04:25:30 +0200 (CEST)
Received: from [192.168.0.132] (cust.fiber-lan.vnet.lk.85.194.49.238.stunet.se [85.194.49.238])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 95AD3200A1E4;
	Wed, 29 Aug 2007 04:25:30 +0200 (CEST)
In-Reply-To: <1188321514.6882.3.camel@scarafaggio>
References: <1188030215.13999.14.camel@scarafaggio> <1188196563.2177.13.camel@scarafaggio>  <46D2CB0F.7020505@27m.se> <1188321514.6882.3.camel@scarafaggio>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-10--406261594"
Message-Id: <F288AA63-099B-4140-81B2-6A8E21887057@27m.se>
Cc:	linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Markus Gothe <markus.gothe@27m.se>
Subject: Re: Exception while loading kernel
Date:	Wed, 29 Aug 2007 04:25:35 +0200
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-10--406261594
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Use gdb and list the read address.

//Markus

On 28 Aug, 2007, at 19:18 , Giuseppe Sacco wrote:

> Hi Markus,
>
> Il giorno lun, 27/08/2007 alle 15.01 +0200, Markus Gothe ha scritto:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> What about trying 2.6.22 from linux-mips.org in first place?
>>
>> //Markus
>
> 2.6.22.2, downloaded from linux-mips.org, display the same problem. I
> got:
>
> Exception PC: 0x8022051c, Exception RA: 0x804da7ec
> tmp: 81070000 1000 80516868 fff8054b ffffffff 81412ef4 a13fab68 7
>
> and, from my System.map file,
>
> ffffffff802204e4 T __bzero
> ffffffff80220544 t memset_partial
>
> ffffffff804da728 t init_bootmem_core
> ffffffff804da808 t $L99
>
> ffffffff80516860 B percpu_pagelist_fraction
> ffffffff80516868 b contig_bootmem_data
>
> Bye,
> Giuseppe
>
>

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)73 718 72 80
Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
www.27m.com



--Apple-Mail-10--406261594
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFG1Nkg6I0XmJx2NrwRAscpAJ9lfHqyDlPjXXPzxxx7IJgeHu+HAgCfeDQj
fyjiCOAJnsL52aU80Q4DNl8=
=O59l
-----END PGP SIGNATURE-----

--Apple-Mail-10--406261594--
