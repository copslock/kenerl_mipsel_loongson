Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2004 15:47:00 +0100 (BST)
Received: from skl1.ukl.uni-freiburg.de ([IPv6:::ffff:193.196.199.1]:52643
	"EHLO relay1.uniklinik-freiburg.de") by linux-mips.org with ESMTP
	id <S8224929AbUHROqz>; Wed, 18 Aug 2004 15:46:55 +0100
Received: from ktl77.ukl.uni-freiburg.de (ktl77.ukl.uni-freiburg.de [193.196.226.77])
	by relay1.uniklinik-freiburg.de (Email) with ESMTP
	id 223ED2F2EA; Wed, 18 Aug 2004 16:46:49 +0200 (CEST)
From: Max Zaitsev <maksik@gmx.co.uk>
Organization: Mutella Dev co.
To: "Kaj-Michael Lang" <milang@tal.org>
Subject: Re: O2 arcboot 32-bit kernel boot fix
Date: Wed, 18 Aug 2004 16:46:53 +0200
User-Agent: KMail/1.6.2
References: <001401c483b8$51d289f0$54dc10c3@amos> <200408181405.53977.maksik@gmx.co.uk> <003901c48530$577b4f80$54dc10c3@amos>
In-Reply-To: <003901c48530$577b4f80$54dc10c3@amos>
Cc: <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408181646.53698.maksik@gmx.co.uk>
Return-Path: <maksik@gmx.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksik@gmx.co.uk
Precedence: bulk
X-list: linux-mips

> Did you just use the small fix or did you use the whole patch ?
>

No, I've just used the original 3.8.1 distribution and could not compile that 
I've tried it like a month ago and did not get anywhere neither with 
self-compilation nor with cross-compilation. I wrote Guido Guenther and he 
had said that he only tried to compile arcboot with gcc 2.95 and that gcc 3.x 
might have problems stripping some symbols that we want from the binary, 
while leaving the others, that we don't want... That would explain the factor 
10 increase in the resulting file size and it's inability to do anything...

So the thing is that the original arcboot 3.8.1 does not work for me if I 
compile (whereas the debian binary of the same version does), so it made no 
sense for me to try to apply your patch. I need to find a way to compile 
arcboot properly first. How do you do that yourself? Or do you think your 
fixes in makefiles make difference already? Actually, you've changed the 
LDFLAGS, which could be the problem... OK, I'll give it a try and let you 
know how it was.

Regards,
Max
