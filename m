Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2016 17:52:53 +0100 (CET)
Received: from mail-io0-f195.google.com ([209.85.223.195]:35457 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011610AbcAZQwvrZ5ZC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2016 17:52:51 +0100
Received: by mail-io0-f195.google.com with SMTP id 77so16072259ioc.2;
        Tue, 26 Jan 2016 08:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mX/Udwzojbsjuo8lbwha98fCJn1RrE4y+3nDSqTCclA=;
        b=JxLl0TvimIYDm/u6qaPrsIXhHjjbE5HdVrtYU6erdHdpDVEm2K8Slt5dLRbL8Nakpn
         TwgtKlyCHGDNVOdmpM6mrNzn/8ii59xUFZdiy3iDv6XWDxVoFZGBnAmw7z6sqDpuO2wX
         MbSnz+/4il4psRzm/lzN49Pd0FYjSks2w1fXXskB0M1i5LPGQ17UtgYxHNewSje3B/e8
         zBG86tneQ3bTdcf0e3xRwvrTJxj1qMVlbUTBXC7adfeCm1Uami+nViiWtRQ7Y9WJ96hT
         wZxb7QhctHWiqx3k/GKCbxNUXeG243phkRzblfOVv3/uDBvUUn6etCdIaaakwpICBXaT
         lcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mX/Udwzojbsjuo8lbwha98fCJn1RrE4y+3nDSqTCclA=;
        b=Z/F6nyOlz/AiqjgDTCkjJXXiwSMUYmwLgiOXNfffCn8DJ88++hT8tl2N1zMn/Q8x4g
         hkcGlVueQ/o9/PX7U6Od5Jec8zP5wsFyAzCTEMDRBIlNUknUjkVy1FWPVydNZYVxMfUs
         XXIEdMQsAznXMxsN0NuZrK5wBfN8Q9NGWDWQgThIksy9gBlpXdp/VYy9i4+WEHfto6dL
         lP5nmejgGXWlmXdOdudXc6uYZtg86dQhGTC0HfSYsPQs74QZ9eKcLlkY2lO6HW8scfLy
         ScvZIOdH6ecrJGIKcJl7yZxftibfrB/zE1CUyCCBBOux8eOyL5iMFE1UKXAbFjghynqV
         IhHA==
X-Gm-Message-State: AG10YOR9f3hy66lIR8zV12KzLkv4NpliiKaOIDyNijKH3+0YodIeUiCPoe/dyPKGOxHC5w==
X-Received: by 10.107.185.7 with SMTP id j7mr27290154iof.114.1453827165976;
        Tue, 26 Jan 2016 08:52:45 -0800 (PST)
Received: from localhost ([45.32.128.109])
        by smtp.gmail.com with ESMTPSA id cy7sm840556igc.6.2016.01.26.08.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 08:52:44 -0800 (PST)
Date:   Wed, 27 Jan 2016 00:52:07 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Leonid.Yegoshin@imgtec.com, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, mst@redhat.com, peterz@infradead.org,
        will.deacon@arm.com, virtualization@lists.linux-foundation.org,
        hpa@zytor.com, sparclinux@vger.kernel.org, mingo@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux@arm.linux.org.uk,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, mpe@ellerman.id.au, x86@kernel.org,
        xen-devel@lists.xenproject.org, mingo@elte.hu,
        linux-xtensa@linux-xtensa.org, james.hogan@imgtec.com,
        arnd@arndb.de, stefano.stabellini@eu.citrix.com,
        adi-buildroot-devel@lists.sourceforge.net, ddaney.cavm@gmail.com,
        tglx@linutronix.de, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org, joe@perches.com,
        linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
 <20160118081929.GA30420@gondor.apana.org.au>
 <20160118154629.GB3818@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <20160118154629.GB3818@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <boqun.feng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boqun.feng@gmail.com
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


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, Jan 18, 2016 at 07:46:29AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 18, 2016 at 04:19:29PM +0800, Herbert Xu wrote:
> > Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> > >
> > > You could use SYNC_ACQUIRE() to implement read_barrier_depends() and
> > > smp_read_barrier_depends(), but SYNC_RMB probably does not suffice.
> > > The reason for this is that smp_read_barrier_depends() must order the
> > > pointer load against any subsequent read or write through a dereferen=
ce
> > > of that pointer.  For example:
> > >=20
> > >        p =3D READ_ONCE(gp);
> > >        smp_rmb();
> > >        r1 =3D p->a; /* ordered by smp_rmb(). */
> > >        p->b =3D 42; /* NOT ordered by smp_rmb(), BUG!!! */
> > >        r2 =3D x; /* ordered by smp_rmb(), but doesn't need to be. */
> > >=20
> > > In contrast:
> > >=20
> > >        p =3D READ_ONCE(gp);
> > >        smp_read_barrier_depends();
> > >        r1 =3D p->a; /* ordered by smp_read_barrier_depends(). */
> > >        p->b =3D 42; /* ordered by smp_read_barrier_depends(). */
> > >        r2 =3D x; /* not ordered by smp_read_barrier_depends(), which =
is OK. */
> > >=20
> > > Again, if your hardware maintains local ordering for address
> > > and data dependencies, you can have read_barrier_depends() and
> > > smp_read_barrier_depends() be no-ops like they are for most
> > > architectures.
> > >=20
> > > Does that help?
> >=20
> > This is crazy! smp_rmb started out being strictly stronger than
> > smp_read_barrier_depends, when did this stop being the case?
>=20
> Hello, Herbert!
>=20
> It is true that most Linux kernel code relies only on the read-read
> properties of dependencies, but the read-write properties are useful.
> Admittedly relatively rarely, but useful.
>=20
> The better comparison for smp_read_barrier_depends(), especially in
> its rcu_dereference*() form, is smp_load_acquire().
>=20

Confused..

I recall that last time you and Linus came into a conclusion that even
on Alpha, a barrier for read->write with data dependency is unnecessary:

http://article.gmane.org/gmane.linux.kernel/2077661

And in an earlier mail of that thread, Linus made his point that
smp_read_barrier_depends() should only be used to order read->read.

So right now, are we going to extend the semantics of
smp_read_barrier_depends()? Can we just make smp_read_barrier_depends()
still only work for read->read, and assume all the architectures won't
reorder read->write with data dependency, so that the code above having
a smp_rmb() also works?

Regards,
Boqun

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWp6QvAAoJEEl56MO1B/q4pKoIAJPOsJ2T06GUg0wVhH82BU2R
ZlkpggDwyKR/oUt7FdAj9Kzxq1ZMBfqOdIzwH81kpg0h4Z5fBOvAx3FXdBUb0rqS
jkpd0eqRH0Ur1dPo3Mp9TvD3yPS51obs5HnpOE/E9WAMQcx7nDgjuqNHxSIJj1yG
9qc/WDqt7WgQZaNoD9/3Y+JAtM0YfukMVfxTI7OoJdnZCKDa0jO3YExgC2SJVAEF
0iB28yCN9OM2VSBNGdAnaQErCEL/GEi1Dzh6eI2UYPYfxBOL1EMMi9z97/00f7aS
ZRJFahwgFqy/hJNbT7v3VWcBoYdj5vJxwjHZmR6seJsmo24GfJV9huS9tS8606w=
=xJxv
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
