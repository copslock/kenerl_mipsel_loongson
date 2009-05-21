Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 15:37:48 +0100 (BST)
Received: from main.gmane.org ([80.91.229.2]:38050 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023696AbZEUOhl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 15:37:41 +0100
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M79Os-0003TH-Ti
	for linux-mips@linux-mips.org; Thu, 21 May 2009 14:37:39 +0000
Received: from terminus-est.gnu.org ([66.92.78.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Thu, 21 May 2009 14:37:38 +0000
Received: from dclark by terminus-est.gnu.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Thu, 21 May 2009 14:37:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	Daniel Clark <dclark@pobox.com>
Subject:  Re: [loongson-support 00/27] linux PATCHes of loongson-based   machines
Date:	Thu, 21 May 2009 10:37:14 -0400
Message-ID:  <4A15671A.10209@pobox.com>
References:  <cover.1242851584.git.wuzhangjin@gmail.com>	 <4A14846A.3080006@pobox.com> <1242865038.21692.624.camel@falcon>
Mime-Version:  1.0
Content-Type:  multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0FFC3BAECCB51DF6ACBFA215"
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: terminus-est.gnu.org
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
In-Reply-To: <1242865038.21692.624.camel@falcon>
X-Enigmail-Version: 0.95.0
OpenPGP: id=AA95C349;
	url=https://www.fsf.org/about/staff/fsf-sysadmin-keyring.asc/download
Cc:	gnewsense-dev@nongnu.org
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dclark@pobox.com
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0FFC3BAECCB51DF6ACBFA215
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wu Zhangjin wrote:
>> BTW for me, this is interesting in the context of
>> http://config.fsf.org/trac/public/wiki/RmsLinuxForYou , which I have
>> several people helping me test at the moment - currently the biggest
>> issue is hard crashes every day or other day, or more frequently if
>> there is a lot of disk or usb I/O.
>>
>=20
> perhaps Yan hua<yanh@lemote.com> can give some help on this problem.
>=20
> did you compile the kernel with -mfix-ls2f-kernel option? if not, pleas=
e
> use it. it may give some help on reducing the hard crashes.

I am compiling with:

cflags-$(CONFIG_MACH_LM2F) +=3D -Wa,-mfix-ls2f-kernel -Wa,--no-warn
(in arch/mips/Makefile)

I think that was at yanh's suggestion; it was from someone at lemote.

I am compiling on a gnewsense-mipsel-l distribution, with the addition
of the lemote binutils from dev.lemote.com, currently at:

binutils_2.18.1~cvs20080103-7.loongson.r03_mipsel.deb

The source and binary debs for that I also have up at:
http://config.fsf.org/packages/dists/gnewsense-mipsel-l/lemote-dev-binuti=
ls/

I am planning on compiling a 2.6.29.3-based linux (eg the tip of the git
tree you pointed at) for rms, since it seems like it includes the
suspend-resume support we want to test, and is what hackers are
currently working on. If there is a specific git tag you think it would
be good to test, please name it :-)

I will post to gnewsense-dev@nongnu.org when that's ready and confirmed
to boot and not crash really quickly (and stop posting to this really
long set of lists / people ...)

--=20
Daniel JB Clark   | Sys Admin, Free Software Foundation
pobox.com/~dclark | http://www.fsf.org/about/staff#danny


--------------enig0FFC3BAECCB51DF6ACBFA215
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKFWcaJNMr+aqVw0kRAtjuAJ4zL5JhtpffY+7i+oFwTdlmru3aAwCgtuAG
sBJHalBVB6sYlR7+amM+t1Y=
=+/uv
-----END PGP SIGNATURE-----

--------------enig0FFC3BAECCB51DF6ACBFA215--
