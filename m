Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Nov 2017 13:47:00 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:45449 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992325AbdKPMqyFCPTm convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Nov 2017 13:46:54 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 16 Nov 2017 12:45:30 +0000
Received: from MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563]) by
 MIPSMAIL01.mipstec.com ([fe80::5c93:1f20:524d:a563%13]) with mapi id
 14.03.0361.001; Thu, 16 Nov 2017 04:45:30 -0800
From:   Aleksandar Markovic <Aleksandar.Markovic@mips.com>
To:     James Hogan <James.Hogan@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Miodrag Dinic <Miodrag.Dinic@mips.com>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        Douglas Leung <Douglas.Leung@mips.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <Paul.Burton@mips.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: RE: [PATCH v9 3/3] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Thread-Topic: [PATCH v9 3/3] MIPS: ranchu: Add Ranchu as a new generic-based
 board
Thread-Index: AQHTXhfOlk9EmIq0B0Sx4ZGVYt9VOaMWg9yAgABte/g=
Date:   Thu, 16 Nov 2017 12:45:28 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEEC19ED4@MIPSMAIL01.mipstec.com>
References: <1510753368-16453-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1510753368-16453-4-git-send-email-aleksandar.markovic@rt-rk.com>,<20171115215910.GB27409@jhogan-linux.mipstec.com>
In-Reply-To: <20171115215910.GB27409@jhogan-linux.mipstec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-BESS-ID: 1510836330-452060-13501-65935-1
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.61
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186992
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.60 MARKETING_SUBJECT      HEADER: Subject contains 
        popular marketing words 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.61 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, MARKETING_SUBJECT, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-BRTS-Status: 1
Return-Path: <Aleksandar.Markovic@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60975
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

> From: James Hogan
> 
> Hi Aleksandar,
> 
> On Wed, Nov 15, 2017 at 02:42:20PM +0100, Aleksandar Markovic wrote:
> > diff --git a/arch/mips/configs/generic/board-ranchu.config b/arch/mips/configs/generic/board-ranchu.config
> > new file mode 100644
> > index 0000000..fee9ad4
> > --- /dev/null
> > +++ b/arch/mips/configs/generic/board-ranchu.config
> > @@ -0,0 +1,30 @@
> > +CONFIG_VIRT_BOARD_RANCHU=y
> 
> I presume its valid for Ranchu support to be enabled in MIPS32 / MIPS64,
> and R1 / R2 / R6 kernels? (that's fine if so, just making sure there's
> no need for a require comment).

Yes, Ranchu virtual machine, and Android emulator for that matter, support
all combinations you mentioned.

> 
> > diff --git a/arch/mips/generic/board-ranchu.c b/arch/mips/generic/board-ranchu.c
> > new file mode 100644
> > index 0000000..0efc555
> > --- /dev/null
> > +++ b/arch/mips/generic/board-ranchu.c
> > @@ -0,0 +1,85 @@
> 
> ...
> 
> > +static __init unsigned int ranchu_measure_hpt_freq(void)
> > +{
> 
> ...
> 
> > +     count += 5000;  /* round */
> > +     count -= count % 10000;
> 
> A comment to explain the purpose of the rounding would be helpful. I
> presume its there just to get a more accurate value since the frequency
> will always be a round value in practice.

An appropriate comment will be added in v10, but v10 will be submitted
no sooner than next week, to provide enough time for other people wanting
to review this and other patches.

> 
> Either way this patch looks good to me:
> Reviewed-by: James Hogan <jhogan@kernel.org>
> 
> Thanks!
> James

I appreciate your review!

Aleksandar
