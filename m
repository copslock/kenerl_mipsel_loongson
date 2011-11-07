Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2011 03:49:27 +0100 (CET)
Received: from calzone.tip.net.au ([203.10.76.15]:53866 "EHLO
        calzone.tip.net.au" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1904218Ab1KGCtU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2011 03:49:20 +0100
Received: from canb.auug.org.au (ibmaus65.lnk.telstra.net [165.228.126.9])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by calzone.tip.net.au (Postfix) with ESMTPSA id 427A4128440;
        Mon,  7 Nov 2011 13:49:16 +1100 (EST)
Date:   Mon, 7 Nov 2011 13:49:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yong Zhang <yong.zhang0@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, linux-mips@linux-mips.org
Subject: Re: [PATCH 12/49] MIPS: irq: Remove IRQF_DISABLED
Message-Id: <20111107134912.0878664493f1110ceefb98a6@canb.auug.org.au>
In-Reply-To: <20111107021048.GA3027@zhy>
References: <1319277421-9203-1-git-send-email-yong.zhang0@gmail.com>
        <1319277421-9203-13-git-send-email-yong.zhang0@gmail.com>
        <20111104122106.GA7581@linux-mips.org>
        <20111107021048.GA3027@zhy>
X-Mailer: Sylpheed 3.2.0beta3 (GTK+ 2.24.7; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__7_Nov_2011_13_49_12_+1100_jrHQyWU8AZ.BtL_r"
X-archive-position: 31414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4923

--Signature=_Mon__7_Nov_2011_13_49_12_+1100_jrHQyWU8AZ.BtL_r
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yong,

On Mon, 7 Nov 2011 10:10:48 +0800 Yong Zhang <yong.zhang0@gmail.com> wrote:
>
> On Fri, Nov 04, 2011 at 12:21:06PM +0000, Ralf Baechle wrote:
> > Thanks, queued for 3.3.  I resolved a conflict in dbdma.c and remove
> > one IRQF_DISABLED which had been missed in arch/mips/kernel/perf_event.=
c.
>=20
> And FYI, my patch is based on next-20111014 when I made it.

You should never base anything on top of a linux-next tree.  You should
use the tree you are fixing (Linus' or the Mips tree or ...) as the base.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__7_Nov_2011_13_49_12_+1100_jrHQyWU8AZ.BtL_r
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJOt0coAAoJEECxmPOUX5FEHDIP/00zpvtv1S/Up9demv3hM++9
Lne7Imn48Hgy6qceQWEZk43RCo1Umn3VCgJrMHN24yZ793UaJoiapPcr/RPNa1Kq
2uQdZJlKHCCSDysCGiRh1VaHPI3q98n2zVqvxKQeSzX0BA0pHQ8TGgR0IJdIe+Br
bopPE7e999LJno13I9EXx97JAdSNcj021CxmpBgNqUSLPjiV1PMBgwGqaNhMjwQs
RMjR/BzKgtEYpRyPSMXCzwPirDb/mT736HW13QOT8FS2+EYYZ9B/rwkOOIab4pPS
uF1MRpNM3ERtM58+0id8q4MmQgEoA6EwD4i8fIYUFEVYWb7YXg7lPTX92sMQaAi6
p6zlKSknX6+5DXIdt9ynZ0Xg/DcXbf3diQK4QAYQYshft13JHozx1SDvcx2tvnIl
MiAC9xQHFBHaQMFMwKeQRKVbLWMTZiIw8nQr5klOL9HxeaqqUAORjbQnAQwLoOTB
blHCUTvXinoomIF0CNdie76rWz7otk4o3bqhhaIDw3fSn8DW8Oi4fdW4Z/7flKe8
1lUgCIeODmS8/OM2B0+Go6WzU9UBgfuWh5Wd88iUjCD+pduF0GAuQMWRYJ/TFTIg
PdUp6KrvA2jZA4q0jEcTVbxQryNWf6RI16IaAeRInm+ihbN0ZSoB/4Wk8GIXFCka
HbWGaoSLujjjOOH3RTiX
=xVUF
-----END PGP SIGNATURE-----

--Signature=_Mon__7_Nov_2011_13_49_12_+1100_jrHQyWU8AZ.BtL_r--
