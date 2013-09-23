Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Sep 2013 10:15:06 +0200 (CEST)
Received: from mail-bk0-f45.google.com ([209.85.214.45]:55151 "EHLO
        mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817315Ab3IWIPERksFD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Sep 2013 10:15:04 +0200
Received: by mail-bk0-f45.google.com with SMTP id mx11so1004415bkb.18
        for <multiple recipients>; Mon, 23 Sep 2013 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NsC1Uwg9F0R/3N6i5kUKiMxNx6uq7oVgocK0VWI/bbk=;
        b=Z1H0nV/+EBjBXxvzVYZolsuqWkgLTmXqnEX2zv0hYLcIP84CivG5Km8fOchcvaiVF1
         7JThb+Ya5ktFvPNqYoWnSZ48LbGzW37pV9uLIAsgWLgL0z3TACAkxKVhLUQH7XAxkh4K
         EKSIO6F2EtBFzlXYX7wbNU1xQ/UzlIbGsTKesFmxU7QS8IVdRkoV3NT1STmE1wddEpuW
         QoIEOKe4WYQrdYxINWA9osenc2JTYCmZpq+BdiQ00zJ8YNN+DkF7j9V6D20PdiputbWg
         Q1uj0jSS2LdaasXbw+O8VPBSjkpOICm93R2vs/NSXKC7i1GS8bMrH/Xe4TT9nNUHZBLa
         /XUg==
X-Received: by 10.205.74.69 with SMTP id yv5mr92554bkb.35.1379924098948;
        Mon, 23 Sep 2013 01:14:58 -0700 (PDT)
Received: from localhost (port-13639.pppoe.wtnet.de. [84.46.53.124])
        by mx.google.com with ESMTPSA id jt14sm8178320bkb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 01:14:58 -0700 (PDT)
Date:   Mon, 23 Sep 2013 10:13:38 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robherring2@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Rob Herring <rob.herring@calxeda.com>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 04/10] irqdomain: Return errors from
 irq_create_of_mapping()
Message-ID: <20130923081337.GB11881@ulmo>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-5-git-send-email-treding@nvidia.com>
 <CAL_JsqLQeAQD460f8Lk9eDE2dCzLusC1mXZ-_uaKVFLfhJNryg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLQeAQD460f8Lk9eDE2dCzLusC1mXZ-_uaKVFLfhJNryg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <thierry.reding@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37923
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


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2013 at 04:14:43PM -0500, Rob Herring wrote:
> On Wed, Sep 18, 2013 at 8:24 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > Instead of returning 0 for all errors, allow the precise error code to
> > be propagated. This will be used in subsequent patches to allow further
> > propagation of error codes.
> >
> > The interrupt number corresponding to the new mapping is returned in an
> > output parameter so that the return value is reserved to signal success
> > (=3D=3D 0) or failure (< 0).
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> One comment below, otherwise:
>=20
> Acked-by: Rob Herring <rob.herring@calxeda.com>
>=20
> > diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci=
-common.c
> > index 905a24b..ae71b14 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -230,6 +230,7 @@ static int pci_read_irq_line(struct pci_dev *pci_de=
v)
> >  {
> >         struct of_irq oirq;
> >         unsigned int virq;
> > +       int ret;
> >
> >         pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
> >
> > @@ -266,8 +267,10 @@ static int pci_read_irq_line(struct pci_dev *pci_d=
ev)
> >                          oirq.size, oirq.specifier[0], oirq.specifier[1=
],
> >                          of_node_full_name(oirq.controller));
> >
> > -               virq =3D irq_create_of_mapping(oirq.controller, oirq.sp=
ecifier,
> > -                                            oirq.size);
> > +               ret =3D irq_create_of_mapping(oirq.controller, oirq.spe=
cifier,
> > +                                           oirq.size, &virq);
> > +               if (ret)
> > +                       virq =3D NO_IRQ;
> >         }
> >         if(virq =3D=3D NO_IRQ) {
> >                 pr_debug(" Failed to map !\n");
>=20
> Can you get rid of NO_IRQ usage here instead of adding to it.

I was trying to stay consistent with the remainder of the code. PowerPC
is a pretty heavy user of NO_IRQ. Of all 348 references, more than half
(182) are in arch/powerpc, so I'd rather like to get a go-ahead from
Benjamin on this.

That said, perhaps we should just go all the way and get rid of NO_IRQ
for good. Things could get somewhat messy, though. There are a couple of
these spread through the code:

	#ifndef NO_IRQ
	#define NO_IRQ (-1)
	#endif

And this isn't very encouraging either:

	$ git grep 'irq.*=3D.*-1' | wc -l
	638

Thierry

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSP/gxAAoJEN0jrNd/PrOhiNUP/jOZBHSu3iWeYBqVkPQQP52r
BDEGdRc+LKm5aBO9XwhxGDTRX3igBcFXfYlkvwmllnhJaPU8J6HCxWWffm8qwCZ2
voRIWxXH7q76QKAE/i7RZwJoASgg1KpLUS0Yv/MVchyOhMMbM2y4GG6IxBRMhA+2
j37HKuSPPnTNvWdD0vCHv064VD44fBLeIog+a4Y5Ha3FHTkd09s6No364wr+/Hko
ILMl+Erg38QqDm9Tr5qW37tMqzJ+I0ik6ye+C12iL2Zpiqo9LS8445M2URts18L6
uPw4xkwCLPA0qcMl/aqpwAlpn48TXLZEmbxZRxBgdJnF7uapdLUeLr4XphpWT4f/
JqWXZqVepBFu24h1NpPFJ2Mi6muhGyhXDYJ+y43OWtfi5dK6olgx3/Nk7b6URxo1
cTlfAemyOrho1a32N4L3rjfR79Ub2qnLcrEVRZ9a72t2qFhBjpV5D8WoO4mQaXtd
27VEKFPFWDL7VIuiUH2mp8hwk7AIWx5h9Ahkdrsxg5KREHsX+vAnkNfEu6IID2nK
nyEmBH0Nn4exzchhiNd3ONQhU5MIuqtudsAv14EchBpUP+8nWNkGAokV9JHfziW/
hBO/rq8r6DE6kzrY66mVR3b5734wHY9TidAN9suWcZkHvsFbZJdyr3NWiZxqatoh
Yb0ygk/unpG2YJa3evJI
=BnFo
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
