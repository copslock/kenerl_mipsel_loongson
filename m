Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Aug 2017 19:24:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35239 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993376AbdHGRYVqQocX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Aug 2017 19:24:21 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 981B0648BE86B;
        Mon,  7 Aug 2017 18:24:11 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Aug
 2017 18:24:15 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Mon, 7 Aug 2017
 10:24:11 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Nathan Sullivan <nathan.sullivan@ni.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] MIPS: NI 169445 board support
Date:   Mon, 7 Aug 2017 10:24:05 -0700
Message-ID: <11583742.zienCqJRO5@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <20170807152648.GA13214@linux-mips.org>
References: <1500402549-12090-1-git-send-email-nathan.sullivan@ni.com> <20170807152648.GA13214@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10043099.6gJe9OrT0o";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59395
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

--nextPart10043099.6gJe9OrT0o
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Ralf,

On Monday, 7 August 2017 08:26:48 PDT Ralf Baechle wrote:
> On Tue, Jul 18, 2017 at 01:29:09PM -0500, Nathan Sullivan wrote:
> > diff --git a/arch/mips/generic/vmlinux.its.S
> > b/arch/mips/generic/vmlinux.its.S index f67fbf1..de851f7 100644
> > --- a/arch/mips/generic/vmlinux.its.S
> > +++ b/arch/mips/generic/vmlinux.its.S
> > @@ -29,3 +29,28 @@
> > 
> >  		};
> >  	
> >  	};
> >  
> >  };
> > 
> > +
> > +#ifdef CONFIG_FIT_IMAGE_FDT_NI169445
> > +/ {
> > +	images {
> 
> [...]
> 
> > +	};
> > +};
> > +#endif
> 
> There's been a reject on this file because of a Boston #ifdefed section.
> I've fixed that up but we need a cleaner solution.  Paul, any suggestions?
> 
>   Ralf

One possibility would be for us to split the board portions of vmlinux.its.S 
out into a file per-board, perhaps board-boston.its.S, board-ni169445.its.S 
etc. The build process would then have to concatenate the right files to 
generate the full image tree source.

Does that sound good to you?

Thanks,
    Paul
--nextPart10043099.6gJe9OrT0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmIojUACgkQgiDZ+mk8
HGVg3w/9Gucp7naDPxM6pNazBbP7jbzfMYX4UV5M6FiXifgLZxD4+C8jDBAnoMwM
zdv+UeaOsYmIfdrJyKIDQuALXXV/T8+BJ4nIXOkQUUVdhKaTzNWKd7XHFRwkn1sO
6RxvayxXtOVGgEv+HrsIFEEybA1DgY+SHp1sqMiA+VI2ms+p3tCaE5qtjPF7rVDL
XW7FX1HtQK3RqHg2Pt0jN8BH2bcy6hwvPBt1i7ke1EfoDXLAOZML4oVc8pjyWmV0
O1ppDavAXICy9BIsDAeLZxvyBOom9klXv3s+riHrGbOmiON9uqLFVezUiS4/zpgJ
UQjlyY1IEUBxVqlruOl9iJzTw33PWBod2MPlDtfc9CbhKRvzlX+19C2ePHp+GVxl
WQYuZ1kf9jhsLedF3XKEGbHYFR3CmEvIUfMo1oEZQtWmFQVUuqM9RdmCZm4r4QUw
+7vR7za4B2V1cOdbVxz8idBwFMJWLV+hP4GPvZFtfKzX6n/N8L4wKroomCO4kPw9
quVpYC2XmeKiQFryJCbq2Wgcsdv3XUiKsEUDBtcp6rewub4dLzL1spJZmcqU48lS
KlXnFY1ZQrQWDGurayimJ8kcS68FDur7eruw6KiI+d+wMdO7a3WwcCk1LVktjoEB
EACE87X74TnlfFqPDVwQZiwkHu5jzMf+yWiw2V0CIrpKn8OAQ68=
=gnJ0
-----END PGP SIGNATURE-----

--nextPart10043099.6gJe9OrT0o--
