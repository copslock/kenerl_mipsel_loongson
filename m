Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Apr 2009 22:14:04 +0100 (BST)
Received: from adelie.canonical.com ([91.189.90.139]:29319 "EHLO
	adelie.canonical.com") by ftp.linux-mips.org with ESMTP
	id S20026286AbZDPVN4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Apr 2009 22:13:56 +0100
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1LuYu5-0000tV-Ok; Thu, 16 Apr 2009 22:13:49 +0100
Received: from [189.115.91.142] (helo=[192.168.77.100])
	by hutte.canonical.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <adilson@canonical.com>)
	id 1LuYu5-0008Pv-F6; Thu, 16 Apr 2009 22:13:49 +0100
Message-ID: <49E79F89.9090104@canonical.com>
Date:	Thu, 16 Apr 2009 18:13:45 -0300
From:	Adilson Oliveira <adilson@canonical.com>
Organization: Canonical
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
MIME-Version: 1.0
To:	Manuel Lauss <manuel.lauss@googlemail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Crazy idea: run linux on a mips-based photo frame
References: <49E644A9.6040503@canonical.com> <f861ec6f0904152344i781f794dkb463909d734c77f3@mail.gmail.com>
In-Reply-To: <f861ec6f0904152344i781f794dkb463909d734c77f3@mail.gmail.com>
X-Enigmail-Version: 0.95.7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <adilson@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adilson@canonical.com
Precedence: bulk
X-list: linux-mips

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Em 16-04-2009 03:44, Manuel Lauss escreveu:

> Shouldn't be too hard: from the debug output logs it seems to be derived from
> the Db1200 (the CE-port at least).  Find out the configuration of the memory and
> statis bus controllers and you should be set to run Raza's YAMON on it.

Hi.

Thanks for the tips, that inspires me to start a project :)
Do you know how could I obtain this information about the memory mapping?

[]s and TIA

Adilson.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAknnn4kACgkQYaKG37RGLIqDagCeNhKEhgQ5YgfDPmloOkab/RBv
560AnRCgBNovY48oWimNxk19oCe28/na
=sD5R
-----END PGP SIGNATURE-----
