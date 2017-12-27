Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 14:57:57 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:57449 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbdL0N5uPUXI0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Dec 2017 14:57:50 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 27 Dec 2017 13:56:50 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Wed, 27 Dec 2017 05:56:12 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     Rob Herring <robh@kernel.org>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <Paul.Burton@mips.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Douglas Leung <Douglas.Leung@mips.com>,
        "Goran Ferenc" <Goran.Ferenc@mips.com>,
        James Hogan <James.Hogan@mips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>,
        "Petar Jovanovic" <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: Document mti,mips-cpc binding
Thread-Topic: [PATCH v2 1/2] dt-bindings: Document mti,mips-cpc binding
Thread-Index: AQHTem9XT0rgPMPNbEumIXwhsW18p6NWt64AgACGdko=
Date:   Wed, 27 Dec 2017 13:56:12 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEEC28299@MIPSMAIL01.mipstec.com>
References: <1513869627-15391-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1513869627-15391-2-git-send-email-aleksandar.markovic@rt-rk.com>,<20171226214810.su23px4ue7q5t3xg@rob-hp-laptop>
In-Reply-To: <20171226214810.su23px4ue7q5t3xg@rob-hp-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1514383010-298553-22490-164871-1
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188397
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61632
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

Hi, Rob.

Thanks for the review.

> From: Rob Herring [robh@kernel.org]
> Sent: Tuesday, December 26, 2017 10:48 PM
> To: Aleksandar Markovic
> > On Thu, Dec 21, 2017 at 04:20:23PM +0100, Aleksandar Markovic wrote:
> > From: Paul Burton <paul.burton@mips.com>
> >
> > Document a binding for the MIPS Cluster Power Controller (CPC) which
> > simply allows the device tree to specify where the CPC registers are
> > located.
> >
> > Signed-off-by: Paul Burton <paul.burton@mips.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> > ---
> >  Documentation/devicetree/bindings/misc/mti,mips-cpc.txt | 8 ++++++++
> 
> power controllers are usually documented under bindings/power/

I am going to change the file location to Documentation/devicetree/bindings/power
in v3, unless someone objects.

Regards,
Aleksandar
From aleksandar.markovic@rt-rk.com Wed Dec 27 15:38:29 2017
Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Dec 2017 15:38:36 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:34431 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990394AbdL0Oi26IzO4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Dec 2017 15:38:28 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 0EB051A4946;
        Wed, 27 Dec 2017 15:38:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (unknown [10.10.13.43])
        by mail.rt-rk.com (Postfix) with ESMTPSA id E31FB1A4904;
        Wed, 27 Dec 2017 15:38:22 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Matt Redfearn <matt.redfearn@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH v3 0/2]  MIPS: Augment CPC support
Date:   Wed, 27 Dec 2017 15:37:50 +0100
Message-Id: <1514385475-23921-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
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
Content-Length: 1488
Lines: 46

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

v2->v3:

    - changed documentation file location from
        devicetree/bindings/misc to devicetree/bindings/power
    - minor commit message improvements
    - rebased to the latest code

v1->v2:

    - corrected wording in commit messages and documentation text
    - expanded cover letter to better explain the context of proposed
        changes
    - rebased to the latest code

This series is based on two patches from the larger series submitted
some time ago (30 Aug 2016):

https://www.linux-mips.org/archives/linux-mips/2016-08/msg00456.html

Both patches deal with MIPS Cluster Power Controller (CPC) support.
More specifically, they add device tree related functionalities to
that support.

This functionality is needed for further development of kernel support
for generic-based MIPS platforms that must be DT-based and will at the
same time make more extensive use of CPC.

This series is reviewed by the original author of the above-mentioned
larger series:

Reviewed-by: Paul Burton <paul.burton@mips.com>

Paul Burton (2):
  dt-bindings: Document mti,mips-cpc binding
  MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()

 Documentation/devicetree/bindings/power/mti,mips-cpc.txt |  8 ++++++++
 arch/mips/kernel/mips-cpc.c                              | 13 +++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.txt

-- 
2.7.4
