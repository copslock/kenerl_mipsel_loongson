Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2005 04:49:46 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:37128
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225235AbVCaDta>; Thu, 31 Mar 2005 04:49:30 +0100
Received: (qmail 1137 invoked by uid 210); 31 Mar 2005 13:49:20 +1000
Received: from 10.0.0.194 by www (envelope-from <stuartl@longlandclan.hopto.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.2. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.194):. 
 Processed in 0.09421 secs); 31 Mar 2005 03:49:20 -0000
Received: from unknown (HELO ?10.0.0.194?) (10.0.0.194)
  by 192.168.5.1 with SMTP; 31 Mar 2005 13:49:19 +1000
Message-ID: <424B733B.3060307@longlandclan.hopto.org>
Date:	Thu, 31 Mar 2005 13:49:15 +1000
From:	Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	dfsd df <tomcs163@yahoo.com.cn>
CC:	linux-mips@linux-mips.org
Subject: Re: Some questions about kernel tailoring
References: <20050331014935.81645.qmail@web15801.mail.cnb.yahoo.com>
In-Reply-To: <20050331014935.81645.qmail@web15801.mail.cnb.yahoo.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEB55D671CCC0CEC60146BF54"
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEB55D671CCC0CEC60146BF54
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

dfsd df wrote:
> Thanks for your reply!
> 
>>That's correct... 'vmlinux' is your kernel.  mips
>>doesn't use zImages.
> 
> But , the vmlinux is too big, Waht should I do? Is the
> vmlinux already compressed?

Normally you manually gzip it -- but it will largely depend on what the
bootloader for your device expects.  Incidentally, are you trying to
boot the kernel directly, or via something like U-boot or YAMON?
AFAIK these evaluation boards are not designed to directly boot a kernel.

>>(PS... Please refrain from HTML email on this list)
> Sorry, I'm a newbie, I really don't know what you
> mean. :-)

Rich text emails -- in layman's terms.  Couple of reasons for this:
* They do make the email slightly larger
* Not everyone can see HTML
* SPAM and Viruses commonly exploit HTML

Never mind though, as it seems your mail client has figured to use
plaintext already. ;-)

-- 
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+

--------------enigEB55D671CCC0CEC60146BF54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCS3NBuarJ1mMmSrkRApVUAJ4sxYFSDyuyWy/eqRswFeSPlb5LQwCeLZH+
n3/fwjuQ/0y9ttaMxhn1qFg=
=zmIE
-----END PGP SIGNATURE-----

--------------enigEB55D671CCC0CEC60146BF54--
