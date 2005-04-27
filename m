Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Apr 2005 19:56:36 +0100 (BST)
Received: from earth.resonance.org ([IPv6:::ffff:209.79.220.22]:1206 "EHLO
	earth.resonance.org") by linux-mips.org with ESMTP
	id <S8225337AbVD0S4R>; Wed, 27 Apr 2005 19:56:17 +0100
Received: from SillyPuddy.localdomain (earth.resonance.org [209.79.220.22])
	by earth.resonance.org (Postfix) with ESMTP id 28E378AD0F;
	Wed, 27 Apr 2005 11:56:48 -0700 (PDT)
Subject: Re: iptables/vmalloc issues on alchemy
From:	Josh Green <jgreen@users.sourceforge.net>
To:	Herbert Valerio Riedel <hvr@hvrlab.org>
Cc:	Pete Popov <ppopov@embeddedalley.com>, linux-mips@linux-mips.org
In-Reply-To: <1114505009.11315.37.camel@mini.intra>
References: <1114505009.11315.37.camel@mini.intra>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OZc5Q07mEa0x8npIoUIK"
Date:	Wed, 27 Apr 2005 20:49:44 +0200
Message-Id: <1114627785.17008.21.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-OZc5Q07mEa0x8npIoUIK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

In my case it seemed I was able to achieve a stable condition by loading
modules in a specific order.  I am not doing a lot of iptables rule
modifications currently though, but will be in the future.  I was
planning on doing some additional gdb debugging of the failure
(especially the initial large MMAP attempt by iptables, which was 1.5GB
in my case).  I wont be doing anything on this for quite a while though,
since I am currently away from the board I was doing this work on.  I'm
currently traveling so I'm not on the Linux MIPS list.  I would be
interested in any fixes to this problem though, so please CC me :)
Cheers.
	Josh Green

On Tue, 2005-04-26 at 10:43 +0200, Herbert Valerio Riedel wrote:
> hello!
>=20
> I'm seeing similiar problems to the ones that Josh Green reported some
> time ago on this list (but alas didn't seem to get any further
> attention...)
>=20
> The problem seems to be so far, that when modifying the iptables
> structures by adding/flushing the rules, a state can be reached sooner
> or later (indeterministic! smells like race) where the data structure
> becomes invalid (although there are checks in the kernel which would
> prevent that); the result is either ip_tables.c:ipt_do_tables() causing
> an oops due to bad pointer dereferencing (or the kernel freezing w/o
> further notice at all), or the iptables tool being unable to
> retrieve/modify the rules from the kernel (and getting ENOMEM/EINVAL) or
> simply segfaulting due to other inconsistencies with the data...
>=20
> I was able to avoid corruption by replacing all vmalloc()/vfree() calls
> by kmalloc()/kfree()'s respectively in ip_tables.c; another variant
> which I was suggested to try helped as well: inserting flush_tlb_all()
> calls after every vmalloc() in said source file;
>=20
> I assumed so far, the issue must be alchemy specific, as I experienced
> this on a DbAu1550 board; and Josh had it on a DbAu1100; As it's a
> rather easy to trigger bug, I would have expected to see more bug
> reports if it affected more than just the alchemy's on 2.6.x;
> I tried it with a few kernel revisions from linux-mips' cvs (from 2.6.10
> upto 2.6.12rc2); also tried different compilers (debian's cross-gcc's
> 3.4.4 and 3.3.3), even switched the alchemy to little endian
> operation... all the same; everything else I use on that board has been
> rather stable so far, iptables are the only part which show up this
> vmalloc-issue so far...
>=20
> as to reproducing the bug, it's rather easy for me:
>=20
> a script repeatedly performing rule modifications should trigger the
> issue rather easily (possibly called over a remote ssh/telnet session,
> in order to create a bit of traffic as well...)
>=20
> set -x
> while :
> do
>   iptables -F || exit 1
>   iptables -A INPUT -i lo -j ACCEPT || exit 1
>   iptables -A INPUT -p udp -i eth0 --dport domain -j ACCEPT || exit 1
>   iptables -A INPUT -p udp -i eth0 --dport 6666 -j ACCEPT || exit 1
>   iptables -A INPUT -p tcp -i eth0 --dport ssh -j ACCEPT || exit 1
>   iptables -A INPUT -p tcp -i eth0 --dport http -j ACCEPT || exit 1
>   iptables -A INPUT -p tcp -i eth0 --dport https -j ACCEPT || exit 1
>   iptables -A INPUT -p tcp -i eth0 --dport 3496 -j ACCEPT || exit 1
> done
>=20
> or alternatively (requiring state & multiport helpers)
>=20
> while :
> do
>   iptables -F
>   iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT  || ex=
it 1
>   iptables -A INPUT -i lo -j ACCEPT || exit 1
>   iptables -A INPUT -p udp -i eth0 -m multiport --dports domain,6666 -j A=
CCEPT || exit 1
>   iptables -A INPUT -p tcp -i eth0 -m multiport --dports ssh,http,https,3=
496 -j ACCEPT || exit 1
>   iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT || ex=
it 1
>   iptables -A OUTPUT -o lo -j ACCEPT || exit 1
>   iptables -A OUTPUT -p udp -o eth0 -m multiport --dports ntp -j ACCEPT |=
| exit 1
>   iptables -A OUTPUT -p tcp -o eth0 -m multiport --dports www,https,8444,=
8445,8446,8454,8455,8456,8464,8465,8466,9225 -j ACCEPT || exit 1
> done
>=20
> regards,

--=-OZc5Q07mEa0x8npIoUIK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCb97IRoMuWKCcbgQRAjbWAJ9kvc2VtdfQM3lt3Drfa2iDTv3F2wCgxblf
RM3oRxeqUZsOKXbZNGReZEU=
=0GFP
-----END PGP SIGNATURE-----

--=-OZc5Q07mEa0x8npIoUIK--
