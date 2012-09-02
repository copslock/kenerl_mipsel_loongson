Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Sep 2012 21:17:08 +0200 (CEST)
Received: from moutng.kundenserver.de ([212.227.17.8]:50391 "EHLO
        moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903298Ab2IBTRD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Sep 2012 21:17:03 +0200
Received: from mailbox.adnet.avionic-design.de (mailbox.avionic-design.de [109.75.18.3])
        by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
        id 0MeMRD-1SxayM0xlH-00QDZe; Sun, 02 Sep 2012 21:16:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTP id 9A4C12A282FD;
        Sun,  2 Sep 2012 21:16:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at avionic-design.de
Received: from mailbox.adnet.avionic-design.de ([127.0.0.1])
        by localhost (mailbox.avionic-design.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ytCkLN-pdj8Z; Sun,  2 Sep 2012 21:16:55 +0200 (CEST)
Received: from localhost (avionic-0098.adnet.avionic-design.de [172.20.31.233])
        (Authenticated sender: thierry.reding)
        by mailbox.adnet.avionic-design.de (Postfix) with ESMTPA id A8CF62A281A5;
        Sun,  2 Sep 2012 21:16:55 +0200 (CEST)
Date:   Sun, 2 Sep 2012 21:16:55 +0200
From:   Thierry Reding <thierry.reding@avionic-design.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [PATCH 1/3] MIPS: JZ4740: Break circular header dependency
Message-ID: <20120902191654.GA10843@avionic-0098.mockup.avionic-design.de>
References: <1346579550-5990-1-git-send-email-thierry.reding@avionic-design.de>
 <1346579550-5990-2-git-send-email-thierry.reding@avionic-design.de>
 <504371CE.2040707@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <504371CE.2040707@metafoo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:M79KQ3CeD1etoFC2kJLOrKUcF/Rzo7i6QvpLH/qh8dB
 qmaJhYUSDjyJr8r9rA01/Vcj2kB3pM33dFF4QjQJH2qYisrrFY
 KAZ51mRjP0JBhy0I5OilQsVU0dRbSTHQp85tu31qFXjBxnxYck
 xlte7LSR9bA93WaLs43Z72+YTXoJWEAC25FHscZs7uCbz9OGTh
 LGsw/sRGO64eXYbfF/+izvZ589Pw4JU7GcSmCgAHomhDHpyOyS
 GwN5JtC0Fpj36Za3h01sEWlJp0AgSC8NmJfrl0Wi6/cMu8nAnS
 WpCbgSueNJUJ/Z6wXBP8dkeE5408g7cJtWnUqDYGshMLhAA5q5
 8SiG16mSlwE/jvdca6SVPn+Vlw2PKDdsFTKKSLBhfBBsRZ35Fm
 l0ZKzDW+VcAwKM//aiOOFKQZ0LpP8UbXXkiRNsguhcGCJvSR/k
 cSWWz
X-archive-position: 34403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@avionic-design.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 02, 2012 at 04:48:46PM +0200, Lars-Peter Clausen wrote:
> On 09/02/2012 11:52 AM, Thierry Reding wrote:
> > When including irq.h, arch/mips/jz4740/irq.h will be selected as the
> > first candidate. This header does not include the proper definitions
> > (most notably NR_IRQS) required by subsequent headers. To solve this
> > arch/mips/jz4740/irq.h can be deleted and its contents can be moved
> > into arch/mips/include/asm/mach-jz4740/irq.h, which will then be
> > correctly included.
> >=20
>=20
> Where exactly did you have this problem? arch/mips/jz4740/ should not be =
in the
> include path, so "#include <irq.h>" should not cause arch/mips/jz4740/irq=
=2Eh to
> be included.

While compile-testing I did make ARCH=3Dmips menuconfig and selected
JZ4740 plus the new PWM driver option, then ran make ARCH=3Dmips. That
showed errors like struct irq_data not being declared or NR_IRQS not
being defined. Maybe I was just using a very strange configuration.

I tested this with 3.6-rc3 and linux-next, both had this problem.
Neither of them had a default configuration for JZ4740, so maybe I'm
just missing a configuration option.

Thierry

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQQ7CmAAoJEN0jrNd/PrOh47kP/04b7XC/q2SxL4vlrrgWejnx
kVv1iMLZaEKM3N3LTGiOJ/ZUR5i9lWdaXG6ra7PQmalZVQXrcZYEuD1Jn1MIwj96
pCUWrbqj7S55sfQe5H3Mq2qweAt885wMFouHVbjRdt51IVl8upOlPIx/B+vJLjGi
G47f5/NumPaNX84iTn/7IjWwBwmRaqkJRMOrsLFET7SITK4RaFvc0iF2gIQZRfO8
7QIq6ncv0vwxMFSUPpZYRnmM4h3MUI1Mupmw4s9MyISAL73AVWIwKyT6RUyirSSP
pvW6l0/UZadtQFADzjToT8SjI2Co9GPQq0Vp60FjegC+9iwgzcmt8cAADLJ5aicv
YB3/FO1c5cheISzn5N4iUwvmS8WC8S+MSU4stoyBEmFmY/eVWAeQZ2M76vQTzkpM
K5ZFPHiQ7vvtnabb/1qL8DOedjsCH3MJXgRhMb5RMFPx5/jFBFI7FX3nFzbzU6s6
YtM76cvkK9VyXUBTmRi7M/NQkWdFov3ttYyINfFy1lFte3Dc9RLITfo8pe/Fz8MY
dWtQO7PJwj4Di1QOAg54MdmZ8OF74x+WWvK0PFE5S6kPiU6W7cxYifwSW5wxh4Tp
GUgBFfla72+EipQPqlpkwD7YGpNmtvCYYGuiaTbCjFPOPPhaUL0FNNwcLn/eGuIQ
Tf3MbWs3CGZXysXsxxEA
=rDF/
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
