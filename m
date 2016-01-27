Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 03:05:36 +0100 (CET)
Received: from mail-io0-f178.google.com ([209.85.223.178]:36333 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010860AbcA0CFfGVdrP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Jan 2016 03:05:35 +0100
Received: by mail-io0-f178.google.com with SMTP id g73so4295209ioe.3;
        Tue, 26 Jan 2016 18:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=APsJvzYmKY3x1MxQC/sKKIjTg3jgcL1k8M3sr2RisIo=;
        b=qzzyz6y2dchwu6YaF1q+3snzRvQOVeiQ5SzqC9DgAIwYNBmpX4yRcv++iAcCqKnd/x
         iZfbKVXZeuS7DW/C458yHxui+jJDXMzCLktAHPGhH+/NY2RISGrxH9QYCTx9Ms/aI5t6
         SfS1n1j69MGzKqc8EMkW4PAtP195QCNTgD1nweStMWE+9P734XF2X6ds2uofZY1uYODo
         0LGZuVqTDb1tQgAKZTJXlPd5TeB7WKS7ozRmvnjJJ1GwAEuJ6UN9/1VIHyLNlFSZyfhw
         njzUoTRBDJOOPNuTL/1EVbRcxfoZBo5C6rHHiw50eKIRo8I2z2/GzZCIdnab+UONbZEA
         vPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=APsJvzYmKY3x1MxQC/sKKIjTg3jgcL1k8M3sr2RisIo=;
        b=bROZdV10e718ydvIWu1DdPURgGJXKa8tmB0etvxgX7RjLrIPZO9H09FZP6VFNaTXcF
         HzdBECagkUNtpPXriRJ/PD2VPzYCzqEmfGRkThTx79rBgCsgfyJVwf44+eP8kW4IHEDp
         vCd41m9ls+tFZveobp4YwiwOHFsvyHMLIIPf8bE3dG15iY31+tQWx6259YKRJlOkFfuL
         n+e5MHWFnVektWlppuCQ5r3xAfxsh9CCNCUDU7MGgxEtUCaQ8SmHBE9+qranQEKohICc
         wcJPJd72WhVgxvG3K72UBHmWIf9wPxjQ6qbSF/LtpE4n4zBisz8QaXvOFvWvd3UXHBT7
         4d0w==
X-Gm-Message-State: AG10YOTYtGZ9mAnJGOJQDe9MpF2sZIo9eJrRLtHStxZxEl7IOOj1tjzA9hW1O/hxYKbiwA==
X-Received: by 10.107.8.72 with SMTP id 69mr30840468ioi.122.1453860328891;
        Tue, 26 Jan 2016 18:05:28 -0800 (PST)
Received: from localhost ([45.32.128.109])
        by smtp.gmail.com with ESMTPSA id e3sm2453061igx.0.2016.01.26.18.05.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 18:05:27 -0800 (PST)
Date:   Wed, 27 Jan 2016 10:04:47 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Peter Anvin <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>,
        linux-xtensa@linux-xtensa.org,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        adi-buildroot-devel@lists.sourceforge.net,
        David Daney <ddaney.cavm@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-metag@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Joe Perches <joe@perches.com>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160127020447.GA1293@fixme-laptop.cn.ibm.com>
References: <20160114204827.GE3818@linux.vnet.ibm.com>
 <20160118081929.GA30420@gondor.apana.org.au>
 <20160118154629.GB3818@linux.vnet.ibm.com>
 <20160126165207.GB6029@fixme-laptop.cn.ibm.com>
 <20160126172227.GG6357@twins.programming.kicks-ass.net>
 <CA+55aFzcC6C8imPs5vk4yH1Y2YHjnAdFM9HCkVs04COxuDQH6w@mail.gmail.com>
 <20160126201037.GU4503@linux.vnet.ibm.com>
 <CA+55aFxjb+2rs2wVHtiSCcOzgMrE8H=yDeNcjyujPQudDCtLgw@mail.gmail.com>
 <CA+55aFwxTJd+uibcxtZD3tGnj_n=LMwyAa0s8qyx_OF0OMWQkA@mail.gmail.com>
 <20160126232921.GY4503@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20160126232921.GY4503@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <boqun.feng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51450
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


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 26, 2016 at 03:29:21PM -0800, Paul E. McKenney wrote:
> On Tue, Jan 26, 2016 at 02:33:40PM -0800, Linus Torvalds wrote:
> > On Tue, Jan 26, 2016 at 2:15 PM, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > You might as well just write it as
> > >
> > >     struct foo x =3D READ_ONCE(*ptr);
> > >     x->bar =3D 5;
> > >
> > > because that "smp_read_barrier_depends()" does NOTHING wrt the second=
 write.
> >=20
> > Just to clarify: on alpha it adds a memory barrier, but that memory
> > barrier is useless.
>=20
> No trailing data-dependent read, so agreed, no smp_read_barrier_depends()
> needed.  That said, I believe that we should encourage rcu_dereference*()
> or lockless_dereference() instead of READ_ONCE() for documentation
> reasons, though.
>=20
> > On non-alpha, it is a no-op, and obviously does nothing simply because
> > it generates no code.
> >=20
> > So if anybody believes that the "smp_read_barrier_depends()" does
> > something, they are *wrong*.
>=20
> The other problem with smp_read_barrier_depends() is that it is often
> a pain figuring out which prior load it is supposed to apply to.
> Hence my preference for rcu_dereference*() and lockless_dereference().
>=20

Because semantically speaking, rcu_derefence*() and
lockless_dereference() are CONSUME(i.e. data/address dependent
read->read and read->write pairs are ordered), whereas
smp_read_barrier_depends() only guarantees read->read pairs with data
dependency are ordered, right?

If so, maybe we need to call it out in memory-barriers.txt, for example:

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barri=
ers.txt
index 904ee42..6b262c2 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1703,8 +1703,8 @@ There are some more advanced barrier functions:
=20
=20
  (*) lockless_dereference();
-     This can be thought of as a pointer-fetch wrapper around the
-     smp_read_barrier_depends() data-dependency barrier.
+     This is a load, and any load or store that has a data dependency on t=
he
+     value returned by this load won't be reordered before this load.
=20
      This is also similar to rcu_dereference(), but in cases where
      object lifetime is handled by some mechanism other than RCU, for


Regards,
Boqun

> > And if anybody sends out an email with that smp_read_barrier_depends()
> > in an example, they are actively just confusing other people, which is
> > even worse than just being wrong. Which is why I jumped in.
> >=20
> > So stop perpetuating the myth that smp_read_barrier_depends() does
> > something here. It does not. It's a bug, and it has become this "mind
> > virus" for some people that seem to believe that it does something.
>=20
> It looks like I should add words to memory-barriers.txt de-emphasizing
> smp_read_barrier_depends().  I will take a look at that.
>=20
> > I had to remove this crap once from the kernel already, see commit
> > 105ff3cbf225 ("atomic: remove all traces of READ_ONCE_CTRL() and
> > atomic*_read_ctrl()").
> >=20
> > I don't want to ever see that broken construct again. And I want to
> > make sure that everybody is educated about how broken it was. I'm
> > extremely unhappy that it came up again.
>=20
> Well, if it makes you feel better, that was control dependencies and this
> was data dependencies.  So it was not -exactly- the same.  ;-)
>=20
> (Sorry, couldn't resist...)
>=20
> > If it turns out that some architecture does actually need a barrier
> > between a read and a dependent write, then that will mean that
> >=20
> >  (a) we'll have to make up a _new_ barrier, because
> > "smp_read_barrier_depends()" is not that barrier. We'll presumably
> > then have to make that new barrier part of "rcu_derefence()" and
> > friends.
>=20
> Agreed.  We can worry about whether or not we replace the current
> smp_read_barrier_depends() with that new barrier when and if such
> hardware appears.
>=20
> >  (b) we will have found an architecture with even worse memory
> > ordering semantics than alpha, and we'll have to stop castigating
> > alpha for being the worst memory ordering ever.
>=20
> ;-) ;-) ;-)
>=20
> > but I sincerely hope that we'll never find that kind of broken architec=
ture.
>=20
> Apparently at least some hardware vendors are reading memory-barriers.txt,
> so perhaps the odds of that kind of breakage have reduced.
>=20
> 								Thanx, Paul
>=20

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWqCW7AAoJEEl56MO1B/q4s1oH/iHzdn5KSPbNB42xfz6tFsll
f9Zrh2E67bvEmxIbrj8LQ3Mohfu/kKidJ+kB/JFNSTcpDo0TenA4pkcedwVN5VPX
uGlhN2gPpbU4FLIAtefu4htGyXgeeGN/8v3w78nyKh57N1/ZcgFycu16pDIpri/h
JY4KnRfSbK3iakJGdQRjQdb/iSPsJtoFrFUnc9HddUet28CbUF4MHV8si0sUV/LW
M+hCR5X+h+2fjiAtZQvA9NzuQ4TWz3oorL+nKZ86KrWUZc196fJzIK2Gfix23bOk
ABplTs7dOOjtuDkzlxwVnXgP97++iC0poCYqeTW7dm1mpWG361x8yH2rqlXz2wA=
=21MT
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
