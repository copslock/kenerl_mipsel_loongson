Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2005 23:06:57 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:52258
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8226068AbVCaWGl>; Thu, 31 Mar 2005 23:06:41 +0100
Received: (qmail 6050 invoked by uid 210); 1 Apr 2005 08:06:30 +1000
Received: from 10.0.0.194 by www (envelope-from <stuartl@longlandclan.hopto.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.2. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.194):. 
 Processed in 0.095803 secs); 31 Mar 2005 22:06:30 -0000
Received: from unknown (HELO ?10.0.0.194?) (10.0.0.194)
  by 192.168.5.1 with SMTP; 1 Apr 2005 08:06:29 +1000
Message-ID: <424C745F.6030204@longlandclan.hopto.org>
Date:	Fri, 01 Apr 2005 08:06:23 +1000
From:	Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	dfsd df <tomcs163@yahoo.com.cn>
CC:	linux-mips@linux-mips.org
Subject: Re: Some questions about kernel tailoring
References: <20050331094116.66254.qmail@web15805.mail.cnb.yahoo.com>
In-Reply-To: <20050331094116.66254.qmail@web15805.mail.cnb.yahoo.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEA83943D8C5FD892853D2CCB"
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEA83943D8C5FD892853D2CCB
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

dfsd df wrote:
> Thanks again!

BTW: Your mail client has just switched back to its fixation on HTML.
Could you please have a close look at the settings and disable HTML mail
composition?  (at least for this email address/domain)

> Because of the limitation of memory, I don't want to use YAMON.
> Using gzip -9, I can get a kernel more small than the kernel made by
> "make zImage".
> So I want to write a very simple bootloader and make a self-decompressed
> kernel.

AFAIK the bootloader is only resident during the initial bootup, and is
normally gone by the time userland kicks in.  (Think about it -- what's
 the point in it sticking around, its job is done ;-)

If you've got at least 8MB RAM you should be okay.  (And lets face it --
Linux on 4MB *IS NOT PRETTY* -- Been there, done that)  How much RAM are
you working with?
-- 
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+

--------------enigEA83943D8C5FD892853D2CCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCTHRnuarJ1mMmSrkRAi0wAJ4jGdtolWtp9OlNyDjThvEh+Tre9QCeL9Bb
s0CA4iVeozHsZcNMkuKH+ms=
=pw8G
-----END PGP SIGNATURE-----

--------------enigEA83943D8C5FD892853D2CCB--
