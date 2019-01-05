Return-Path: <SRS0=5/jd=PN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7079C43387
	for <linux-mips@archiver.kernel.org>; Sat,  5 Jan 2019 16:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C0E2085A
	for <linux-mips@archiver.kernel.org>; Sat,  5 Jan 2019 16:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfAEQjL (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 5 Jan 2019 11:39:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:37669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfAEQjL (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sat, 5 Jan 2019 11:39:11 -0500
Received: from [192.168.178.38] ([31.18.251.131]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQiVh-1gs9BZ0Uaz-00U0uC; Sat, 05
 Jan 2019 17:39:08 +0100
To:     linux-mips@vger.kernel.org, Christoph Hellwig <hch@lst.de>
From:   Oleksij Rempel <linux@rempel-privat.de>
Subject: MIPS: ath79: regressions after dma-mapping changes
Openpgp: preference=signencrypt
Autocrypt: addr=linux@rempel-privat.de; prefer-encrypt=mutual; keydata=
 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
 8VXa+gkZKRSnZTvVMAriaQwqKog=
Cc:     John Crispin <john@phrozen.org>, antonynpavlov@gmail.com
Message-ID: <6fcd16d9-84fc-891e-a295-9146c8071900@rempel-privat.de>
Date:   Sat, 5 Jan 2019 17:39:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LtmO77VbFCRI5P0EhbxwVubQXOaPjW5W0"
X-Provags-ID: V03:K1:dzgrxHa2Toxj+j/VEF8cigJeQvYnf0b0ZHYvcwB5zojD/nRw+w0
 X01AEVhgtYMRHlEcUL5Yg279aqDq5l4jNe5WWWxbJmqoatEQEslnDRWh4u/jC9bFaZRLhJC
 nhNa+E8Wf6wTo7WHAdGEVBpZoc9SscNOqmBrt8eOtW4VBZo9Ma6uTK6qzHjXfTUDervPPt6
 FuUFrg63/0bwJo+NPjUnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2ekyRp7qK6o=:tGz/uBSeIkZRiz2RMSRpdf
 lRzTP/ervDKUOeDfD2o7QUHMWc7Se0ZruwCbjMxEd0eBkoPOYIf+3sL9NLRBIWorvoPQ8nKss
 JjlSNs56vI1DfZ1Cy3GIwYHAQ40Nj5lrmzu3eqjPg0WLvPubgR6jd6j2nhswb+EB6EnlG+RI/
 i8PgM1svgTNw/b0I3k8K3cSWyOgBeLSuUQcpyP3fVRkJ2vsv1nVvGSZqsLE2HHskQDwhKpZXa
 G/h5v/9TRa0jl1c4Z+3AhzjxkdEBAWbygo9sQoZy41rpH5y2tyOX8P9RcbOjmgiluUOeQ+1SG
 eF6abHVmkUylSEVyZnomowUDzPp2+cnRChefxhwCaZso2TA4D82NjBCQCy4eLifmsj4OZVVIJ
 aZb/FKfzCjsvfadTxYf5ra0SwfaJnvyoxHmYhqcqbguMRxQx7NHXKXA27mc1IXjIzMaqdxEZN
 BVYqsqbqLqKf3fVF45nnRdLs9ej+1JOfKPJHfjlG0ABB/LX+c7pODlC5V+Pdz4vQtDhp5nVcq
 Q+RiNj8QP4khxKsjzly7KOTZwRQN3Pb68OLwmKxhF+AFV6KGf1adr3hqKI3yXuifPePsSH9oz
 xOwON8SniIIejgz49+f2BzR3rtHhC5eyOX4DhVPVNJaGDbfY6NlX+XrGqOhNnc4Fs9b5QfOZa
 MUZSuA+qfCf0L5IAL1RPEMGcmEkMh8xRHho7QyRMosz/ySEsYZGelfA2R64oYFqZN9f05J0zB
 wBZshjoEojTNl5jw/2xHbDjKaBHbuwVP5hXhKSNJiLt90H9qvIZIXCYA/dpv1vY3oshy0A/6x
 /dg7feaRHkUmqlGg1qVNCu0xQ/T7uvyXHU2qdH5KfFZyFu1Wj0B6oxjuWFLIkuNQkzg+ZsZvZ
 0Livs1Pq0S4QpeixViMPzW+ePb+Ozo67Ru0/jKkRIS5hmCgYVAQVW7GeSyeFqPBTc4m7UguGv
 5CZGTiIL2DtdfYC9CGdEo7ZH7tDeVEj6Q797zAN7Z1Wue9JB7Wvi30arpW/wIQ8grONHnolQY
 PQ==
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LtmO77VbFCRI5P0EhbxwVubQXOaPjW5W0
Content-Type: multipart/mixed; boundary="pwTpIAX53Tw1xBtI4Jlhy3JzE5sZNyTT9";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: linux-mips@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc: John Crispin <john@phrozen.org>, antonynpavlov@gmail.com
Message-ID: <6fcd16d9-84fc-891e-a295-9146c8071900@rempel-privat.de>
Subject: MIPS: ath79: regressions after dma-mapping changes

--pwTpIAX53Tw1xBtI4Jlhy3JzE5sZNyTT9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm working on Atheros ar9331 related patches for upstream. Suddenly
this architecture is not working with latest mips_4.21 tag. Bisecting is
pointing to dma-mapping-4.20 merge.

The symptoms are following:
- networking is broken, getting tx timouts from atheros network driver.
- depending on configuration boot will stall even before UART is enabled
- after reverting some of dma-mapping patches, network seems to work but
init will trigger segfault. It is running from nfs-root.


First patch where regressions started is this:
commit dc3c05504d38849f77149cb962caeaedd1efa127
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri Aug 24 10:28:18 2018 +0200

    dma-mapping: remove dma_deconfigure

    This goes through a lot of hooks just to call arch_teardown_dma_ops.
    Replace it with a direct call instead.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Robin Murphy <robin.murphy@arm.com>

It is not enough to revert this patch. This rework seems to be huge.

I also tested dma-mapping-4.21 tag, with same result.
In case, some one won't to play with it, the patches can be found here:
https://github.com/olerem/linux-2.6/commits/v4.20/topic/ath79-upstream-20=
19.01.04.1


It will be great if some one can help me to troubleshoot this issue.

--=20
Regards,
Oleksij


--pwTpIAX53Tw1xBtI4Jlhy3JzE5sZNyTT9--

--LtmO77VbFCRI5P0EhbxwVubQXOaPjW5W0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlww3aoACgkQdQOiSHVI
77R1VAgAuAAxzb1JnKy6n8FPyP5Vqhhzd6bQvh856OWwbvf9pfN7guSYXgRf9UFx
Kwv3qsjmSU8GDNjSh+oqQUk/bAtgGuUVlqW+2lA/HI/xXVrwpoCfj3W+LlvaWqOS
rAS8YiwJXxISYgfW4fm/t29YtFTMOlzU8BuKIVB+tfRz+T/5Dd59mSzz3mRcudXd
Yvn/oN3UJVq3UjhB5v98YtVBb0hmZE9dA8YxmlUbmNKStkau4JJFqi73LSQ7J0Bq
FoDYyJoVJPMLb36qu64wO9v/ugEM95sYO8KxHOf+9d9vD2MYQQnejvqzStJbF3+D
NscloTyaAnpFZGriPNpvLTP2jar/gQ==
=NA+U
-----END PGP SIGNATURE-----

--LtmO77VbFCRI5P0EhbxwVubQXOaPjW5W0--
