Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 22:49:50 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:50546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994696AbeBTVtjrwSyS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Feb 2018 22:49:39 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF4D21104;
        Tue, 20 Feb 2018 21:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF4D21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 20 Feb 2018 21:49:26 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2 11/12] MIPS: Loongson-3: Fix CPU UART irq delivery
 problem
Message-ID: <20180220214925.GF6245@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023381-17624-1-git-send-email-chenhc@lemote.com>
 <1517023381-17624-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vA66WO2vHvL/CRSR"
Content-Disposition: inline
In-Reply-To: <1517023381-17624-2-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62658
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


--vA66WO2vHvL/CRSR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2018 at 11:23:00AM +0800, Huacai Chen wrote:
> Masking/unmasking the CPU UART irq in CP0_Status (and redirecting it to
> other CPUs) may cause interrupts be lost, especially in multi-package
> machines (Package-0's UART irq cannot be delivered to others). So make
> mask_loongson_irq() and unmask_loongson_irq() be no-ops.
>=20
> Cc: stable@vger.kernel.org

=2E..

> -static inline void mask_loongson_irq(struct irq_data *d)
> -{
> -	clear_c0_status(0x100 << (d->irq - MIPS_CPU_IRQ_BASE));
> -	irq_disable_hazard();
> -
> -	/* Workaround: UART IRQ may deliver to any core */

Wouldn't removing this self-described "workaround" bring back the
original problem?

At the very least you need a much better explanation of why these
workarounds are no longer applicable and can be safely removed.

Cheers
James

--vA66WO2vHvL/CRSR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqMl+UACgkQbAtpk944
dnqUFBAAvg7WSKz2ApPsBOLQnIwbygmQ7fyZJ2lw62i8gIa6QgY6ODhicsWkSWa0
jD5rO4T4W19CGhDMsA1mDsHusOE81F5T4uajYzfu7oK2dh2GTpD0ASUYs20ktkST
6K5mvpM+DNJk5OIK+k+X/sayIW5fcYF1mpxvkoNZr132E+WUgWlEzvu/D4U92SPv
5pJEsqR2ruxQwvTJAFjXpVZdq4F/Gt1PwBFtiwyriyvJ6dtOXnN8cc1Rsg1GPgOf
jlMQlx72yCs1e/U1eRIRuOqrc7TnX1WHv+zfIC4z9I6Yx1oBx0/etNA8N4re52EY
KVeO+Ra8okUCbjZRHluOXDRHqsUgI2XbymJl0OArxm5M9FYp6CmD9Ky2o2msYywU
ENWgimiGp72peNSdodbHsrFthraxxfSMwdxiufJ8fhPGQuwfJ3JzKFdBjZuPaNoO
KuMBtwfEbW3I+RUN/5pSegIsp9Gi+1xifj27zHJ6iQG19g/30oJNMXRb2G86+eXj
nyB5u5B0RwsEc9FtuHoyCijbzT36HkwRLqKzSIG7f37jSqkeO5A1wICH7Ojc2Qp0
APsDvprDAH2FwzrWOrRlKGJDY5/jeCot4Gqs2p+gYHJ6Y1dUDC28zC/qhv+aG3uS
ybdRbMmRv5Y1S7fPf4ZcBs/0Q5GBrCvsvOQFt5sU1gQiSH3muTk=
=oZtf
-----END PGP SIGNATURE-----

--vA66WO2vHvL/CRSR--
