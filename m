Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 22:17:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64054 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993086AbcKVVRA0vq4W convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Nov 2016 22:17:00 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id C1D1F15BBB7F5;
        Tue, 22 Nov 2016 21:16:49 +0000 (GMT)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 22 Nov 2016 21:16:53 +0000
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 HHMAIL-X.hh.imgtec.org ([fe80::3509:b0ce:371:2b%18]) with mapi id
 14.03.0294.000; Tue, 22 Nov 2016 21:16:52 +0000
From:   Matt Redfearn <Matt.Redfearn@imgtec.com>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: RE: [PATCH 0/5] Enable KASLR for OCTEON platforms.
Thread-Topic: [PATCH 0/5] Enable KASLR for OCTEON platforms.
Thread-Index: AQHSRPq7XMIl/9/oGUa/w/DVGQzPSqDlgTYb
Date:   Tue, 22 Nov 2016 21:16:52 +0000
Message-ID: <9FCBB1D1936B2F4DB2DD02BA3957FB504CF9EC31@HHMAIL01.hh.imgtec.org>
References: <088264c9-75b8-37ff-6514-0f536b1f8e55@cavium.com>
In-Reply-To: <088264c9-75b8-37ff-6514-0f536b1f8e55@cavium.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.11.182.224]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matt.Redfearn@imgtec.com
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

Hi Steven
Apart from the possibility that https://patchwork.linux-mips.org/patch/14554/ removes the need for patch 2, the series looks good to me.

Thanks,
Matt
________________________________________
From: linux-mips-bounce@linux-mips.org [linux-mips-bounce@linux-mips.org] on behalf of Steven J. Hill [Steven.Hill@cavium.com]
Sent: 22 November 2016 19:43
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH 0/5] Enable KASLR for OCTEON platforms.

This patchset enables support of KASLR for OCTEON platforms.

Steven J. Hill (5):
  MIPS: FW: Make fw_init_cmdline() to be __weak.
  MIPS: Fix vmlinux.64 target for CONFIG_RELOCATABLE
  MIPS: OCTEON: Add fw_init_cmdline() for Cavium platforms.
  MIPS: OCTEON: Add plat_get_fdt() function for Cavium platforms.
  MIPS: OCTEON: Enable KASLR

 arch/mips/Kconfig               |  3 ++-
 arch/mips/Makefile              |  5 +++++
 arch/mips/cavium-octeon/setup.c | 23 +++++++++++++++++++++++
 arch/mips/include/asm/fw/fw.h   |  2 +-
 4 files changed, 31 insertions(+), 2 deletions(-)

--
1.9.1
