Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 10:40:44 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:59338 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006516AbbAIJkmSdSAf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 10:40:42 +0100
X-IronPort-AV: E=Sophos;i="5.07,729,1413270000"; 
   d="scan'208";a="54634330"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 09 Jan 2015 03:45:29 -0800
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Fri, 9 Jan 2015 01:40:33 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.174.1; Fri, 9 Jan 2015 01:41:02 -0800
Received: from jayachandranc.netlogicmicro.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 4BB7740FE5;    Fri,  9 Jan 2015 01:39:45 -0800 (PST)
Date:   Fri, 9 Jan 2015 15:18:19 +0530
From:   Jayachandran C. <jchandra@broadcom.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
Subject: Re: [PATCH 04/17] MIPS: Netlogic: Disable writing IRT for disabled
 blocks
Message-ID: <20150109094818.GA18823@jayachandranc.netlogicmicro.com>
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
 <1420630118-17198-5-git-send-email-jchandra@broadcom.com>
 <54AD67EF.2080406@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <54AD67EF.2080406@cogentembedded.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

On Wed, Jan 07, 2015 at 08:07:59PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 01/07/2015 02:28 PM, Jayachandran C wrote:
> 
> >If the device header of a block is not present, return invalid IRT
> >value so that we do not program an incorrect offset.
> 
> >Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> >---
> >  arch/mips/netlogic/xlp/nlm_hal.c | 25 ++++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> >diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
> >index 7e0d224..de41fb5 100644
> >--- a/arch/mips/netlogic/xlp/nlm_hal.c
> >+++ b/arch/mips/netlogic/xlp/nlm_hal.c
> >@@ -170,16 +170,23 @@ static int xlp_irq_to_irt(int irq)
> >  	}
> >
> >  	if (devoff != 0) {
> >+		uint32_t val;
> >+
> >  		pcibase = nlm_pcicfg_base(devoff);
> >-		irt = nlm_read_reg(pcibase, XLP_PCI_IRTINFO_REG) & 0xffff;
> >-		/* HW weirdness, I2C IRT entry has to be fixed up */
> >-		switch (irq) {
> >-		case PIC_I2C_1_IRQ:
> >-			irt = irt + 1; break;
> >-		case PIC_I2C_2_IRQ:
> >-			irt = irt + 2; break;
> >-		case PIC_I2C_3_IRQ:
> >-			irt = irt + 3; break;
> >+		val = nlm_read_reg(pcibase, XLP_PCI_IRTINFO_REG);
> >+		if (val == 0xffffffff) {
> >+			irt = -1;
> >+		} else {
> >+			irt = val & 0xffff;
> >+			/* HW weirdness, I2C IRT entry has to be fixed up */
> >+			switch (irq) {
> >+			case PIC_I2C_1_IRQ:
> >+				irt = irt + 1; break;
> >+			case PIC_I2C_2_IRQ:
> >+				irt = irt + 2; break;
> >+			case PIC_I2C_3_IRQ:
> >+				irt = irt + 3; break;
> 
>    Why not 'irt += n' in all 3 cases?
>    And don't place *break* on the same line -- this upsets checkpatch.pl IIRC.

checkpatch did not complain, and also I did not want to mix formatting
change with actual fix. But agree that the code can cleaned up a bit.
I will sent out a patch for this next cycle.

JC.
