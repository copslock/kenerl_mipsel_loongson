Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2005 23:20:48 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:16667
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225994AbVC3WUc>; Wed, 30 Mar 2005 23:20:32 +0100
Received: (qmail 27425 invoked by uid 210); 31 Mar 2005 08:20:21 +1000
Received: from 10.0.0.194 by www (envelope-from <stuartl@longlandclan.hopto.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.2. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.194):. 
 Processed in 0.097029 secs); 30 Mar 2005 22:20:21 -0000
Received: from unknown (HELO ?10.0.0.194?) (10.0.0.194)
  by 192.168.5.1 with SMTP; 31 Mar 2005 08:20:20 +1000
Message-ID: <424B2621.20006@longlandclan.hopto.org>
Date:	Thu, 31 Mar 2005 08:20:17 +1000
From:	Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	dfsd df <tomcs163@yahoo.com.cn>
CC:	linux-mips@linux-mips.org
Subject: Re: Some questions about kernel tailoring
References: <20050330073742.28983.qmail@web15807.mail.cnb.yahoo.com>
In-Reply-To: <20050330073742.28983.qmail@web15807.mail.cnb.yahoo.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFF125442FC24EC6681048760"
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7546
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFF125442FC24EC6681048760
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

dfsd df wrote:
> Hello, everybody:
>      Now, I participate to porting linux to MIPS platform. I'm a newbie.
>  
>      I met some questions, I hope somebody can tell me why or give me
> some hints! thanks!
>  
> The board is Malta, CPU is MIPS4kc. I downloaded kernel src from
> ftp.mips.com <ftp://ftp.mips.com>
>  
> 1. I use "make zImage" for kernel-2.4.3, everything is ok!
> But using "make zImage" for kernel-2.4.18, I failed, It could only
> build a vmlinux file.

That's correct... 'vmlinux' is your kernel.  mips doesn't use zImages.

> I find it's because of no rules in arch/mips/boot/Makefile to build
> zImage.
> So I modified the arch/mips/boot/Makefile, It worked fine.
>  but when excuted "./mkboot zImage.tmp zImage", It generated a very big
> zImage file. After noticing "file size exceed", the system delete the
> zImage file automatically!
> 

Try running mkboot on the vmlinux file.

> what's wrong about it? It's ok for kernel-2.4.3. and I can make sure
> that the mkboot is no problem.

A newer kernel mightn't be a bad idea either... 2.4.3 is very old now.

> 2. I only selectd board and cpu type when compiling the kernel-2.4.3.
> If using make ,the vmlinux size is about 780k. If using "make zImage",
> the zImage file is about 580k.
> I think that's a minimun size by using "make menuconfig".
> but I use gzip to compress this two files, its size became only 1/3 of
> their original size.
>  
> So I'm puzzled why "make zImage" don't use gzip compress method? If so ,
> we can get a more small kernel, isn't it?
>  
> thanks again!

I'll let the guru's chime in here :-)

(PS... Please refrain from HTML email on this list)

-- 
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+

--------------enigFF125442FC24EC6681048760
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCSyYmuarJ1mMmSrkRAo/1AJwIx5Pbs3oIvmJEx/GppGGWRQ3hbQCeOVpF
OUMmuq/L4cE1NbDDq4Xs/Rk=
=zapk
-----END PGP SIGNATURE-----

--------------enigFF125442FC24EC6681048760--
