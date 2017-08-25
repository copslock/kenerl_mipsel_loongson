Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Aug 2017 01:07:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:55507 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993179AbdHYXHrczeMx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Aug 2017 01:07:47 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BC32C81BFC55D;
        Sat, 26 Aug 2017 00:07:35 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Sat, 26 Aug 2017 00:07:40 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 26 Aug
 2017 00:07:40 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 25 Aug
 2017 16:07:37 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>, <ralf@linux-mips.org>
CC:     <john@phrozen.org>, <david.daney@cavium.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: Maintenance of Linux/MIPS?
Date:   Fri, 25 Aug 2017 16:07:31 -0700
Message-ID: <1539189.Q9sWsqvfCA@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <c96eaa42-ab7f-d902-746c-c6cff242c596@gmail.com>
References: <c96eaa42-ab7f-d902-746c-c6cff242c596@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1641345.frPGPuF62o";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59805
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

--nextPart1641345.frPGPuF62o
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello,

On Friday, 25 August 2017 14:21:33 PDT Florian Fainelli wrote:
> Hi,
> 
> There are a lot of patches at
> https://patchwork.linux-mips.org/project/linux-mips/list/ that appear to
> be under the "New" state and have not had a chance to be reviewed yet.
> 
> What can we do to help speed up the review process, do we need more
> reviewers? It seems like most patches affecting Linux/MIPS are still
> core MIPS kernel changes, but would it help if say, people were queuing
> SoC/board specific patches in trees and submit pull requests? Would that
> help lower the amount of patches to review?
> 
> Any other suggestion?
> 
> Thanks!

Personally I think it'd probably be good if Ralf were willing to formally 
share maintainership duties with someone else or a group of people. I think 
James for example would be a great choice, and already dons a maintainer hat.

As-is Ralf ends up being a bottleneck a lot of the time, and the backlog in 
patchwork is pretty good evidence of that. There are a whole lot of patches 
that ought to be going into v4.14, and that ought to be sat in linux-next 
right now in preparation for that. Sadly not many of them are, and usually 
that remains the case until very close to the merge window. Sharing the load 
could only help with this.

Thanks,
    Paul
--nextPart1641345.frPGPuF62o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmgrbMACgkQgiDZ+mk8
HGUz7xAApj3d17u5thHq5IUgCsa1au4fAN70befvN3iD4p8aA0WWQewIQa5U9pCt
vlP8GfVEfjpbDI9r31sEMJwb9QYaSUISetw7sUNxoi2awSveRaLm/GYyQswWslOI
IfPo/Da7ohDMrSLX5t7W9OEt/zjTUGRApfsw6NV1A7pogYykxAcTkmei/YN6BvLp
z9u3KPH17cJzwo39P0gC4RX8d9y1skjajSgL/o4AEzOq21XieHTRuKJyeze1x/zK
OcIC3mUZkOLFFziIln7dyh2dOWTHKLEsL9jUpqa7rIEY/mlgXOcJ3OlITbTBxkSK
YLH9/ZQ8BhngdZEd/eolJmUlpImqA7wIt+ISOii+0qdbonzv0aduvZC69Ur54ic3
6UZfhw96I0M0kVIn7XS5L/k0RclxAQs6O4bh1kFesvIpeWwcDoC74X35VoPdX2fS
KgqMEHJA/ZTCbhA3aGCyI845DBFPxlJSq/ZRL1Spdc2j6GNwg9FGVNdvir2gVJ9S
eJ2hgNZahMR1U39uGjovKIGU0lyGcNxawlSC1uS2jfv2Rl4Ny0U3NQekFfkVCwxW
PwqQTume9oVJugL380I4Y/ThawJ+B/AHaWz4JkAf7GFpUJ7TL7FImJqe8hkymGrE
BIGiW/y4IayNn1Bth7Q9KdguFKb81sMqzncmeWhg7xmWhgzXv8Q=
=cnlm
-----END PGP SIGNATURE-----

--nextPart1641345.frPGPuF62o--
