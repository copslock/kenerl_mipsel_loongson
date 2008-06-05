Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 22:06:22 +0100 (BST)
Received: from server.drzeus.cx ([85.8.24.28]:39827 "EHLO smtp.drzeus.cx")
	by ftp.linux-mips.org with ESMTP id S28575311AbYFEVGU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Jun 2008 22:06:20 +0100
Received: from mjolnir.drzeus.cx (wlan252.drzeus.cx [::ffff:10.8.2.252])
  (AUTH: LOGIN drzeus, TLS: TLS 1.0,256bits,RSA_AES_256_CBC_SHA1)
  by smtp.drzeus.cx with esmtp; Thu, 05 Jun 2008 23:01:10 +0200
  id 0000000000120046.0000000048485416.000066AC
Date:	Thu, 5 Jun 2008 23:05:52 +0200
From:	Pierre Ossman <drzeus@drzeus.cx>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	sshtylyov@ru.mvista.com
Subject: Re: [PATCH 8/9] au1xmmc: abort requests early if no card is present
Message-ID: <20080605230552.68c14b2d@mjolnir.drzeus.cx>
In-Reply-To: <20080519080804.GI21985@roarinelk.homelinux.net>
References: <20080519080339.GA21985@roarinelk.homelinux.net>
	<20080519080804.GI21985@roarinelk.homelinux.net>
X-Mailer: Claws Mail 3.4.0 (GTK+ 2.13.1; i386-redhat-linux-gnu)
Face:	iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAMAAABg3Am1AAAAAXNSR0IArs4c6QAAADNQTFRFEgwFRSofeTwxZEI1h1lFl1ZHeGBetHZk24VzuZJ43p2GsbKw/Lmg2MTL/NO3/+/Q//fpWFujUwAAAk5JREFUSMeNlVcWnDAMRd0bLux/tVGxiAEzic7hZ+Zd1IU6NtbYdn8daic/cgj52CPqLQ8hOBdjzsD8G2hHsCiPBS2/nTyABi93zvsYUyql1v6KSz30AeUAJLAK1uuDUI94WA7GDsAePtRDfwFRgP7DA8vvwOgQ1R5oYQUKAwOsfwDHDcAcWH+e5xagiooey1SwSAy0L8C7BaDKdgKWoNQtIjYEfHQGzMcKwNgCpLdgBn14ZzXNSPkJWK201vjiHMkXZg7AuQWCA7G2DPTiMSIsLSZxbgEIwlqEjE+9WBu0yaWOHwDLLQE9WmMieCBgtG1IAFgBzo7tlojGtbI3wFljuU4JdL3ghPeO+tFr2QHG0DOBSuN0kofaU302zmKbcTrgAWDUywG0OvXELi6gZScAdq6WnhYgvYDGu0YQjYSZs3ROID0B4y+jjpWyAhjePWkAjKwD5o09xioNBoro/+YQZjzTg8ce1CJtwFvwAMDFBEjv6cgI0P/u0DqtGJOjNSAm4e0jABxsgDYXSADQw2wwsFyzdePCAviE48QexseKNiGcp4jgKNEVAGC7QEwY5+S6Qpf50NzujHrdYgEKH0o8ZJ/AQR8HAGiaugDjG2i4ddZx4wToPwB0gQsEfjyFRKf1M+kLQC8u5iuoX8BhxYCQJPZXQ7LQdDnQR87/BdCpQQSJpREh7EMSQOvpYwJaqbAHgrUXkWehxhmUUjpsQ+IDSHlzEvidywrtDYSpnHVioNbstBLi9o3Dn/WqZ3Nw1pUQy8bN3/QdiPiVUZfpP4cDVEKd2cXEAAAAAElFTkSuQmCC
X-Face:	@{|$W51qEixc&6}dq_38NM^&.vv|'{O)ae?DMZ1%VYxuhN2}5VpQ!'gx[{V+8Xw'+cV5*491_)-SU2YT8s@4`H;@:ELS'/P(@.JxxJi/C8mG0H#A^R<JfS_l?/%fD\D/mFJ8c2M?_kIL;:txa"s`0O*d+}p/4;$lAw@/e&h-nvQ)~q-a("De+&~-{5`:T{9d%0
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=PGP-SHA1; boundary="=_freyr.drzeus.cx-26284-1212699671-0001-2"
Return-Path: <drzeus@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus@drzeus.cx
Precedence: bulk
X-list: linux-mips

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-26284-1212699671-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 19 May 2008 10:08:04 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> From ec41439903048bf98e301dbd03426c63156ebc0e Mon Sep 17 00:00:00 2001
> From: Manuel Lauss <mlau@msc-ge.com>
> Date: Sun, 18 May 2008 15:52:43 +0200
> Subject: [PATCH] au1xmmc: abort requests early if no card is present
>=20
> Don't process a request if no card is present.
>=20
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  drivers/mmc/host/au1xmmc.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index be09a14..0b30582 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -689,6 +689,13 @@ static void au1xmmc_request(struct mmc_host *mmc, st=
ruct mmc_request *mrq)
>  	host->mrq =3D mrq;
>  	host->status =3D HOST_S_CMD;
> =20
> +	/* fail request immediately if no card is present */
> +	if (0 =3D=3D au1xmmc_card_inserted(host)) {
> +		mrq->cmd->error =3D -ETIMEDOUT;
> +		au1xmmc_finish_request(host);
> +		return;
> +	}
> +
>  	if (mrq->data) {
>  		FLUSH_FIFO(host);
>  		ret =3D au1xmmc_prepare_data(host, mrq->data);

You should use -ENOMEDIUM for this case.

Rgds
Pierre

--=_freyr.drzeus.cx-26284-1212699671-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkhIVTUACgkQ7b8eESbyJLiLtgCg+C7ANMrwgGFwwOyoAHHPyKul
GkwAn111N+IAIR83Oecf9H+AMPJ50Drc
=dL38
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-26284-1212699671-0001-2--
