Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 02:49:03 +0000 (GMT)
Received: from mail.lysator.liu.se ([130.236.254.3]:31916 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20035170AbXKTCsy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Nov 2007 02:48:54 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A177C200A25B;
	Tue, 20 Nov 2007 03:48:50 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 07262-01-86; Tue, 20 Nov 2007 03:48:50 +0100 (CET)
Received: from [192.168.0.132] (cust.fiber-lan.vnet.lk.85.194.49.238.stunet.se [85.194.49.238])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 212F0200A1A4;
	Tue, 20 Nov 2007 03:48:50 +0100 (CET)
In-Reply-To: <20071119193137.GA27317@linux-mips.org>
References: <20071119160954.GA12244@paradigm.rfc822.org> <20071119193137.GA27317@linux-mips.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5-323899059"
Message-Id: <775F4404-2D0A-4E65-9401-E2193B96DBDC@27m.se>
Cc:	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Markus Gothe <markus.gothe@27m.se>
Subject: Re: [SPAM] Re: IP22 64Bit arcboot - current git crashes on 3 machines at different points
Date:	Tue, 20 Nov 2007 03:49:07 +0100
To:	Ralf Baechle <ralf@linux-mips.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5-323899059
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Afaik R4x00 is just semi-64bit in contrast to the R5K, which derives  
from the R10K.

//Markus

On 19 Nov 2007, at 20:31, Ralf Baechle wrote:

> On Mon, Nov 19, 2007 at 05:09:54PM +0100, Florian Lohoff wrote:
>
>> i am seeing strange issues with 64 Bit kernels IP22 on different
>> machines. This came up when i tried the debian distribution kernel
>> which fails for me on 2 machines.
>
> I still haven't sorted out all the workarounds for the read-from- 
> compare
> bug in early R4000 / R4400 with the new time code.  It may not be the
> issue that's hitting you but the new time code definately has the  
> potencial
> to trigger the issue.
>
>   Ralf
>


--Apple-Mail-5-323899059
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHQksj6I0XmJx2NrwRAvhCAKCozDd7YHHnx9NqFg4VruGHltsM+ACgg0lC
MdljaQaJ2AQ6jeKaCaJle0k=
=c4s3
-----END PGP SIGNATURE-----

--Apple-Mail-5-323899059--
