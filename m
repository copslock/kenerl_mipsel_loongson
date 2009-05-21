Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 17:35:13 +0100 (BST)
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025323AbZEUQet (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2009 17:34:49 +0100
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4ED69B44FF;
	Thu, 21 May 2009 12:34:41 -0400 (EDT)
Received: from [102.117.138.10] (unknown [66.92.78.210]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 40AD7B44FA;
 Thu, 21 May 2009 12:34:25 -0400 (EDT)
Message-ID: <4A158284.5020602@pobox.com>
Date:	Thu, 21 May 2009 12:34:12 -0400
From:	Daniel Clark <dclark@pobox.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
MIME-Version: 1.0
Newsgroups: gmane.linux.ports.mips.general,gmane.linux.distributions.gnewsense.devel
To:	wuzhangjin@gmail.com
CC:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: Re: [loongson-support 00/27] linux PATCHes of loongson-based
 machines
References: <cover.1242851584.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
X-Enigmail-Version: 0.95.0
OpenPGP: id=AA95C349;
 url=https://www.fsf.org/about/staff/fsf-sysadmin-keyring.asc/download
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enigB677E61ADD3371684193FDCE"
X-Pobox-Relay-ID: 48911354-4625-11DE-A0AC-E80804BA4B0C-17709350!a-sasl-fastnet.pobox.com
Return-Path: <dclark@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dclark@pobox.com
Precedence: bulk
X-list: linux-mips
Message-ID: <20090521163412.EH_EicdA2Ea0-Y7KsqI_ioZCp56f_G6j1RPv61Si-hM@z>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB677E61ADD3371684193FDCE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

wuzhangjin@gmail.com wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
>    git://dev.lemote.com/rt4ls.git  to-ralf
> 	or
>    http://dev.lemote.com/cgit/rt4ls.git/log/?h=3Dto-ralf

BTW git to dev.lemote.com at least from some networks in the US is
really, really slow (like a few kb per second) - I have a mirror of some
other lemote stuff at:

http://not.freedsoftware.org/

and am putting a tarball of the most recent tag as of this moment up at:

http://not.freedsoftware.org/lemote-misc/suspend-linux/git-snapshot/rt4ls=
-02fd45578db2c88fcd03643e904cc0bffd8ef952.tar.bz2

I'd also be happy to mirror more git repositories, but so far no one has
been able to give me the right set of commands to do so. What I am doing
currently is in this file:

http://not.freedsoftware.org/CONTROL/gitmirror

The contents of which are:

#!/bin/sh

# I have no idea if this actually does the right thing. Google and
# friend who knows a lot about git were both unable to help.
# If you are a git-fu master, please contact sysadmin@gnu.org
# http://opensysadmin.com/images/i-love-git-so-much.jpg

cd /srv/mirror/DIST/lemote-misc/git-mirror/linux_loongson
git checkout -f
git fetch origin
git reset --hard origin
git pull

--=20
Daniel JB Clark   | Sys Admin, Free Software Foundation
pobox.com/~dclark | http://www.fsf.org/about/staff#danny


--------------enigB677E61ADD3371684193FDCE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKFYKEJNMr+aqVw0kRApbqAJ0eJMHVm+ixwO/tKPpQ66wtW4guXwCgjorn
jWv5t7qA0KmLKcKQoF32dPg=
=wtYU
-----END PGP SIGNATURE-----

--------------enigB677E61ADD3371684193FDCE--
