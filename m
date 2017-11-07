Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 19:30:21 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:40096 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992309AbdKGSaKgA3lM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 19:30:10 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 07 Nov 2017 18:29:53 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 7 Nov 2017
 10:28:28 -0800
Date:   Tue, 7 Nov 2017 18:29:49 +0000
From:   James Hogan <james.hogan@mips.com>
To:     "Steven J. Hill" <steven.hill@cavium.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH v2 03/12] MIPS: Allow __cpu_number_map to be larger than
 NR_CPUS
Message-ID: <20171107182948.GJ15260@jhogan-linux>
References: <1506620053-2557-1-git-send-email-steven.hill@cavium.com>
 <1506620053-2557-4-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/GPgYEyhnw15BExa"
Content-Disposition: inline
In-Reply-To: <1506620053-2557-4-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510079389-452060-31092-1061663-2
X-BESS-VER: 2017.12.1-r1710261623
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186679
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
X-archive-position: 60751
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

--/GPgYEyhnw15BExa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 28, 2017 at 12:34:04PM -0500, Steven J. Hill wrote:
> @@ -2725,6 +2726,14 @@ config NR_CPUS
>  config MIPS_PERF_SHARED_TC_COUNTERS
>  	bool
> =20
> +config MIPS_NR_CPU_NR_MAP_1024
> +	bool
> +
> +config MIPS_NR_CPU_NR_MAP
> +	int

I think this needs:
	depends on SMP

Otherwise you get errors like this on UP defconfigs:
=2Econfig:144:warning: symbol value '' invalid for MIPS_NR_CPU_NR_MAP

The use in smp.h looks safe since asm/smp.h is only included if
CONFIG_SMP.

I'll squash the fix in.

Cheers
James

> +	default 1024 if MIPS_NR_CPU_NR_MAP_1024
> +	default NR_CPUS if !MIPS_NR_CPU_NR_MAP_1024
> +
>  #
>  # Timer Interrupt Frequency Configuration
>  #

--/GPgYEyhnw15BExa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloB+5wACgkQbAtpk944
dnrwOA//d84zIjkQJDdB/bcosVsZSjYPSDK5oqqlkmux6aAq/G8VcjBR6ripNIrQ
3qwtYjSb3GJ9cKHCiEBBl7Lnw4OyH3n8MnI5HQ2LBw0BljN5DYI8zRDGhx28lvdM
WwqV1p3uKkGuMwEqOsa1GcAOIu91BSctkiR8djWkis/QUgJosL4qdw9a6ffqT4hk
Rzm9gV14HrYjQGcOB0Z80+F0HXDp1/nXVDf4m99WnAgXb4+/Gd6wbbZ4kkeDAuJA
oQn/fWH3V5XqyF7thTdCi0vi4UU0ODcBqjzJ1AQq0jVEt7wPgNkAWj3wZJiASEjq
T8vEa08nmNZ9wuwmPJs92nw9UKCDaLXfLMNAuihw9ZnuzwqgpmWW13GAOrBAuNbm
kV1pIXujlphja6z8XUDR3A8Z9i1MwpGy72NGW4LC+6CEO3XepyQG93i3qPt15nBC
Er3pq53CDA7EtzDk1nTplwsQONUmD3eCR6w3fK0sJA8lkKP6BEheZsosALevvtz5
FuV1uT9hI4YxXzyJ/6XW/dG2vt4zWsI6BZ/rFWt79+87hBv9kG/giBrdI2xUAufY
Kv8LfrDNzCzckMh3RL5vtJv/FF0B4GniLOZWJQJQn7ddCZvsh7T3fJjxswMDMmtH
6AWYao9QwWeRzffWqlFd/GWC6anq06eM17wnG+48jdWSedJelkQ=
=5JcV
-----END PGP SIGNATURE-----

--/GPgYEyhnw15BExa--
