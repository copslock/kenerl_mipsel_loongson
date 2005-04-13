Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2005 05:19:26 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:25192
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225257AbVDMETG>; Wed, 13 Apr 2005 05:19:06 +0100
Received: (qmail 19511 invoked by uid 210); 13 Apr 2005 14:18:56 +1000
Received: from 10.0.0.251 by www (envelope-from <stuartl@longlandclan.hopto.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.2. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.251):. 
 Processed in 0.097415 secs); 13 Apr 2005 04:18:56 -0000
Received: from unknown (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 13 Apr 2005 14:18:56 +1000
Message-ID: <425C9DBF.6090807@longlandclan.hopto.org>
Date:	Wed, 13 Apr 2005 14:19:11 +1000
From:	Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Greg Weeks <greg.weeks@timesys.com>
CC:	linux-mips@linux-mips.org
Subject: Re: BogoMIPS
References: <425BDCE4.6070708@timesys.com>
In-Reply-To: <425BDCE4.6070708@timesys.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6ECE6BC35CE34562CD0BB806"
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6ECE6BC35CE34562CD0BB806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg Weeks wrote:
> Has anyone else noticed BogoMIPS is zero? Are we not doing the calibrate
> delay?
>
> Greg Weeks
>
> -bash-2.05b# cat /proc/cpuinfo
> system type             : MIPS Malta
> processor               : 0
> cpu model               : MIPS 4Kc V0.1
> BogoMIPS                : 0.00
> wait instruction        : yes
> microsecond timers      : yes
> tlb_entries             : 16
> extra interrupt vector  : yes
> hardware watchpoint     : yes
> VCED exceptions         : not available
> VCEI exceptions         : not available
> -
>

Probably, because it's no longer relevant these days.  It doesn't say
anything special.

> The more surprising it is that BogoMIPS have become a benchmark for
 > performance as important as extra inches in spam email.  Having been
 > a permanent annoynce over the years due to miss-interpretation by
 > users and due to excessive output on multiprocessor machines Linux
 > by default will no longer print the BogoMIPS number since 2.6.9-rc2.
-- <http://www.linux-mips.org/wiki/index.php/BogoMIPS>

Interestingly, my IP28 still shows the BogoMIPS reading in /proc/cpuinfo:
> stuartl@indigo ~ $ uname -a
> Linux indigo 2.6.10-mipscvs-20050115-ip28 #2 Sun Apr 3 08:24:18 EST 2005 mips64 R10000 V2.5  FPU V0.0 SGI Indigo2 GNU/Linux
> stuartl@indigo ~ $ cat /proc/cpuinfo
> system type             : SGI Indigo2
> processor               : 0
> cpu model               : R10000 V2.5  FPU V0.0
> BogoMIPS                : 193.53
> wait instruction        : no
> microsecond timers      : yes
> tlb_entries             : 64
> extra interrupt vector  : no
> hardware watchpoint     : yes
> VCED exceptions         : not available
> VCEI exceptions         : not available
> stuartl@indigo ~ $

So honestly, I don't know what's happening with BogoMIPS. :-)  What I do
know however, it isn't worth a cracker in terms of benchmarking value. ;-)

--
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+

--------------enig6ECE6BC35CE34562CD0BB806
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCXJ3DuarJ1mMmSrkRAn6VAJ94r1URQOXGU5eMxGVXGyL9MGeIPgCfeIq8
6CnigapjkHOQMKnv6gEMl44=
=0ItE
-----END PGP SIGNATURE-----

--------------enig6ECE6BC35CE34562CD0BB806--
