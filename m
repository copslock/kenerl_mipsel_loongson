Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2009 00:45:15 +0100 (BST)
Received: from main.gmane.org ([80.91.229.2]:37028 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023430AbZETXpH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 May 2009 00:45:07 +0100
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M6vT5-0000h9-7y
	for linux-mips@linux-mips.org; Wed, 20 May 2009 23:45:03 +0000
Received: from hefty-smurf.mit.edu ([18.214.0.239])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 20 May 2009 23:45:03 +0000
Received: from dclark by hefty-smurf.mit.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 20 May 2009 23:45:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	Daniel Clark <dclark@pobox.com>
Subject:  Re: [loongson-support 00/27] linux PATCHes of loongson-based machines
Date:	Wed, 20 May 2009 18:30:02 -0400
Message-ID: <4A14846A.3080006@pobox.com>
References:  <cover.1242851584.git.wuzhangjin@gmail.com>
Mime-Version:  1.0
Content-Type:  multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig84828C992A86731BBE725447"
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: hefty-smurf.mit.edu
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
X-archive-position: 22899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dclark@pobox.com
Precedence: bulk
X-list: linux-mips
Message-ID: <20090520223002.eKwYtqLMQEXekUS1iPYx1mzyTBI9_BG2BYjHY3DrLTM@z>

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
