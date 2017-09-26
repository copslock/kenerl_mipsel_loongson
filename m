Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2017 15:59:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4487 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992078AbdIZN7VdfI0a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2017 15:59:21 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 211F1B4B1F594;
        Tue, 26 Sep 2017 14:59:12 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 26 Sep
 2017 14:59:15 +0100
Date:   Tue, 26 Sep 2017 14:59:14 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: potential deadlock in r4k_flush_cache_sigtramp()
Message-ID: <20170926135914.GW17077@jhogan-linux.le.imgtec.org>
References: <20170923134021.GN32076@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline
In-Reply-To: <20170923134021.GN32076@ZenIV.linux.org.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

--lrvsYIebpInmECXG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Sat, Sep 23, 2017 at 02:40:21PM +0100, Al Viro wrote:
> 	Calling get_user_pages_fast() while holding ->mmap_sem is
> asking for trouble:
>=20
> CPU1: r4k_flush_cache_sigtramp()
> 	down_read(&current->mm->mmap_sem);
>=20
> CPU2: (running thread with the same ->mm): sys_pkey_alloc()
> 	down_write(&current->mm->mmap_sem);
>=20
> CPU1:
> 	pages =3D get_user_pages_fast(addr, 1, 0, &args.page);
> which hits an absent page and goto slow.  Then it goes on to
>         ret =3D get_user_pages_unlocked(start, (end - start) >> PAGE_SHIF=
T,
>                                       pages, write ? FOLL_WRITE : 0);
> which does
>         return __get_user_pages_unlocked(current, current->mm, start, nr_=
pages,
>                                          pages, gup_flags | FOLL_TOUCH);
> which does
>         down_read(&mm->mmap_sem);
>         ret =3D __get_user_pages_locked(tsk, mm, start, nr_pages, pages, =
NULL,=20
>                                       &locked, false, gup_flags);
>=20
> and we have a classical deadlock on recursive down_read() (thread 1: down=
_read()
> gets the rwsem; thread 2: down_write() blocks waiting for thread 1 to rel=
ease
> it; thread 1: down_read() blocks waiting for thread 2 to get through down=
_write()
> and eventual up_write(), which completes the deadlock).

Hmm, indeed. Thanks for spotting that one.

> Replacing pkey_alloc(2) with e.g. mmap(2) turns that from hard deadlock i=
nto
> something killable, but while "with bad timing you might get process stuck
> hard" is worse than "with bad timing you might get process stuck until you
> kill -9 it", neither is a good thing.
>=20
> I'm not familiar enough with arch/mips guts to suggest any variant of sol=
ution;
> replacing get_user_pages_fast() with get_user_pages_locked() would solve =
the
> deadlock, but that loses the fast path; not taking ->mmap_sem there have
> local_r4k_flush_cache_sigtramp() run without fcs_args->mm being locked, w=
hich
> might or might not be a problem.  Suggestions?

I suspect my concern was the theoretical situation where:

task1 hits an FPU branch instruction that needs emulating
	this creates a trampoline above the stack in user memory to
	execute the delay slot instruction, and calls
	r4k_flush_cache_sigtramp()

task2 in same process changes the memory mapping somehow.

SMP call to local_r4k_flush_cache_sigtramp()
	it may do cache op using the user virtual address when same mm
	active, or using kmap otherwise.

For the kmap case (SMP call to CPU with different process executing) its
holding a reference to the page so it should be fine. If the page was
swapped out or otherwise copied and it icache flushed the old page, then
I think the new page would get flushed when swapped back in so thats
fine.

Otherwise I can't imagine a situation where it'd misbehave unless
userland explicitly remapped the memory and it accessed using the
virtual address, in which case its asking for trouble.

Therefore I suspect it should be safe to drop the mmap_sem, but thats
OTOH. Have I missed anything important?

Thanks
James

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlnKXSQACgkQbAtpk944
dnrRPQ//ZmQFwDu7CejwqzHyi/u3CCecII8btEZe2rNTCS61zTl3tl9EQXcJPFbF
r81OfroJz81yt2xl1tINAXh12W5DxMYF+sraJRaLf7XH9537sZdB2COxtdSKiEkt
zKjvpeEZRC8tz/P+E7ejUyJGt7sjxvedVk/zB/r3yz/TDzwvmeGv6cZexAmCB4HI
PFpq7DVuIZWGB+xo0Moq9J+rAalevp9SJVbnyD0uFDFdRI/+EMZ2RMtH7SoHmOhO
fp1iuxTdaH1UXQDanIlJOyc5eKpOw7Vz44qtlK14ahK13TiwTT3lZM0OO+XsLeT3
HH3vgCI8qEBP8dOaK2KQcp9aYQ+w3CBXWd5qaipl7jgzLNYKCU7lL33zKm/GLHn1
sZe9OJOS0Tb0Z9FeTJ+Jq9w1OnELR2ViQRDzU8dMM0voL8BUugB5c6lUUyqkPp1O
JsQnlaC1r8VZ1gNuWNREjla5HY1mkKgl5NLiLLI/sy/VCHz/mI6i1UiKSJBBJ5SL
UJiAF96MeJYkH1O5VRX3qFOC4zY/QmQkPhwRi8T6yREIbtX9uUJu4Au/YyjSRlrn
cxYburPxOq1ATqRaUAdgq5XINl4JFX1nOecMLpUS9sfkPUK7r3ktVYppGPMnwV4Z
bAD4P+BZ4uZxO2+PGYR4abVXLCXkIw1Nhu4FEGkZ6Fu2JCtdfSc=
=A3Pd
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--
