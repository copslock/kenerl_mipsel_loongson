Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2018 17:43:50 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:34456 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990434AbeBGQnm7LynV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Feb 2018 17:43:42 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 07 Feb 2018 16:43:36 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Wed, 7 Feb 2018 08:27:10 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Goran Ferenc <Goran.Ferenc@mips.com>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>,
        Paul Burton <Paul.Burton@mips.com>
Subject: RE: [PATCH 4/4] MIPS: generic: Don't claim PC parport/serio
Thread-Topic: [PATCH 4/4] MIPS: generic: Don't claim PC parport/serio
Thread-Index: AQHTnHNN9y3nUdlIYUyP/og/wzTtPaOZJq4j
Date:   Wed, 7 Feb 2018 16:27:09 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEE2517C9A2@MIPSMAIL01.mipstec.com>
References: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>,<62d0928450232217dcb1979e9c56e02a275bdfd0.1517609353.git-series.jhogan@kernel.org>
In-Reply-To: <62d0928450232217dcb1979e9c56e02a275bdfd0.1517609353.git-series.jhogan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1518021815-298554-7306-1310-1
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 1.10
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189771
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=1.10 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62455
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@mips.com
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

> 
> ________________________________________
> From: James Hogan [jhogan@kernel.org]
> Sent: Friday, February 2, 2018 11:14 PM
> To: Ralf Baechle; linux-mips@linux-mips.org
> Cc: Aleksandar Markovic; Goran Ferenc; Miodrag Dinic; James Hogan; Paul Burton
> Subject: [PATCH 4/4] MIPS: generic: Don't claim PC parport/serio
> 
> None of the supported MIPS generic platforms can have the PC parallel
> port or PC serial port (and we don't yet have to be concerned with
> Malta which does), and enabling the PC serial driver will result in a
> panic from i8042_flush during boot. Therefore conditionalise the MIPS
> selection of ARCH_MIGHT_HAVE_PC_{PARPORT,SERIO} on !MIPS_GENERIC.
> 
> This particularly matters since commit f2d0b0d5c171 ("MIPS: ranchu: Add
> Ranchu as a new generic-based board"), which adds a board fragment which
> enables INPUT_KEYBOARD. That implicitly enables KEYBOARD_ATKBD which
> then selects SERIO_I8042 if ARCH_MIGHT_HAVE_PC_SERIO.
> 
> We can always select it from specific platforms later.
> 
> Fixes: f2d0b0d5c171 ("MIPS: ranchu: Add Ranchu as a new generic-based board")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Miodrag Dinic <miodrag.dinic@mips.com>
> Cc: Goran Ferenc <goran.ferenc@mips.com>
> Cc: Aleksandar Markovic <aleksandar.markovic@mips.com>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: linux-mips@linux-mips.org
> ---
> Does anybody actually know which MIPS platforms can have these PC
> devices?
> ---
>  arch/mips/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Acked-by: Miodrag Dinic <miodrag.dinic@mips.com>
From Aleksandar.Markovic@mips.com Wed Feb  7 17:44:09 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Feb 2018 17:44:17 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:52126 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990400AbeBGQnoptfCV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Feb 2018 17:43:44 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 07 Feb 2018 16:43:34 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Wed, 7 Feb 2018 08:27:04 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
CC:     Goran Ferenc <Goran.Ferenc@mips.com>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>
Subject: RE: [PATCH 1/4] MIPS: generic: Fix machine compatible matching
Thread-Topic: [PATCH 1/4] MIPS: generic: Fix machine compatible matching
Thread-Index: AQHTnHNJz0FFGlj3gU6grt3S0Ed+KaOZI+5b
Date:   Wed, 7 Feb 2018 16:27:03 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEE2517B986@MIPSMAIL01.mipstec.com>
References: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>,<4d44540130007c278068ea4870e3c4efbd171ee6.1517609353.git-series.jhogan@kernel.org>
In-Reply-To: <4d44540130007c278068ea4870e3c4efbd171ee6.1517609353.git-series.jhogan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1518021805-298553-27713-4448-6
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.60
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189770
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains popular marketing words 
X-BESS-Outbound-Spam-Status: SCORE=0.60 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@mips.com
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

> 
> ________________________________________
> From: James Hogan [jhogan@kernel.org]
> Sent: Friday, February 2, 2018 11:14 PM
> To: Ralf Baechle; linux-mips@linux-mips.org
> Cc: Aleksandar Markovic; Goran Ferenc; Miodrag Dinic; James Hogan
> Subject: [PATCH 1/4] MIPS: generic: Fix machine compatible matching
> 
> We now have a platform (Ranchu) in the "generic" platform which matches
> based on the FDT compatible string using mips_machine_is_compatible(),
> however that function doesn't stop at a blank struct
> of_device_id::compatible as that is an array in the struct, not a
> pointer to a string.
> 
> Fix the loop completion to check the first byte of the compatible array
> rather than the address of the compatible array in the struct.
> 
> Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board support")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Reviewed-by: Paul Burton <paul.burton@mips.com>
> Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/include/asm/machine.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
Acked-by: Miodrag Dinic <miodrag.dinic@mips.com>
