Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Sep 2004 01:16:52 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:54318
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225243AbUIXAQr>; Fri, 24 Sep 2004 01:16:47 +0100
Received: (qmail 7112 invoked from network); 24 Sep 2004 10:16:38 +1000
Received: from unknown (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 24 Sep 2004 10:16:38 +1000
Message-ID: <41536765.9000304@longlandclan.hopto.org>
Date: Fri, 24 Sep 2004 10:16:37 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen P. Becker" <geoman@gentoo.org>
CC: linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
References: <4152D58B.608@longlandclan.hopto.org> <4152E4FC.8000408@gentoo.org>
In-Reply-To: <4152E4FC.8000408@gentoo.org>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen P. Becker wrote:
>>     Using a MIPS64 config (built using gas-abi=o32 as suggested by
>> Kumba),
>> it doesn't even get that far:
>
> This is certainly wrong.  What you really want is gas-abi=o64.  Take a
> look at the O2 minimum patchset at http://www.total-knowledge.com, as
> the arch/mips/Makefile changes are what you need.  Using a 64-bit kernel
> on your indy is pointless unless you want to run n32 userland anyhow.

Ahh yes... sorry, it was after midnight (GMT+10) and my mind must've
been elsewhere -- I meant o64.  I was planning on moving to either n32
or n64 userland eventually, but I won't do that unless I can get a
64-bit kernel going.

> As of this moment (may change in the future), 2.4 kernels are much
> better for ip22 anyhow.  Serial console, indycam, and sound all work
> properly in 2.4.  In 2.6, serial console is broken, there is no indycam
> support, and I'm running into some issues with sound where the cpu usage
> runs way up.

Right.  Luckily I've got a framebuffer that Linux can talk to and I
haven't got an indycam.  But the sound issue may be a problem, I was
thinking at one point to use this box as a jukebox, but at the moment
I'm experimenting with mips64 to see what it can do.

I'll have a look at those patches & the O2 documentation, that should
give me some leads into sorting out the issue.  It would be nice to see
if I can squeeze better performance out of the aging beast.
- --
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFBU2dluarJ1mMmSrkRAvLAAJiGRTLJlg3stJyjA3bRYmM2a/aLAJ0TmcsJ
mpAfZVjU/2YHo1OoZp8D7Q==
=mUN8
-----END PGP SIGNATURE-----
