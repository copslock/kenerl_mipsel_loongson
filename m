Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 23:30:49 +0100 (BST)
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50345 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023271AbZETWan (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 23:30:43 +0100
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E24AB19AC8;
	Wed, 20 May 2009 18:30:40 -0400 (EDT)
Received: from [18.214.0.239] (unknown [18.214.0.239]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 961E119AC7;
 Wed, 20 May 2009 18:30:25 -0400 (EDT)
Message-ID: <4A14846A.3080006@pobox.com>
Date:	Wed, 20 May 2009 18:30:02 -0400
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
	Erwan Lerale <erwan@thiscow.com>, rms@gnu.org
Subject: Re: [loongson-support 00/27] linux PATCHes of loongson-based
 machines
References: <cover.1242851584.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1242851584.git.wuzhangjin@gmail.com>
X-Enigmail-Version: 0.95.0
OpenPGP: id=AA95C349;
 url=https://www.fsf.org/about/staff/fsf-sysadmin-keyring.asc/download
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="------------enig84828C992A86731BBE725447"
X-Pobox-Relay-ID: D97BDF72-458D-11DE-BC6F-D766E3C8547C-17709350!a-sasl-quonix.pobox.com
Return-Path: <dclark@pobox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dclark@pobox.com
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig84828C992A86731BBE725447
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

wuzhangjin@gmail.com wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
>=20
> Dear all,
>=20
> I have cleaned up the source code of loongson-based machines support an=
d
> updated it to linux-2.6.29.3, the latest result is put to the following=
 git
> repository:
>=20
>    git://dev.lemote.com/rt4ls.git  to-ralf
> 	or
>    http://dev.lemote.com/cgit/rt4ls.git/log/?h=3Dto-ralf
>=20
> this job is based on the to-mips branch of Yanhua's
> git://dev.lemote.com/linux_loongson.git and the lm2e-fixes branch of Ph=
ilippe's
> git://git.linux-cisco.org/linux-mips.git. thanks goes to them.
>=20
> and also, thanks goes to Erwen and heihaier for testing the latest bran=
ch, and
> thanks ralf, zhangLe, john and the other guyes for reviewing the old br=
anch and
> giving good suggestions.
>=20
> the most differences between this branch and the old branch include:
>=20
>    * all of these patches are checked by script/checkpatch.pl, only a f=
ew
>    warnings left.
>=20
>    * the cs5536 part have been cleaned up deeply. the old pcireg.h is r=
emoved
>    via using the include/linux/pci_regs.h instead. and the old cs5536_v=
sm.c is
>    divided to several modules, one file one module.
>=20
>    * the source code in driver/video/smi in cleaned up a lot, two trash=
y header
>    files are removed, and several trashy functions are removed, lots of=
 coding
>    style errors and warnings are cleaned up.
>=20
>    * gcc 4.4 support, including 32bit and 64bit, and also it is gcc 4.3=

>    compatiable
>=20
> I have tested it in 32bit and 64bit with gcc 4.3 on fuloong(2e), fuloon=
g(2f),
> yeeloong(2f), all of them work well, and also test it in 32bit and 64bi=
t with
> gcc 4.4 on fuloong(2f), works normally. Erwen and heihaier have tested =
it in
> 64bit with gcc 4.4 on a yeeloong laptop.

Wow this is great. Does this branch also include the suspend-to-disk /
resume-from-disk code from the lemote 2.6.27 STD branch?

=46rom a user's perspective, what are the loongson-oriented improvements
of this branch over the existing 2.6.27 branch?

I'd also like to know if:

(a) the ec-modules and

(b) the rtl8187b code

that is currently separate from the main lemote linux 2.6.27 git (the
former in a git repository, the later only in a .tar.gz file as far as I
know) is included in the 2.6.29.3 branch now.

I can of course check this via git when I have internet access next, but
I'm guessing you would be able to provide context beyond just the code
changes to the answers of these questions  :-)

Oh, and one last thing - is compilation with the lemote-patched binutils
/ "-mfix-gs2f-kernel" "-mfix-ls2f-kernel" (I'm told these did the same
things, the name just changed for some reason - currently I'm using a
binutils / as that understands the "-mfix-ls2f-kernel" option) still
needed? Without this in the 2.6.27 branch, and esp. with the ec-modules,
there were very frequent hard linux crashes (sysrq keys not working).

BTW for me, this is interesting in the context of
http://config.fsf.org/trac/public/wiki/RmsLinuxForYou , which I have
several people helping me test at the moment - currently the biggest
issue is hard crashes every day or other day, or more frequently if
there is a lot of disk or usb I/O.

Thanks,
--=20
Daniel JB Clark   | Sys Admin, Free Software Foundation
pobox.com/~dclark | http://www.fsf.org/about/staff#danny


--------------enig84828C992A86731BBE725447
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFKFIRqJNMr+aqVw0kRAor3AJ4xZJVbbu8kzQrqTEGWEJ7tmBo+3QCfdf4g
jdKNGNqeMd/Iu1FbioDu/14=
=k29p
-----END PGP SIGNATURE-----

--------------enig84828C992A86731BBE725447--
