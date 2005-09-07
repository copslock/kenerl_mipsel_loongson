Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Sep 2005 00:59:53 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:36019
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225756AbVIFX6n>; Wed, 7 Sep 2005 00:58:43 +0100
Received: (qmail 29360 invoked by uid 210); 7 Sep 2005 10:05:28 +1000
Received: from 10.0.0.251 by www (envelope-from <redhatter@gentoo.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.2. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.251):. 
 Processed in 0.124962 secs); 07 Sep 2005 00:05:28 -0000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 7 Sep 2005 10:05:27 +1000
Message-ID: <431E2ECF.1050501@gentoo.org>
Date:	Wed, 07 Sep 2005 10:05:35 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Indy R4600 on Linux 2.6 -- possible cache issue?
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF5FF44C2CBFAA49ADC82EF21"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF5FF44C2CBFAA49ADC82EF21
Content-Type: multipart/mixed;
 boundary="------------010900070008010907040109"

This is a multi-part message in MIME format.
--------------010900070008010907040109
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

I've been tinkering with my Indy, trying to coax the contankerous
machine into booting Linux 2.6, until last night, without success.

For the record, the Indy's specs are as follows:
CPU:	R4600 SC rev2.0 @ 133MHz
RAM:	256MB
HDD:	9.0GB IBM SCSI
Video:	8-bit Newport (XL)

It successfully boots Linux 2.4 without incident... even in 64-bit mode.
---------------------------------8<-------------------------------------
> Linux indy 2.4.29-mipscvs-20050130 #2 Tue Feb 8 19:44:48 EST 2005 mips64 R4600 V2.0  FPU V2.0 SGI Indy GNU/Linux
>   09:36:06 up  8:02,  0 users,  load average: 0.02, 0.01, 0.00
--------------------------------->8-------------------------------------

The tests below have been conducted using the stock ip22_defconfig with
debugging options enabled and CPU set to R4x00.

Previously, it would either not boot at all, or it would just get past
starting userland before hard locking (as in, no SysRq joy, and no
response from pressing the power button).

My current kernel, made from a CVS HEAD snapshot last Sunday (4th
September) with cache disabled is the first one I've made which boots
consistently, although it's _very_ slow.

I'm wondering if we could be hitting a caching issue with the R4600 CPU?
 I also suspect the wd33c93 SCSI driver has a role to play in the
instability, as I'm getting a lot of warnings from it, they all look
something like the following

---------------------------------8<-------------------------------------
> [timestamp] drivers/scsi/wd33c93.c:77? spin_is_locked on uninitialised spinlock 893ce340.
--------------------------------->8-------------------------------------

The exact line number scrolls too quickly to read. (I'm not using serial
console presently -- I might try that later though)

As I say, the system boots, and in fact, I had the machine successfully
running e2fsck on its root partition (8GB) last night with this kernel.
 After 2 hours or so, it managed to get 75% though the filesystem check
-- I don't know beyond that, as it was approaching 1:00AM and I needed
sleep. ;-)  It's running extremely slow though, so I'd like to discover
what's causing these crashes.

The crashes happen on most boots with cache enabled.  Occasionally, I'll
get lucky, and the machine will boot on its own, but it's like 1 in
every 5 boots or so.

I'll see if I can get a dump out of this box, but as I say, it gets
through a file system check and activating swap, that's further than
I've ever got this machine running with cache enabled.
-- 
 ____                   _             Stuart Longland (a.k.a Redhatter)
/  _ \   ___    ___  __| |__  __   __ Gentoo Linux/MIPS Cobalt and Docs
- (_) \ /   \  ;   \(__   __)/  \ /  \                        Developer
 \    //  O _| / /\ \  | |  | /\ | /\ |
 /   / \   /__| /  \ \ | |  | \/ | \/ |
(___/   \____/|_;  |_| \_/   \__/ \__/ http://dev.gentoo.org/~redhatter

--------------010900070008010907040109
Content-Type: application/gzip;
 name="debug.config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="debug.config.gz"

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
uS3HmcGdvF6Up8tS/wFpFRsN+VMAAA==
--------------010900070008010907040109--

--------------enigF5FF44C2CBFAA49ADC82EF21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDHi7SuarJ1mMmSrkRAhXkAJ4xiRs7/vThbevj/wzGMYk6R5m7XACeJLc6
Ww37fxskrov+Kek4SeJQzAs=
=WJrU
-----END PGP SIGNATURE-----

--------------enigF5FF44C2CBFAA49ADC82EF21--
