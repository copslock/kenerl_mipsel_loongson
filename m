Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jun 2017 00:01:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29039 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993853AbdFWWBK55o5- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jun 2017 00:01:10 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id E195341F8D8B;
        Sat, 24 Jun 2017 00:10:55 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Sat, 24 Jun 2017 00:10:55 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Sat, 24 Jun 2017 00:10:55 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 20EA2BB5D493A;
        Fri, 23 Jun 2017 23:01:00 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 23 Jun
 2017 23:01:05 +0100
Date:   Fri, 23 Jun 2017 23:01:04 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
CC:     <rth@twiddle.net>, <ink@jurassic.park.msu.ru>,
        <mattst88@gmail.com>, <vgupta@synopsys.com>,
        <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <geert@linux-m68k.org>,
        <ralf@linux-mips.org>, <ysato@users.sourceforge.jp>,
        <dalias@libc.org>, <davem@davemloft.net>, <cmetcalf@mellanox.com>,
        <gxt@mprc.pku.edu.cn>, <bhelgaas@google.com>,
        <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>,
        <linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-m68k@lists.linux-m68k.org>, <linux-mips@linux-mips.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <hch@infradead.org>
Subject: Re: [PATCH] pci:  Add and use PCI_GENERIC_SETUP Kconfig entry
Message-ID: <20170623220104.GE31455@jhogan-linux.le.imgtec.org>
References: <20170623214538.25967-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline
In-Reply-To: <20170623214538.25967-1-palmer@dabbelt.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Jun 23, 2017 at 02:45:38PM -0700, Palmer Dabbelt wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 4c1a35f15838..86872246951c 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -96,6 +96,7 @@ config ARM
>  	select PERF_USE_VMALLOC
>  	select RTC_LIB
>  	select SYS_SUPPORTS_APM_EMULATION
> +	select PCI_GENERIC_SETUP
>  	# Above selects are sorted alphabetically; please add new ones
>  	# according to that.  Thanks.

This comment seems to suggest PCI_GENERIC_SETUP should be added a few
lines up to preserve the alphabetical sorting.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b2024db225a9..6c684d8c8816 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -115,6 +115,7 @@ config ARM64
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	select PCI_GENERIC_SETUP

Here too.

> diff --git a/arch/tile/Kconfig b/arch/tile/Kconfig
> index 4583c0320059..6679af85a882 100644
> --- a/arch/tile/Kconfig
> +++ b/arch/tile/Kconfig
> @@ -33,6 +33,7 @@ config TILE
>  	select USER_STACKTRACE_SUPPORT
>  	select USE_PMC if PERF_EVENTS
>  	select VIRT_TO_BUS
> +	select PCI_GENERIC_SETUP

and here

Otherwise
Reviewed-by: James Hogan <james.hogan@imgtec.com>

Cheers
James

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllNj58ACgkQbAtpk944
dnqhdg//SJAI7UamQnmPRbqhd0gYMgcMzrRPh0vqsiV9afGNrHMYVzth2hX+OeJ9
edYIVIlz0ky02rwtw0eW17nxowjc6kDgFJjMDCwXZkhtOUKaCZ8iZ2hzs9tDm0a9
iY1/8aSk71HagWfO0GX0zAPERIGzXsdTb+UL/+KCO9vAd5xYKeAcof7U55cs8M/O
YA8AeyTGBVZTzsgFZAb/1Pd63z7oMq99RNyBHMP4fGB0qIiXbL8vpWEN2cXOmZP+
ERBA+AqvywLTp8PM1CZGQNgJzPmYHrRycWg0JWpsTc+ZejIniBTsVR+AWMn7Oef+
yz5qJso9DGjVKcK/5U0xZ4Lmm51mvrvsGj9lM8PPZTnMJnHPPDrL+R5NyL3/jhpO
bd+E3hNT2sZxwiWxGaeuY2w/Hejx/basnBXvVH82TceRIKnbOPpuS+kym2UEoCQ8
uRGqvNs04Mq5eqOlZIMaFsPuLS+QLEL6iWA1yid1hozNkqX4+T36nx/7qHmk0cgB
mrqu+BraxA8nQJaTTMCxgiYOKT4cCNV64EqUVn4OhEenCkSxdIK+0wY+mC9L158r
NA8CAsgLdX/MCkNJrpAcbhJWrnELFK4eRXr3qSj3hKVt1pSuwdgt9ZU9ZV4gNY8j
UKx0brQlyfUFAZQLqGqceX7fipZ/xFyJ7cF5ztcLNDMvffqQBm0=
=0daY
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
