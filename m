Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Sep 2015 15:53:18 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:1182 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007049AbbIINxQlXDvS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Sep 2015 15:53:16 +0200
Received: from avionic-0020 (unknown [91.60.5.193])
        (Authenticated sender: albeu@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id B7EC04C80E7;
        Wed,  9 Sep 2015 15:53:05 +0200 (CEST)
Date:   Wed, 9 Sep 2015 15:52:55 +0200
From:   Alban <albeu@free.fr>
To:     Alexander Couzens <lynxis@fe80.eu>
Cc:     Alban <albeu@free.fr>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: ath79: set missing irq ack handler for
 ar7100-misc-intc irq chip
Message-ID: <20150909155255.63e7c27e@avionic-0020>
In-Reply-To: <20150909110406.2e4a4f97@lazus.yip>
References: <1441251262-13335-1-git-send-email-lynxis@fe80.eu>
        <1441251262-13335-2-git-send-email-lynxis@fe80.eu>
        <20150903103245.21dc9dd7@avionic-0020>
        <20150909110406.2e4a4f97@lazus.yip>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/91gl=x/xb.6iA01Y+x1yPog"; protocol="application/pgp-signature"
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49147
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

--Sig_/91gl=x/xb.6iA01Y+x1yPog
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Sep 2015 11:04:06 +0200
Alexander Couzens <lynxis@fe80.eu> wrote:

> On Thu, 3 Sep 2015 10:32:45 +0200
> Alban <albeu@free.fr> wrote:
>=20
> > > -IRQCHIP_DECLARE(ath79_misc_intc, "qca,ar7100-misc-intc",
> > > -		ath79_misc_intc_of_init);
> > > +
> > > +static int __init ar7100_misc_intc_of_init(
> > > +	struct device_node *node, struct device_node *parent)
> > > +{
> > > +	pr_info("IRQ: Setup ar7100 misc IRQ controller from
> > > devicetree.\n");
> >=20
> > Debug left over?
>=20
> I'll remove it in next patch. I added it because you mentioned a log
> message in your last review.

I meant the commit log, sorry for the misunderstanding.

Alban

--Sig_/91gl=x/xb.6iA01Y+x1yPog
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV8Dm4AAoJEHSUmkuduC28BwcQAKxzBEPVPq+ObAA0qA6VmxK8
FkpQ1s5lJ6B72tviuTkkdUNhBCc286FUn9xNqmjqa8htcTfKTAgbfGxsAFqxg6p/
l9NEWrevzHwyIDd4EMLivcpOSq1Nda64eEaRUVKGjpyh9ovDlkxMhy+UPCxvs6/a
YDwFcArhy+7p+YdS9biyd1Tr7WKY6qMrZUBI4PXDSIXLe8VdBUMplw3O6FgviCFw
bVHfyKG+GNzBF/1srxoOEKItn9SRxEqDktpwdm7o2E3Fup/pHW51bHv4w44X1Xwg
k7VfOZlQsbMq4JmMcMzKdFXKnOXPrcwWvHJDY9E9K763fdcPCJX3WxkFQlxuedgd
ug75N/XUdHS5PS5HvXGUsb0rJbrLi8ER58pEaf1NRFCeP6wMR3086pMFRSJF8C+X
nsNOvfSZFNBmyGg6mxUbyk4QzfS3WbyrzHH789LZODjyDwmke4V6cIPn6zwiizdS
rzM71kJqH+LmClxEhZgtu3Yw9EKCe7JyGYRUUJsX0cAzr3GQ/jIL3zOwnER73Ok9
Q3GIZLnFb3y0fEANssMF1VEfgM8njKAzWn6UiSzEguBJ3MEdmuTaq+oK0NnvtL6n
2F1DoXdEmQEI02RUK5u6QVJ9ujVl7JC0wnylzsh0i/NC3PjhtGomlri1vJOIJr7y
CIpf6vN8IZiNOU1rFPci
=Kb8o
-----END PGP SIGNATURE-----

--Sig_/91gl=x/xb.6iA01Y+x1yPog--
