Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2018 00:43:53 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:34942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994684AbeCEXnmhICt6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2018 00:43:42 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9276206B2;
        Mon,  5 Mar 2018 23:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9276206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 5 Mar 2018 23:43:30 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     justinpopo6@gmail.com, linux-mips@linux-mips.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] MIPS: BMIPS: Do not mask IPIs during suspend
Message-ID: <20180305234329.GK4197@saruman>
References: <20170928001515.22917-1-justinpopo6@gmail.com>
 <9b61aae3-53a3-8e96-e00e-76117b19f079@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y+Z5jE7Arku/2GrR"
Content-Disposition: inline
In-Reply-To: <9b61aae3-53a3-8e96-e00e-76117b19f079@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--Y+Z5jE7Arku/2GrR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2017 at 11:22:38AM -0700, Florian Fainelli wrote:
> On 09/27/2017 05:15 PM, justinpopo6@gmail.com wrote:
> > From: Justin Chen <justinpopo6@gmail.com>
> >=20
> > Commit a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq on CPU IRQs") fixes
> > an issue where disable_irq did not actually disable the irq. The
> > bug caused our IPIs to not be disabled, which actually is the correct
> > behavior.
> >=20
> > With the addition of Commit a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq
> > on CPU IRQs"), the IPIs were getting disabled going into suspend,
> > thus schedule_ipi() was not being called. This caused deadlocks where
> > schedulable task were not being scheduled and other cpus were waiting
> > for them to do something.
> >=20
> > Add the IRQF_NO_SUSPEND flag so an irq_disable will not be called
> > on the IPIs during suspend.
> >=20
> > Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> > Fixes: a3e6c1eff548 ("MIPS: IRQ: Fix disabled_irq on CPU IRQs")
>=20
> This looks good to me, not sure if this is the recommended way to solve
> this bug, but this definitively works.

Yeh it looks appropriate to me.

Documentation/power/suspend-and-interrupts.txt says:
> The IRQF_NO_SUSPEND flag is used to indicate that to the IRQ subsystem wh=
en
> requesting a special-purpose interrupt.  It causes suspend_device_irqs() =
to
> leave the corresponding IRQ enabled so as to allow the interrupt to work =
as
> expected during the suspend-resume cycle, but does not guarantee that the
> interrupt will wake the system from a suspended state -- for such cases i=
t is
> necessary to use enable_irq_wake().

I presume there's no need for enable_irq_wake() be used on resume, since
c0_status will get preserved by drivers/soc/bcm/brcmstb/pm/s3-mips.S.

I've fixed checkpatch niggles, added a stable tag and applied for 4.16.

Thanks
James

--Y+Z5jE7Arku/2GrR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqd1iEACgkQbAtpk944
dnqI0BAAuHFrte9Me/BfQs5gpx105M/nPAFSuGvfKCc+ptvXGabjYVY5iUT/1kzD
WxVzVQimHC4HbA0MmM41H46vzcUAFFt3XkVIrHYK9rIHKAH58OU8BDs+pcHXtOsS
LGkX3sEAOQ3ghJ8u9QTqktn1xrwHK+h9tLb0CGCvJIkKx20RgXf221qUjSIjvsmU
qFVyo+FSWBPHITTITBKYmLK/1fKaCbdl6OqCGVls3DuNumn8E62DpbrlZPbHK/yE
BAp+tfR7ZmO1PlQShIXEn4IwlHi6v50qEvRMzbS+/GkFwGpQTGpa62vtDDnGs9H5
mzeZOQVTNVX/cst04bJ2HZqSO2jyV9Oe6wfro+ZMw5p+QB7k4remNK7y/AT5sJWF
6joJjP6PQGr8qTG3LixsYHA3/sM7g4HA/BpOEIRdQdT/e79bVmGQtclgknIos1PU
FEBhb4FOoyDWm1TSE+RN+Y0ytKcWEA0zhZwqTcIH/IWNaee1e37+0b1F9ITDmu5+
JnW0Atbx3UyDRZAXbnGFzLqD5lN08Mm/tHeaQLmoQ+7yj+O4XGrkRTHj2zNAUSu5
YBmFTFLz9T/NBfrBFbqxp55ta060S3Rif8Ar9sgIUNCzVfkqklUmmRaoowVVSc9E
xPv+VATZyf+zR07DBJzDGg7dV+dIdJaAmGLdlW2v7RrHjutWjBE=
=pDVq
-----END PGP SIGNATURE-----

--Y+Z5jE7Arku/2GrR--
