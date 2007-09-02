Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Sep 2007 22:13:00 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:7590 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20029692AbXIBVMv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 2 Sep 2007 22:12:51 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 90B17200A222;
	Sun,  2 Sep 2007 23:12:20 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 22454-01-57; Sun, 2 Sep 2007 23:12:17 +0200 (CEST)
Received: from [192.168.0.132] (cust.fiber-lan.vnet.lk.85.194.49.238.stunet.se [85.194.49.238])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 73335200A1EA;
	Sun,  2 Sep 2007 23:12:16 +0200 (CEST)
In-Reply-To: <20070831234243.GA9979@linux-mips.org>
References: <46D8089F.3010109@gmail.com> <46D82A9F.5080001@27m.se> <20070831234243.GA9979@linux-mips.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1-6934523"
Message-Id: <4B116B6D-B08A-44AE-9C1C-3AE1011833E2@27m.se>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Content-Transfer-Encoding: 7bit
From:	Markus Gothe <markus.gothe@27m.se>
Subject: Re: flush_kernel_dcache_page() not needed ?
Date:	Sun, 2 Sep 2007 23:12:11 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1-6934523
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

I thought I mailed out 'N/M' shortly after the first mail ;)

On 01 Sep, 2007, at 01:42 , Ralf Baechle wrote:

> On Fri, Aug 31, 2007 at 04:50:07PM +0200, Markus Gothe wrote:
>
>> Ralf added this a while ago:
>>
>> "arch/mips/mm/cache.c:void __flush_dcache_page(struct page *page)"
>
> __flush_dcache_page is just the part of flush_dcache_page which does
> the real work.and has nothing to do with flush_kernel_dcache_page.
>
>   Ralf

_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)73 718 72 80
Diskettgatan 11, SE-583 35 Link=F6ping, Sweden
www.27m.com



--Apple-Mail-1-6934523
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFG2ycr6I0XmJx2NrwRAugQAKCq+eVu3Ns0hpjp/oXPxMmW/ZoTkACcCWnW
Hi+0d0quJ425/SiCouYi1Qg=
=FqEE
-----END PGP SIGNATURE-----

--Apple-Mail-1-6934523--
