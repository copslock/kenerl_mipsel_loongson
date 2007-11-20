Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 02:51:15 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:37548 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20035173AbXKTCvG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Nov 2007 02:51:06 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id DBF94200A1A9;
	Tue, 20 Nov 2007 03:51:05 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 07579-01-100; Tue, 20 Nov 2007 03:51:05 +0100 (CET)
Received: from [192.168.0.132] (cust.fiber-lan.vnet.lk.85.194.49.238.stunet.se [85.194.49.238])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 80348200A25B;
	Tue, 20 Nov 2007 03:51:05 +0100 (CET)
In-Reply-To: <50c9a2250711191706g40744ab2w2027124c4bc8dbbb@mail.gmail.com>
References: <50c9a2250711191706g40744ab2w2027124c4bc8dbbb@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6-324034404"
Message-Id: <13D06144-B121-45D1-9A32-B2560785218C@27m.se>
Cc:	linux-mips <linux-mips@linux-mips.org>
Content-Transfer-Encoding: 7bit
From:	Markus Gothe <markus.gothe@27m.se>
Subject: Re: [SPAM] how to use memory before kernel load address?
Date:	Tue, 20 Nov 2007 03:51:22 +0100
To:	zhuzhenhua <zzh.hust@gmail.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6-324034404
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Are you using a MTD, if so just create a partition there.

//Markus

On 20 Nov 2007, at 02:06, zhuzhenhua wrote:

> hello,all
>           i want to place my kernel loadaddr=0x81008000 and set  
> EBASE=0x81000000, it workes.
>          but there is still some memory usable before 0x81000000,  
> for example from 0x80100000 ~ 0x80200000
>          i have try to pass param as mem=1M@1M mem=16M@16M  to the  
> kernel,  it seems only take the 0x8000000 ~ kernel_end as reserved.
>          is there any other options to set the memory useable? ( my  
> kernel version is 2.6.14)
>          thanks for any hints
>
>
> zzh


--Apple-Mail-6-324034404
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHQkuq6I0XmJx2NrwRApHJAJ9z6jg4EoziqhtNmYRGuzAcuN8hDwCgkqnk
QLM4b5Z39M1/RDBHxlLzwc0=
=22ne
-----END PGP SIGNATURE-----

--Apple-Mail-6-324034404--
