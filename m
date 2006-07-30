Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jul 2006 00:20:25 +0100 (BST)
Received: from s2.ukfsn.org ([217.158.120.143]:17546 "EHLO mail.ukfsn.org")
	by ftp.linux-mips.org with ESMTP id S8133889AbWG3XUQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Jul 2006 00:20:16 +0100
Received: from hardknott.home.whinlatter.ukfsn.org (84-45-213-194.no-dns-yet.enta.net [84.45.213.194])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 20519E714C; Mon, 31 Jul 2006 00:20:06 +0100 (BST)
Received: from rleigh by hardknott.home.whinlatter.ukfsn.org with local (Exim 4.62)
	(envelope-from <rleigh@whinlatter.ukfsn.org>)
	id 1G7KZr-0006Lt-QT; Mon, 31 Jul 2006 00:20:07 +0100
From:	Roger Leigh <rleigh@whinlatter.ukfsn.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, 380531-silent@bugs.debian.org
Subject: Re: Bug#380531: linux-2.6: mips and mipsel personality(2) support is broken
References: <20060730183939.7119.48747.reportbug@hardknott.home.whinlatter.ukfsn.org>
	<20060730224137.GP17134@deprecation.cyrius.com>
Date:	Mon, 31 Jul 2006 00:20:05 +0100
In-Reply-To: <20060730224137.GP17134@deprecation.cyrius.com> (Martin
	Michlmayr's message of "Mon, 31 Jul 2006 00:41:37 +0200")
Message-ID: <87veper87u.fsf@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-Path: <rleigh@whinlatter.ukfsn.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rleigh@whinlatter.ukfsn.org
Precedence: bulk
X-list: linux-mips

--=-=-=
Content-Transfer-Encoding: quoted-printable

Martin Michlmayr <tbm@cyrius.com> writes:

> FYI, but report tht "mips and mipsel personality(2) support is broken"
>
> * Roger Leigh <rleigh@debian.org> [2006-07-30 19:39]:
>> personality(2) only works the first time it is called [in the lifetime
>> of a process/program].  All subsequent calls return EPERM, which is
>> not a documented return value; I can see no mention of it in
>> kernel/execdomain.c.  None of the other architectures I have tested
>> (amd64, arm, i386, ia64, powerpc) behave this way: personality(2) is
>> not a privileged call.
>>=20
>> This happens no matter what the value of persona is, even if it is
>> just 0xffffffff to query the current personality.

Just a follow up:

There is a twist to the behaviour:

If personality(2) is called with a personality other than 0xffffffff
(query), and it fails, a subsequent call (any persona value) will
succeed.

I can't see any reason for the behaviour looking at the
kernel/execdomain.c or arch/mips/kernel/linux32.c.  ths believes it's
due to a bug in the syscall interface:

<ths> I believe it is related to sign extension.
<ths> o32 queries with 0xffffffff, which is really 0xffffffffffffffff, then=
 the kernel compares against 0xffffffff.
<rleigh> I haven't heard of that.  Is it MIPS-specific, or a 64-bit-specifi=
c thing?
<ths> mips uses sign-extended registers for 32bit values.
<ths> There's no 64bit mode switch.
<ths> (The argument for the sys32_personality should be int, not long.)


=2D-=20
  .''`.  Roger Leigh
 : :' :  Debian GNU/Linux             http://people.debian.org/~rleigh/
 `. `'   Printing on GNU/Linux?       http://gutenprint.sourceforge.net/
   `-    GPG Public Key: 0x25BFB848   Please sign and encrypt your mail.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEzT6nVcFcaSW/uEgRAhlYAKDwVC2cKrLiDTv6IM5vveapSt4sNACfWbGo
Ka4e+Tgtds2j1eUFIxjsfDc=
=yFZw
-----END PGP SIGNATURE-----
--=-=-=--
