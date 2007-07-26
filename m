Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jul 2007 08:03:31 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:26535 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20021596AbXGZHDZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jul 2007 08:03:25 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 88792200A17A;
	Thu, 26 Jul 2007 09:03:19 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 16858-02-16; Thu, 26 Jul 2007 09:03:18 +0200 (CEST)
Received: from [192.168.0.5] (h31n2fls34o823.telia.com [217.208.10.31])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 413CE200A171;
	Thu, 26 Jul 2007 09:03:16 +0200 (CEST)
In-Reply-To: <014201c7cdc1$984e50c0$106215ac@realtek.com.tw>
References: <014201c7cdc1$984e50c0$106215ac@realtek.com.tw>
Mime-Version: 1.0 (Apple Message framework v752.3)
X-Priority: 3 (Normal)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-967766932"
Message-Id: <5C55354F-E857-4E83-A347-9C4A4EEA85E2@27m.se>
Cc:	<linux-mips@linux-mips.org>
Content-Transfer-Encoding: 7bit
From:	Markus Gothe <markus.gothe@27m.se>
Subject: Re: [SPAM] Linux 2.6.12 cannot run on 24K. Please give me some clues.
Date:	Thu, 26 Jul 2007 09:03:17 +0200
To:	colin <colin@realtek.com.tw>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-967766932
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed

Seems to me that running in EXkLusive/supervisor mode is the culprit. =20=

Try changing that before you get to userspace...

On 24 Jul, 2007, at 09:09 , colin wrote:

>
> Hi all,
> Could you help me on porting MIPS Linux?
>
> Our first embedded system using 4Kec is running very well on Linux =20
> 2.6.12.
> Now the second chip using 24K has problems. I found that mtf0 and =20
> mtc0 have
> hazard problem and I have solved it.
> static inline void unmask_mips_irq(unsigned int irq)
> {
>         set_c0_status(0x100 << (irq - mips_cpu_irq_base));
>         irq_enable_hazard();
> }
>
> Now Linux can continue running and then it will encounter problems =20
> when
> running the first application, init. I will appreciate your clues for
> helping me on this probem. :D
>
> Colin
>
> =FFttyS0 at MMIO 0x0 (irq =3D 3) is a 16550A
> ttyS1 at MMIO 0x0 (irq =3D 3) is a 16550A
> io scheduler noop registered
> Freeing prom memory: 0kb freed
> Reclaim bootloader memory from 80010000 to 800f0000
> Freeing unused kernel memory: 252k freed
> CPU 0 Unable to handle kernel paging request at virtual address =20
> ffffff88,
> epc =3D=3D 00440f10, ra =3D=3D 004000e4
> Oops in arch/mips/mm/fault.c::do_page_fault, line 167[#1]:
> Cpu 0
> $ 0   : 00000000 10000990 00400090 00000000
> $ 4   : 7fdd5ed0 7fdd5f94 00000000 7fdd5f94
> $ 8   : 00000000 00000000 80001cb2 00000b3b
> $12   : 7f1c0300 0001ffff 0001ffff 00000115
> $16   : 801f5e04 00000000 00000000 00000000
> $20   : 00000000 00000000 00000000 00000000
> $24   : 00000000 00440f00
> $28   : 10008c70 7fdd5e18 7fdd5e38 004000e4
> Hi    : 00000000
> Lo    : 00000000
> epc   : 00440f10     Not tainted
> ra    : 004000e4 Status: 00006802    KERNEL EXL
> Cause : 0880400c
> BadVA : ffffff88
> PrId  : 00019378
> Process init (pid: 1, threadinfo=3D80848000, task=3D80854bd8)
> Stack : 00000000 00000000 10008c70 00000000 10008c70 7fdd5e38 10008c70
> 004276e4
>         00000000 00000000 00000000 00000000 10008c70 00000000 7fdd5f9c
> 00000000
>         00000000 00000000 00000000 00000000 00000000 00000000 00000003
> 00400034
>         00000004 00000020 00000005 00000002 00000006 00001000 00000007
> 000000
>
>
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



--Apple-Mail-1-967766932
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFGqEc16I0XmJx2NrwRAgb8AJ9d53vEhqvnYh0K2Y/igMUY95refwCgrEtU
YKxhIuVIYrWUrqSBEyvUQcE=
=7UO9
-----END PGP SIGNATURE-----

--Apple-Mail-1-967766932--
