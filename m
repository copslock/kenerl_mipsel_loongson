Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jan 2018 16:09:34 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:34264 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990604AbeASPJZfkRTZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Jan 2018 16:09:25 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 19 Jan 2018 15:08:28 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Fri, 19 Jan 2018 07:07:48 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     James Hogan <James.Hogan@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Paul Burton <Paul.Burton@mips.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Douglas Leung <Douglas.Leung@mips.com>,
        "Goran Ferenc" <Goran.Ferenc@mips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Miodrag Dinic" <Miodrag.Dinic@mips.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: Document mti,mips-cpc binding
Thread-Topic: [PATCH v3 1/2] dt-bindings: Document mti,mips-cpc binding
Thread-Index: AQHTfyBvfdBTv3V2HUaS+qFUDeaua6N63oIAgACQTf0=
Date:   Fri, 19 Jan 2018 15:07:48 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEE12393C77@MIPSMAIL01.mipstec.com>
References: <1514385475-23921-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1514385475-23921-2-git-send-email-aleksandar.markovic@rt-rk.com>,<20180118222603.GG27409@jhogan-linux.mipstec.com>
In-Reply-To: <20180118222603.GG27409@jhogan-linux.mipstec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1516374507-298554-31496-62213-4
X-BESS-VER: 2017.17-r1801171719
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189150
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender 
        Domain Matches Recipient Domain 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62248
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

> On Wed, Dec 27, 2017 at 03:37:51PM +0100, Aleksandar Markovic wrote:
> > From: Paul Burton <paul.burton@mips.com>
> >
> > Document a binding for the MIPS Cluster Power Controller (CPC) that
> > allows the device tree to specify where the CPC registers are located.
> >
> > Signed-off-by: Paul Burton <paul.burton@mips.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> > ---
> >  Documentation/devicetree/bindings/power/mti,mips-cpc.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/mti,mips-cpc.txt b/Documentation/devicetree/bindings/power/mti,mips-cpc.txt
> > new file mode 100644
> 
> Is it worth adding to the MIPS GENERIC PLATFORM entry of MAINTAINERS,
> given that it directly benefits it?
> 
> Cheers
> James

If nobody objects, in the v4 of this series, as a part of this particular patch, I am going to add the line:

F:       Documentation/devicetree/bindings/power/mti,mips-cpc.txt

to the following segment in MAINTAINERS file:

MIPS GENERIC PLATFORM
M:      Paul Burton <paul.burton@mips.com>
L:      linux-mips@linux-mips.org
S:      Supported
F:      arch/mips/generic/
F:      arch/mips/tools/generic-board-config.sh

v4 is planned to be sent by the end of the day.

Thanks,
Aleksandar
From aleksandar.markovic@rt-rk.com Fri Jan 19 16:42:01 2018
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jan 2018 16:42:08 +0100 (CET)
Received: from mx2.rt-rk.com ([89.216.37.149]:36203 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990604AbeASPmBh0zqt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Jan 2018 16:42:01 +0100
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 2EB3E1A4AEC;
        Fri, 19 Jan 2018 16:41:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (unknown [10.10.13.43])
        by mail.rt-rk.com (Postfix) with ESMTPSA id E7C711A4AE8;
        Fri, 19 Jan 2018 16:41:54 +0100 (CET)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        Douglas Leung <douglas.leung@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org,
        Matt Redfearn <matt.redfearn@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 0/2] MIPS: Augment CPC support
Date:   Fri, 19 Jan 2018 16:40:47 +0100
Message-Id: <1516376459-25672-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62249
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
Content-Length: 1664
Lines: 52

From: Aleksandar Markovic <aleksandar.markovic@mips.com>

v3->v4:

    - documentation patch now contains updating of MAINTAINERS file
    - rebased to the latest code

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
 MAINTAINERS                                              |  1 +
 arch/mips/kernel/mips-cpc.c                              | 13 +++++++++++++
 3 files changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mti,mips-cpc.txt

-- 
2.7.4
