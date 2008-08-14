Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2008 07:32:46 +0100 (BST)
Received: from mail.lysator.liu.se ([130.236.254.3]:64402 "EHLO
	mail.lysator.liu.se") by ftp.linux-mips.org with ESMTP
	id S20022278AbYHNGci (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Aug 2008 07:32:38 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 4D8C02011D45;
	Thu, 14 Aug 2008 08:32:34 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 15463-01-38; Thu, 14 Aug 2008 08:32:34 +0200 (CEST)
Received: from [192.168.27.166] (152-186-96-87.cust.blixtvik.se [87.96.186.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 01D562011D40;
	Thu, 14 Aug 2008 08:32:33 +0200 (CEST)
Message-ID: <48A3D108.5050408@27m.se>
Date:	Thu, 14 Aug 2008 08:30:32 +0200
From:	Markus Gothe <markus.gothe@27m.se>
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
MIME-Version: 1.0
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: Re: "indy_volume_button" [sound/oss/hal2.ko] undefined
References: <20080813125954.GA3203@deprecation.cyrius.com> <20080813205836.GA10796@alpha.franken.de>
In-Reply-To: <20080813205836.GA10796@alpha.franken.de>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Return-Path: <markus.gothe@27m.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markus.gothe@27m.se
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Thomas Bogendoerfer wrote:
> On Wed, Aug 13, 2008 at 03:59:55PM +0300, Martin Michlmayr wrote:
>> sound/oss/hal2.ko fails to build because indy_volume_button was
>> removed from the IP22 code.  Is sound/oss/hal2o going to be removed
>> before 2.6.27 is out?
>
> The OSS hal driver is still marked experimental and the only IP22 sound
> driver I'll care (and take care) is the alsa one. So if nobody objects
> I'll send a remove patch.
>
> Thomas.
>
I'm in favor of just maintaining the ALSA one... Let's get rid of the
OSS one since probably there is very little interest in using it...

//Markus

- --
_______________________________________

Mr Markus Gothe
Software Engineer

Phone: +46 (0)13 21 81 20 (ext. 1046)
Fax: +46 (0)13 21 21 15
Mobile: +46 (0)70 348 44 35
Diskettgatan 11, SE-583 35 Linköping, Sweden
www.27m.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIo9EE6I0XmJx2NrwRCK6HAJkBFgkt7iZ/qw4aZSKVNtjCsnK6GgCfZ69P
FxqjlaeL73885ImVhNnL3hA=
=vb+4
-----END PGP SIGNATURE-----
