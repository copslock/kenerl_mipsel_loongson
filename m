Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 23:32:37 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:53051 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990401AbeCIWca3PQ0s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Mar 2018 23:32:30 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 09 Mar 2018 22:31:55 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 9 Mar 2018
 14:31:53 -0800
Date:   Fri, 9 Mar 2018 22:31:48 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>
Subject: Re: your mail
Message-ID: <20180309223147.GB18133@jhogan-linux.mipstec.com>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
 <20180309151219.18723-9-ezequiel@vanguardiasur.com.ar>
 <df6880caf0291e32250deafeb4c71476@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <df6880caf0291e32250deafeb4c71476@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1520634713-321459-21834-11893-4
X-BESS-VER: 2018.2-r1803082101
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190883
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 06:51:36PM +0100, Paul Cercueil wrote:
> Le 2018-03-09 16:12, Ezequiel Garcia a =C3=A9crit=C2=A0:
> > @@ -164,8 +171,46 @@ struct jz4740_mmc_host {
> >   * trigger is when data words in MSC_TXFIFO is < 8.
> >   */
> >  #define JZ4740_MMC_FIFO_HALF_SIZE 8
> > +
> > +	void (*write_irq_mask)(struct jz4740_mmc_host *host, uint32_t val);
> > +	void (*write_irq_reg)(struct jz4740_mmc_host *host, uint32_t val);
> > +	uint32_t (*read_irq_reg)(struct jz4740_mmc_host *host);
> >  };
>=20
> I'm not 100% fan about the callback idea, the original commit
> (https://github.com/gcwnow/linux/commit/62472091) doesn't use them and=20
> is
> 30 lines shorter.
>=20
> I'm not terribly against either, so if nobody else bug on that, feel=20
> free
> to ignore my comment.

I was thinking the same as Paul too to be honest. Unless there is a
measurable benefit to having callbacks, I think its cleaner and more
readable to stick to conditionals and normal abstractions where
appropriate.

Cheers
James

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqjC00ACgkQbAtpk944
dnp5rw/+JdDz1OYUmiVyUElKgx994CGzHqb/PbX9+oitMmQR3RbUYNNaOEdZ2icn
lWLSobRUXvvleRjVHKJKNWZobiS7jyavTydtafaVhEOf5V40aph5iciHK1qX5k5c
ByTjmXDnFgCato6bQT/HrMIxCsZLlsTXqD9yANUnSGDb1Q1SifByXP3tzOfBNHHT
0hoCiYJAxU4NhnJvJ8eSfdFLyMcezPLb60RnMxD84JywVm3vHciANCFYiJRAjqfH
c8WnaIGb/0cL87a1zB9Pj7Mfif0A05c895+3FQRAZZjl4HzfOC35pzJVRBTade08
uHDBHz7MKhjAjX7+CRKC8y0xI+usurJ8VKeHZ40Dpn/ET3VBdBqlp5JkaK5Am2p6
3tOaUevG+b0zEJLZqxecF/s1oU6XgHo/cyA6KFDUkEUKLBSC7r/npybQvZVmjtAT
WORFJNynswSVqONd89gW7+3Pc8tFVGsSbWpNkrUq57WajahK5JEwE63FbvZR1F1q
soJlmPlK+UDYXDiiMy1tfOvx+SRbR0XnHfm4HYDeo0VLO1MB8W+JnjcUGVzG07T3
a0wwNcHmdnZrgBHr0a3Zmadt8lU6OAgkGtdsvyrq4+OZ/t9447tX3bIXvcH5w1yf
38Xd7nOVop0C8QQs/bpYyjN8Oll9RbgHyq4kkK3y4f7FaEbT3b4=
=Jx9X
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
