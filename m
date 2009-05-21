Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 17:34:50 +0100 (BST)
Received: from main.gmane.org ([80.91.229.2]:43685 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20025322AbZEUQen (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 17:34:43 +0100
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M7BE7-0008PL-03
	for linux-mips@linux-mips.org; Thu, 21 May 2009 16:34:39 +0000
Received: from terminus-est.gnu.org ([66.92.78.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Thu, 21 May 2009 16:34:38 +0000
Received: from dclark by terminus-est.gnu.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Thu, 21 May 2009 16:34:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	Daniel Clark <dclark@pobox.com>
Subject:  Re: [loongson-support 00/27] linux PATCHes of loongson-based machines
Date:	Thu, 21 May 2009 12:34:12 -0400
Message-ID:  <4A158284.5020602@pobox.com>
References:  <cover.1242851584.git.wuzhangjin@gmail.com>
Mime-Version:  1.0
Content-Type:  multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB677E61ADD3371684193FDCE"
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: terminus-est.gnu.org
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
X-Enigmail-Version: 0.95.0
OpenPGP: id=AA95C349;
	url=https://www.fsf.org/about/staff/fsf-sysadmin-keyring.asc/download
Cc:	gnewsense-dev@nongnu.org
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dclark@pobox.com
Precedence: bulk
X-list: linux-mips

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
