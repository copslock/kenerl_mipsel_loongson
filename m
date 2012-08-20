Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2012 09:28:34 +0200 (CEST)
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:34452 "EHLO
        na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901163Ab2HTH20 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2012 09:28:26 +0200
Received: from mail-lb0-f170.google.com ([209.85.217.170]) (using TLSv1) by na3sys009aob114.postini.com ([74.125.148.12]) with SMTP
        ID DSNKUDHnF70Gj6CrBJlWWv+H2r98hKsbRfa6@postini.com; Mon, 20 Aug 2012 00:28:25 PDT
Received: by lbbgp3 with SMTP id gp3so3240737lbb.29
        for <linux-mips@linux-mips.org>; Mon, 20 Aug 2012 00:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=pHBLFVKPUCDHvRfIi8BunA2Y6y28s2TdLQbpL7//L30=;
        b=ARZU+00zDr+NN7TAHAxbTiuKFu7g4Ty6UrKfUfT8LsIYJtXtiw+Qf8p5S8GRo7NqBG
         vDbynzhpOSWhNvAF2mlfzGohuPyoMMVmy3Bg9eu57FYKoL8WEBvIOvYyQmN+k6/HVCeg
         BhCvEAtkc3QbddJMUxX4SkIw0RcyFNTR9vM7WHI/eWIuFpsfBtsZtRQmlPngUogmJ0qy
         zqq1mIbZQ/vykwf7TvAy0bFWaPwwWI1W9X+qY5e/pS3vRgy+2cLy+JRw0PbbToHF1P8G
         yI3NVhy+3XrIUd1eYNSsHmLIXdm932LVzCPFtblIAf9FQkWbJ8JC1zG6G9rM+opai0F0
         1BUw==
Received: by 10.152.109.212 with SMTP id hu20mr13129513lab.3.1345447701815;
        Mon, 20 Aug 2012 00:28:21 -0700 (PDT)
Received: from localhost (cs78217178.pp.htv.fi. [62.78.217.178])
        by mx.google.com with ESMTPS id gv8sm14996194lab.14.2012.08.20.00.28.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 00:28:21 -0700 (PDT)
Date:   Mon, 20 Aug 2012 10:24:27 +0300
From:   Felipe Balbi <balbi@ti.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, balbi@ti.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
Message-ID: <20120820072425.GG17455@arwen.pp.htv.fi>
Reply-To: balbi@ti.com
References: <97cb21b8063a02a9664baf8b749ae200@localhost>
 <20120819201714.GA3152@breakpoint.cc>
 <CAJiQ=7CADk_75U5=OQH8vXA=xtj-U=TbBhXzC8JfUGbYEKmxng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline
In-Reply-To: <CAJiQ=7CADk_75U5=OQH8vXA=xtj-U=TbBhXzC8JfUGbYEKmxng@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQklAuUYfVVWPNvrou4Aj5jg+/0MNRKDEex4ECcx3m3jveIRCpeYJ7ZE/uZgBkkqrslqWifb
X-archive-position: 34285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: balbi@ti.com
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


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 19, 2012 at 01:53:26PM -0700, Kevin Cernekee wrote:
> On Sun, Aug 19, 2012 at 1:17 PM, Sebastian Andrzej Siewior
> <sebastian@breakpoint.cc> wrote:
> > On Sat, Aug 18, 2012 at 10:18:01AM -0700, Kevin Cernekee wrote:
> >
> > This is a quick look :)
>=20
> Thanks for the review.
>=20
> >> +     for (i =3D 0; i < NUM_IUDMA; i++)
> >> +             if (udc->iudma[i].irq =3D=3D irq)
> >> +                     iudma =3D &udc->iudma[i];
> >> +     BUG_ON(!iudma);
> >
> > This is rough. Please don't do this. Bail out in probe or print an erro=
r here
> > and return with IRQ_NONE and time will close this irq.
>=20
> OK, I will change it to warn + return IRQ_NONE, instead of BUG().
>=20
> That situation shouldn't ever happen anyway.  It would mean that our
> ISR is getting called with somebody else's IRQ number, or the iudma
> structs were corrupted.
>=20
> Probe does bail out if any of the IRQ resources are missing.
>=20
> >> +     for (i =3D 0; i < NUM_IUDMA + 1; i++) {
> >> +             int irq =3D platform_get_irq(pdev, i);
> >> +             if (irq < 0) {
> >> +                     dev_err(dev, "missing IRQ resource #%d\n", i);
> >> +                     goto out_uninit;
> >> +             }
> >> +             if (devm_request_irq(dev, irq,
> >> +                 i ? &bcm63xx_udc_data_isr : &bcm63xx_udc_ctrl_isr,
> >> +                 0, dev_name(dev), udc) < 0) {
> >> +                     dev_err(dev, "error requesting IRQ #%d\n", irq);
> >> +                     goto out_uninit;
> >> +             }
> >> +             if (i > 0)
> >> +                     udc->iudma[i - 1].irq =3D irq;
> >> +     }
> >
> > According to this code, i in iudma[] can be in 1..5. You could have mor=
e than
> > one IRQ. The comment above this for loop is point less. So I think if y=
ou can
> > only have _one_ idma irq than you could remove the for loop in
> > bcm63xx_udc_data_isr().
>=20
> There are 6 IUDMA channels, and each one always has a dedicated
> interrupt line.  IRQ resource #0 is the control (vbus/speed/cfg/etc.)
> IRQ, and IRQ resources #1-6 are the IUDMA (IN/OUT data) IRQs.  Maybe
> it would be good to add a longer comment to clarify this?

If you actually have separate IRQ lines, you should request_irq() for
each line, which will again render the for loop pointless.

> An earlier iteration of the code had passed in an IRQ range, which
> worked for 6328, but then it was pointed out that the IRQ numbers are
> not contiguous on all platforms.  So 7 individual resources are indeed
> necessary.

correct. But nevertheless, you should have a separate request_irq() for
each line, continuous or not continuous.

--=20
balbi

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQMeYpAAoJEIaOsuA1yqRE8ggP/1eXQsFNsl+0zdyafVk90xZL
BE/xP2roiYGOt3D0oB/5iiD27EG/Q4nEl8kQtxuZ6a/Dj26BdyuMjGMGNsK5Lvpk
J+vz/ci+Mz2hd/f5Doi1ElKxSi5Tc8xxtpfuxWrLbzsye4aFaSCS0qEE3XK2R+MT
eZYjcRhefbt2kAM+oyPQDh92A/N4DLNUSWVzPR03JRix82DlY3lv2ZFAWrOoyllq
e3JxphmBa9TXekAMsry9EyxXKPet9bvaa5nDsfJotPqd4awBgzEntttaDY54VT9M
oVdDy56knpaBKNPkfcuu/f5F7BNWulwBybGJZS1HChh1WmEWJpqLYjOTvK7JAUeh
H+tEu4ABXzjaCyEqGtjajx/RtqP97JHKBErhswihBOPbT65NM5MZ8E9K8PwliFeW
ZNtJqmGbfVRIprFndMZjrIOZbMJWyYdOotU/Bg0fpPpxnzEiQe7wSt05kbj640b+
rcvh8WHj/bxZrYo2k6ypYED/7/Co9EqcIndpZ9xBnnJLawZa9ObdUOQDTy6vbPmM
fCvpLmWQRlGqbZPPI/VGPT5jrroWxkjPH+Y6Af/XvZ+udIAKRsr7vClBYhBhK+SO
J6rCVWGAOLRbqXFFxbEVK0Wsya2ZS6dm2iqyFvSk1MhOrcMkIa/LrMAZXf0+qd1v
czPo0rh7FMPvGD5EkltU
=R3g7
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
