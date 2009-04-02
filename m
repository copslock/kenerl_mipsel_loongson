Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 13:09:38 +0100 (BST)
Received: from latitanza.investici.org ([82.94.249.234]:31659 "EHLO
	latitanza.investici.org") by ftp.linux-mips.org with ESMTP
	id S20031367AbZDBMJd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Apr 2009 13:09:33 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: arc@autistici.org) with ESMTP id A5FA598058
Message-ID: <49D4AAF7.40309@gnu.org>
Date:	Thu, 02 Apr 2009 14:09:27 +0200
From:	Graziano Sorbaioli <graziano@gnu.org>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
To:	Graziano Sorbaioli <graziano@gnu.org>, linux-mips@linux-mips.org
Subject: Re: getcontext needs to be implemented on mips
References: <49D376E4.4090503@gnu.org> <20090402074641.GB28319@adriano.hkcable.com.hk>
In-Reply-To: <20090402074641.GB28319@adriano.hkcable.com.hk>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <graziano@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: graziano@gnu.org
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Zhang Le ha scritto:

> Could you please just try glibc 2.9? Is there any difficulties with that?
> Backporting is no fun, I am afraid. Few, if not none, people would like to do
> that, unless paid.


Unfortunately gNewSense mips-l is a more conservative port staying with
Debian 5.0 lenny packages, which means staying with glibc-2.7.

This is why I asked for help.

Some references.

gNewSense mips-l:
http://wiki.gnewsense.org/Projects/GNewSenseToMIPS

our BTS:
http://bugs.gnewsense.org/

mips getcontext bug:
http://bugs.gnewsense.org/Bugs/00261


- --
Graziano Sorbaioli ~ sorbaioli.org

Libre Planet Italia
http://libreplanet.org/index.php/LibrePlanetItalia
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJ1Kr3Ttn97LA90HMRAo7jAKDryxuyQuJ40pWeokjKlZ/YAD9s3wCgnQ7f
3Y4HPGvHHFMyfOl7Rlswumo=
=4KcC
-----END PGP SIGNATURE-----
