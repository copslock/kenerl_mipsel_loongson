Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2013 10:23:06 +0200 (CEST)
Received: from mail-bk0-f44.google.com ([209.85.214.44]:41998 "EHLO
        mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817546Ab3JPIXDAxpt2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Oct 2013 10:23:03 +0200
Received: by mail-bk0-f44.google.com with SMTP id mz10so143691bkb.31
        for <multiple recipients>; Wed, 16 Oct 2013 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=BBDlTI12TjwkTy7ABpN+sCoSbDnLDPuSb21g6uPD/VM=;
        b=lRQuqzZa93D6gdfnHySyYt1Q3+hgEV3QHjg2zx0ku6TuPvKCzzQSBirdqWL1NqJB3O
         csK9T0Em+2e5LEB9zLvWboR5q7ZcUDoMqx45K8ZqjF9QXuURZ/TvAEU/reDzxWWroI0j
         B97JC4IOFaMIauNxPLRn4T+KdyQny6ohKOGgoxabG2Tzb4u1lqy5lXhfXs/mfrvgLIin
         tHQLFbPXmryGNkx9XliujaQyS+MbWa8lLQ+q7y19aVOCGj+167iO4cLZahEWZLrSiYSK
         lUGecd1A2oQ/pnbohA5Kp7/wnTstFf+I4nSbzFSBY6LZvLbRruhWI6C1czLFyfHpmQnp
         E40A==
X-Received: by 10.204.168.197 with SMTP id v5mr1217126bky.24.1381911777588;
        Wed, 16 Oct 2013 01:22:57 -0700 (PDT)
Received: from localhost (port-49179.pppoe.wtnet.de. [46.59.192.180])
        by mx.google.com with ESMTPSA id kk2sm46174003bkb.10.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 01:22:56 -0700 (PDT)
Date:   Wed, 16 Oct 2013 10:20:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Grant Likely <grant.likely@linaro.org>
Cc:     Rob Herring <rob.herring@calxeda.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] of/platform: Resolve interrupt references at
 probe time
Message-ID: <20131016082039.GA21963@ulmo.nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-9-git-send-email-treding@nvidia.com>
 <20131015232436.19F61C40099@trevor.secretlab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20131015232436.19F61C40099@trevor.secretlab.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thierry.reding@gmail.com
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


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2013 at 12:24:36AM +0100, Grant Likely wrote:
> On Wed, 18 Sep 2013 15:24:50 +0200, Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > Interrupt references are currently resolved very early (when a device is
> > created). This has the disadvantage that it will fail in cases where the
> > interrupt parent hasn't been probed and no IRQ domain for it has been
> > registered yet. To work around that various drivers use explicit
> > initcall ordering to force interrupt parents to be probed before devices
> > that need them are created. That's error prone and doesn't always work.
> > If a platform device uses an interrupt line connected to a different
> > platform device (such as a GPIO controller), both will be created in the
> > same batch, and the GPIO controller won't have been probed by its driver
> > when the depending platform device is created. Interrupt resolution will
> > fail in that case.
>=20
> What is the reason for all the rework on the irq parsing return values?
> A return value of '0' is always an error on irq parsing, regardless of
> architecture even if NO_IRQ is defined as -1. I may have missed it, but
> I don't see any checking for specific error values in the return paths
> of the functions.
>=20
> If the specific return value isn't required (and I don't think it is),
> then you can simplify the whole series by getting rid of the rework
> patches.

The whole reason for this patch set is to propagate the precise error
code so that when one of the top-level OF IRQ functions is called (such
as irq_of_parse_and_map()) the caller can actually make an reasonable
choice on how to handle the error.

More precisely, the goal of this series was to propagate failure to
create a mapping, due to an IRQ domain not having been registered yet
for the device node passed into irq_create_of_mapping(), back to the
caller, irq_of_parse_and_map(), which can then propagate it further.
Ultimately this will allow driver probing to fail with EPROBE_DEFER
when IRQ mapping fails and allow deferred probing to be triggered.

This cannot be done if all you have as error status is 0. Mapping of
IRQs can fail for a number of reasons, such as when an IRQ descriptor
cannot be allocated or when an IRQ domain's .xlate() fails. You don't
want to be deferring probe on all errors because some of them are
genuinely fatal and cannot be recovered from by deferring probe.

With the current implementation in the kernel, interrupt references are
resolved very early, usually when a device is instantiated from the
device tree. So unless all interrupt parents of all devices have been
probed by that time (which usually can only be done using explicit
initcall ordering, and even in that case doesn't always work) then many
devices will end up with an invalid interrupt number.

The typical case where this can happen is if you have a GPIO expander on
an I2C bus that provides interrupt services to other devices. With the
current implementation, the GPIO expander will be probed fairly late, at
which point many of its users will already have been instantiated and
assigned an invalid interrupt. Many drivers try to work around that by
explicitly calling irq_of_parse_and_map() within their .probe() function
because that's usually called sometime after the device's instantiation.
However even that isn't guaranteed to work. If the GPIO expander depends
itself on other resources that cause it to require deferred probing, or
if its driver is built as a module and therefore making the registration
of the corresponding IRQ domain is completely non-deterministic, then
this can fail just as easily.

With this patch series all of these issues should go away. All of the
dependencies should be resolvable by using deferred probing. Furthermore
the mechanism introduced to have the core resolve the IRQ references can
be used to request other standard resources as well. A particular one
that I'm aware of is how IOMMUs are associated with devices. Currently a
variety of quirks have been proposed to work around these issues, such
as reordering nodes in the device tree, which only work because the DTC
implementation that everybody uses happens to keep them ordered in the
same way in the DTB as they were in the DTS.

Thierry

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXkxXAAoJEN0jrNd/PrOhIJUQALy0Oj2HWU7c49EWZz/xzUZ7
cDSvnJR+5DV5QEnRw5OX7RJ1HM3lLD10CClzJlArMzkbg9U5odwQhnCwLOf0Eb1v
RPu476yK4EyUPMZWrJIF05dDTqjV/mbLmhLvrB2X2E01kE8pBDkS+p17YBlHhqZY
mmK02iZtNYU/0BtsIe2tPxXcSqRstgr9tJ6KSbETrXtvOr9KLWDwmRtS28JHsLiC
9GwLqdsxaGWX084yqLn71u1skpb+vvgQreUIcmfOjBwDYn6wSomedEN6eonHJSDw
/jypgg6PL/mzjXrt3nQEWw6/zMvB2IDbU1REtrPsz7eHth+JfWSm5NFLiycT9sLU
+Vco64HZ/sv3mlsM1LLFOgEWBgzTiVQrP2h0AJGGG2PDbG66t9bmfiHMvN7n6TT9
B6f6a2B4xzTVn3EVdpQODDsNycsdQKht/dDaqkiIY+YsKp9mP0ngG15XLEmaB4gx
PKM4Gm3Mqg1A9cWGtjXKMQx/8m65E7Enf7SHhV9zSfttNEGYX+0+HXCYKJ62s2SI
31C1Tf05sOJzJvYysmwctV7/UKe/WtcMqJA2rVynLaCyEF+lJKkKINaCTBwdSYMO
OBFab+ATYt8J8hEX1EH8QiErq7f8wYTp4/r0qPu5RSEsfEVU14rl5gYPreidAwue
/wZb2phDusCARWQ3t3gq
=lnB4
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
