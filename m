Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 01:44:41 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35750 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010124AbcAGAoiqQ3HY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 01:44:38 +0100
Received: by mail-pa0-f41.google.com with SMTP id do7so6648746pab.2
        for <linux-mips@linux-mips.org>; Wed, 06 Jan 2016 16:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=B/ZhFqhHNKVtirp5Kj6uK/ArLNafshitXEVaoAjsU6w=;
        b=Hk+zlDxMltsEaTpqKmrjN/ZXmLVYNa07gkjB3PhIzJu3P0PG9W/N8tY5L/WldqZeNQ
         Hmz92RgYAvDNc32qCLRF+kJUigVhP3GLGbarudeP65KdObgCvXGOvlfNSj7LnEaSxRWa
         ZALP/Z/zpLW2oDAfVsQ1N+jxtprKVOzaXiXTVP19HoLA9cEAaD25Q+Z0WyJ3jauh+Q7M
         0Dr7X89oRTOlqqCh8DcDYpT6biOPP9AQthXmNFqXRIhmDnxZPN1wqvttidvseD76CO1s
         Mg+kJ1eaASeRf4yxI+AjJoR5rEmhnR/l9KbUdAP5nmMUqPS1s2HL2fCLDBz0n6MJYIY5
         VMeA==
X-Received: by 10.66.235.36 with SMTP id uj4mr66377559pac.85.1452127472464;
        Wed, 06 Jan 2016 16:44:32 -0800 (PST)
Received: from localhost ([45.32.128.109])
        by smtp.gmail.com with ESMTPSA id e14sm144581121pap.24.2016.01.06.16.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2016 16:44:30 -0800 (PST)
Date:   Thu, 7 Jan 2016 08:43:56 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 15/32] powerpc: define __smp_xxx
Message-ID: <20160107004356.GB14605@fixme-laptop.cn.ibm.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-16-git-send-email-mst@redhat.com>
 <20160105013648.GA1256@fixme-laptop.cn.ibm.com>
 <20160105085117.GA11858@redhat.com>
 <20160105095341.GA5321@fixme-laptop.cn.ibm.com>
 <20160105180938-mutt-send-email-mst@redhat.com>
 <20160106015152.GA14605@fixme-laptop.cn.ibm.com>
 <20160106222337-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20160106222337-mutt-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <boqun.feng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50950
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


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 06, 2016 at 10:23:51PM +0200, Michael S. Tsirkin wrote:
[...]
> > >=20
> > > Sorry, I don't understand - why do you have to do anything?
> > > I changed all users of smp_lwsync so they
> > > use __smp_lwsync on SMP and barrier() on !SMP.
> > >=20
> > > This is exactly the current behaviour, I also tested that
> > > generated code does not change at all.
> > >=20
> > > Is there a patch in your tree that conflicts with this?
> > >=20
> >=20
> > Because in a patchset which implements atomic relaxed/acquire/release
> > variants on PPC I use smp_lwsync(), this makes it have another user,
> > please see this mail:
> >=20
> > http://article.gmane.org/gmane.linux.ports.ppc.embedded/89877
> >=20
> > in definition of PPC's __atomic_op_release().
> >=20
> >=20
> > But I think removing smp_lwsync() is a good idea and actually I think we
> > can go further to remove __smp_lwsync() and let __smp_load_acquire and
> > __smp_store_release call __lwsync() directly, but that is another thing.
> >=20
> > Anyway, I will modify my patch.
> >=20
> > Regards,
> > Boqun
>=20
>=20
> Thanks!
> Could you send an ack then please?
>=20

Sure, if you need one from me, feel free to add my ack for this patch:

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWjbTIAAoJEEl56MO1B/q4Xf8H/A0lM6gsUPNqUU24iHbc5O4j
qN+FbAuVULCXdZfNW9uS+HG4Oq9VqZZc4rv5QdX6IHzcYKTYAv7+8rEMHmrxV8A/
mMKfwU07krXlG0IRFhiMpuCzvjAfa0CgPOUHBzGJU5mdrAiM8ymtpa1ofde/uitO
UaRheer5STPZ2kUzrA0r2hYbtWczy6X7yIxioQbXKeR88AuE8X12Me7X+zl9YoPP
NnwnzDhEkvj7wzQVgWTyA4fwu051dOtRENtv0k6UugV2bW45SsuLQ9Co3BUh/iK+
KF/57kaJ9BfOGYF1HAHH10GSkwTyyAsc8SGAQKg6PY/lJsHBDFluEtr98U1ssCA=
=FLp9
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
