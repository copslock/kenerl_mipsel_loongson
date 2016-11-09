Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 15:08:18 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11554 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992836AbcKIOILia6q0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 15:08:11 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 8A98041F8DFE;
        Wed,  9 Nov 2016 14:06:56 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 09 Nov 2016 14:06:56 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 09 Nov 2016 14:06:56 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9687367E7D881;
        Wed,  9 Nov 2016 14:08:01 +0000 (GMT)
Received: from np-p-burton.localnet (192.168.154.126) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 9 Nov 2016 14:08:04 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Jan Glauber <jan.glauber@caviumnetworks.com>
CC:     <linux-i2c@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Peter Swain <pswain@cavium.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: octeon: Fix waiting for operation completion
Date:   Wed, 9 Nov 2016 14:07:58 +0000
Message-ID: <1595446.2T31j1Ekg5@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.2 (Linux/4.8.6-1-ARCH; KDE/5.27.0; x86_64; ; )
In-Reply-To: <20161109134103.GC2960@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com> <20161107200921.30284-2-paul.burton@imgtec.com> <20161109134103.GC2960@hardcore>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2048444.3xMuk2hNqk";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [192.168.154.126]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55741
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

--nextPart2048444.3xMuk2hNqk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 9 November 2016 14:41:03 GMT Jan Glauber wrote:
> Hi Paul,
> 
> I think we should revert commit "70121f7 i2c: octeon: thunderx: Limit
> register access retries". With debugging enabled I'm getting:
> 
> <snip>
> 
> This is not caused by the usleep inside the wait_event but by
> readq_poll_timeout(). Could you try if it works for you if you only revert
> this patch?
> 
> Thanks,
> Jan

Hi Jan,

If I drop both my patches & just revert 70121f7f3725 ("i2c: octeon: thunderx: 
Limit register access retries") sadly it doesn't fix my system. A boot of a 
cavium_octeon_defconfig kernel with initcall_debug ends with:

  calling  octeon_mgmt_mod_init+0x0/0x28 @ 1
  initcall octeon_mgmt_mod_init+0x0/0x28 returned 0 after 67 usecs
  calling  ds1307_driver_init+0x0/0x10 @ 1
  initcall ds1307_driver_init+0x0/0x10 returned 0 after 19 usecs
  calling  octeon_i2c_driver_init+0x0/0x10 @ 1
  ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
  ata1.00: ATA-9: SanDisk SDSSDA240G, Z22000RL, max UDMA/133
  ata1.00: 468862128 sectors, multi 1: LBA48 NCQ (depth 31/32)
  ata1.00: configured for UDMA/133
  scsi 0:0:0:0: Direct-Access     ATA      SanDisk SDSSDA24 00RL PQ: 0 ANSI: 5
  sd 0:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/224 GiB)
  sd 0:0:0:0: [sda] Write Protect is off
  sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
  sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support 
DPO or FUA
   sda: sda1 sda2 sda3 sda4
  sd 0:0:0:0: [sda] Attached SCSI disk
  ata2: SATA link down (SStatus 0 SControl 300)
  random: crng init done

As you can see octeon_i2c_driver_init never returns. Are you able to test on 
one of your MIPS-based systems?

Thanks,
    Paul
--nextPart2048444.3xMuk2hNqk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYIy2+AAoJEIIg2fppPBxlt1MP/R3u79gTe3JA+K1Esg+MVr0B
RjXdcqbp2ZBGMS/MMnatWhNDIZwQL/7h656TowEnxeowqvO8XxUj8e6X1IeEgvSR
4waRbpfEIYxGzJ0cH/oYtW8I6tG85R0FvzKG7OMVL8rbcJTsASjslq/FZJPHEWVN
E3d0B4JuuZtUQB542dENfrhNXgotEF6M4aCZlosCU08WCntD28h6CJ1fLdI9SCIB
O5GL6I9q0FYI/7npMt7FT8rmMNFs+cxCuhLBj11JlyAUH1jySZ5eykbF8nRij2Zy
vHGAO6BEnssPUKo28QfQDYHZAd3cuZcw6C/nVeln5ZMvuU3q28ARyHjfeXGSpj1K
wf7y7P9Mj639ULp4/JgfWN3NgqqqTvgIOqjykYFM2GehIBBRewuiF6qFtOC4yyKO
IzY3ZPFVfKZzyghqoC2ABmOVEOi/DIbFX4YMiVmtYrr4IuKI+a2nx2OsW1b7RYCs
//wM3N3avTaB4QE/v+mpn/8XUZwKOLpnEwX5fhj8aokJ7UnESLhpExna5XVU/+F0
668bswzT4RyqkAXAnjqSvpqH2lNG3d8G+eEatyFPODMaxd7dE7ASsuyVnjSafubc
xi58vY3kT3HvY4AFmWkIP9GzAdTRdIu8ehxKV8fQGJYzrAzopV0ptjoVzQVqqiDy
P9c5T8aqK9peHSTsTUa5
=ucjp
-----END PGP SIGNATURE-----

--nextPart2048444.3xMuk2hNqk--
