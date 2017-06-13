Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jun 2017 18:48:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2731 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993911AbdFMQsmzPXt5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jun 2017 18:48:42 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 7EDD741F8E51;
        Tue, 13 Jun 2017 18:57:59 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 13 Jun 2017 18:57:59 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 13 Jun 2017 18:57:59 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 7AC651D6D16C7;
        Tue, 13 Jun 2017 17:48:33 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 13 Jun
 2017 17:48:37 +0100
Received: from np-p-burton.localnet (10.20.1.33) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Tue, 13 Jun
 2017 09:48:35 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Rahul Bedarkar <rahulbedarkar89@gmail.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Rahul Bedarkar" <rahul.bedarkar@imgtec.com>
Subject: Re: [PATCH v4 3/4] MIPS: DTS: img: Don't attempt to build-in all .dtb files
Date:   Tue, 13 Jun 2017 09:48:34 -0700
Message-ID: <1699079.Kf0ib7BVPQ@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <CA+NV+V=gUdcu_tRKnyLrSauuge88Bou1CB4Q+n75A48d+MqJyg@mail.gmail.com>
References: <20170602182003.16269-1-paul.burton@imgtec.com> <20170602182003.16269-4-paul.burton@imgtec.com> <CA+NV+V=gUdcu_tRKnyLrSauuge88Bou1CB4Q+n75A48d+MqJyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2070560.9WQ2B9pHYu";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.33]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart2070560.9WQ2B9pHYu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Rahul,

On Tuesday, 13 June 2017 09:13:12 PDT Rahul Bedarkar wrote:
> Hi Paul,
> 
> On Fri, Jun 2, 2017 at 11:50 PM, Paul Burton <paul.burton@imgtec.com> wrote:
> > When building a FIT image we may want the kernel to build multiple .dtb
> > files, but we don't want to build them all into the kernel binary as
> > object files since they'll instead be included in the FIT image.
> > 
> > Commit daa10170da27 ("MIPS: DTS: img: add device tree for Marduk board")
> > however created arch/mips/boot/dts/img/Makefile with a line that builds
> > any enabled .dtb files into the kernel. Remove this & build the
> > pistachio object specifically, in preparation for adding .dtb targets
> > which we don't want to build into the kernel.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > 
> > ---
> > 
> > Changes in v4:
> > - New patch.
> > 
> > Changes in v3: None
> > Changes in v2: None
> > 
> >  arch/mips/boot/dts/img/Makefile | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> It looks good to me.
> 
> Reviewed-by: Rahul Bedarkar <rahulbedarkar89@gmail.com>

Thanks for reviewing :)

> > diff --git a/arch/mips/boot/dts/img/Makefile
> > b/arch/mips/boot/dts/img/Makefile index 69a65f0f82d2..c178cf56f5b8 100644
> > --- a/arch/mips/boot/dts/img/Makefile
> > +++ b/arch/mips/boot/dts/img/Makefile
> > @@ -1,6 +1,5 @@
> > 
> >  dtb-$(CONFIG_MACH_PISTACHIO)   += pistachio_marduk.dtb
> > 
> > -
> > -obj-y                          += $(patsubst %.dtb, %.dtb.o, $(dtb-y))
> 
> It was probably copy/paste from other board Makefiles. But If I
> understand it correctly, please correct me if I am wrong, linking of
> object file of device tree to kernel image is useful if boot loader
> doesn't support loading external device tree and in that case kernel
> can use inbuilt device tree.
> 
> Thanks,
> Rahul

Yes, it can be useful & there's nothing wrong with building in the .dtb for a 
platform like pistachio. For the generic kernel however we put the various 
device tree binaries into the FIT image so that the bootloader can pick out 
the right one, so building them into the kernel is unnecessary.

Thanks,
    Paul
--nextPart2070560.9WQ2B9pHYu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAllAF2IACgkQgiDZ+mk8
HGX7jQ//dffaC/wdXkWuTlIUNA1Y/Zs7Xnfu/ThpkN7b7DSaJCNopMRHLx2bLSUu
pjZbYL/3opfDBVSTZuHH8jpJkoPXIGmU2QPUydwFq8DIp14IjhC5rL9bmVHIkGjR
BpOcvQdIG7Zu2DKHhp5GcLc2+J61CqgOZ3xa9l0AeS26Xtx0+AtSeyrWvM2u5WHl
j8Gy3/X6TdS0db0fJuqaeVr+5FJM7czJGMbKAH2Gnlz0He31RFDHJ75swXRkUIaY
/j+5z2Jjmbm+Rzs3dyH6hyW1eXIcdwFxP6ZyYib006traJQxgzrIIAKp2/vAwnY3
5GqUj9RFFonuCKOfYjzE6fNTwUB4ANARDXzBzrndiW67ilSEuZcaNVqA9eh/6tqq
9QWZFNX6qXUC2KCR0PxQSsDBirDKYkhCQOQAoW0llX0oaEtPK0aA0+pjtF1vKGCu
IbxgOH5Mj+68xwXMPaMDpRYG25Sz9CX0NfLjzB9pTbOHIbGXrC5WSv4n8iLS8p8t
IrWqizYStb1VD6B4Dcq2V6afuX6eULq1k9ZPZ7zCEZrWQUPkthodq2+eGBTEfM9l
BXSbhv5UGIGabP3eJ/rQW95v3uKxKfwOHWPhHonDd6i/e3OyovKFVO16NdXHm1j0
7BoT7/WS0Bsj5X3OLhKqrAuNfqdfDq6LcSeMacZIJgjclnlx6uc=
=7w/F
-----END PGP SIGNATURE-----

--nextPart2070560.9WQ2B9pHYu--
