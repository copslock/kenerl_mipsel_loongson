Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Mar 2005 14:30:49 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:12841
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225924AbVCSOad>; Sat, 19 Mar 2005 14:30:33 +0000
Received: (qmail 16578 invoked by uid 210); 20 Mar 2005 00:30:21 +1000
Received: from 10.0.0.251 by www (envelope-from <stuartl@longlandclan.hopto.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.2. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.251):. 
 Processed in 0.112162 secs); 19 Mar 2005 14:30:21 -0000
Received: from unknown (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 20 Mar 2005 00:30:20 +1000
Message-ID: <423C3787.6090107@longlandclan.hopto.org>
Date:	Sun, 20 Mar 2005 00:30:31 +1000
From:	Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Netbooting CoLo on the Cobalt RaQ1
References: <423AD5A2.3060200@longlandclan.hopto.org> <20050318141208.GA26486@deprecation.cyrius.com>
In-Reply-To: <20050318141208.GA26486@deprecation.cyrius.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig14A63D519915E491327B3084"
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig14A63D519915E491327B3084
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Martin Michlmayr wrote:
> * Stuart Longland <stuartl@longlandclan.hopto.org> [2005-03-18 23:20]:
>
>>	It appears the RaQ1 is a special case, and does not look there to
>>download its kernel.  Does anyone know exactly where these boxes look
>>for the kernel image when netbooting?  That way, I can ammend[1] the
>>handbook with the new details.
>
>
> Possibly vmlinux_RAQ.gz.  In Debian, we have a file called vmlinux.gz
> and the symlinks vmlinux_raq-2800.gz and vmlinux_RAQ.gz pointing to
> it, and that seems to work for everyone.

Hi,
	Thanks for the reply.  I thought this might be the case.  I suspect
something weird is going on firmware wise.

	When this user tries to boot, the system reports back "Unknown
Compression Method".  A full log from the serial console is here:
<http://www.gurlinet.dk/upload/minicom.cap>.  I suspect the system, as
the colo-chain.elf is simply gzipped and named 'vmlinux.gz'.

	We also get the same error message when using the Debian netboot images
-- which is interesting to say the least.  I've looked around but
haven't seen any comments regarding Gentoo or Debian on a RaQ1.  Has
anyone tried installing a modern Linux distribution on these boxes?
--
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+

--------------enig14A63D519915E491327B3084
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCPDeKuarJ1mMmSrkRAiyuAJwJm8ELY60ZJjPOqpP+Qob8ZXJMMgCeKPWc
tDZlpyHiElS0ACU5uHwDDco=
=I0//
-----END PGP SIGNATURE-----

--------------enig14A63D519915E491327B3084--
