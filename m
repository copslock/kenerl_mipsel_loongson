Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Dec 2013 18:37:56 +0100 (CET)
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:47038 "EHLO
        mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6871609Ab3LYGzZOK2Zp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Dec 2013 07:55:25 +0100
X-IronPort-AV: E=Sophos;i="4.95,547,1384329600"; 
   d="scan'208";a="5602255"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw1-out.broadcom.com with ESMTP; 24 Dec 2013 23:01:55 -0800
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.1.438.0; Tue, 24 Dec 2013 22:55:17 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.1.438.0; Tue, 24 Dec 2013 22:55:17 -0800
Received: from jayachandranc.netlogicmicro.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 5A31D246A3;    Tue, 24 Dec 2013 22:55:16 -0800 (PST)
Date:   Wed, 25 Dec 2013 12:37:27 +0530
From:   Jayachandran C. <jchandra@broadcom.com>
To:     John Crispin <john@phrozen.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 12/18] MIPS: Netlogic: XLP9XX UART offset
Message-ID: <20131225070726.GB22667@jayachandranc.netlogicmicro.com>
References: <1387624950-31297-1-git-send-email-jchandra@broadcom.com>
 <1387624950-31297-13-git-send-email-jchandra@broadcom.com>
 <52B5D14A.3030504@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <52B5D14A.3030504@phrozen.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38805
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

On Sat, Dec 21, 2013 at 06:35:06PM +0100, John Crispin wrote:
> On 21/12/13 12:22, Jayachandran C wrote:
> >Update IO offset of the early console UART.
> >
> >Signed-off-by: Jayachandran C<jchandra@broadcom.com>
> >---
> >  arch/mips/include/asm/netlogic/xlp-hal/uart.h |    3 ++-
> >  arch/mips/netlogic/common/earlycons.c         |    2 ++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/mips/include/asm/netlogic/xlp-hal/uart.h b/arch/mips/include/asm/netlogic/xlp-hal/uart.h
> >index 86d16e1..a6c5442 100644
> >--- a/arch/mips/include/asm/netlogic/xlp-hal/uart.h
> >+++ b/arch/mips/include/asm/netlogic/xlp-hal/uart.h
> >@@ -94,7 +94,8 @@
> >  #define nlm_read_uart_reg(b, r)		nlm_read_reg(b, r)
> >  #define nlm_write_uart_reg(b, r, v)	nlm_write_reg(b, r, v)
> >  #define nlm_get_uart_pcibase(node, inst)	\
> >-		nlm_pcicfg_base(XLP_IO_UART_OFFSET(node, inst))
> >+	nlm_pcicfg_base(cpu_is_xlp9xx() ?  XLP9XX_IO_UART_OFFSET(node) : \
> >+						XLP_IO_UART_OFFSET(node, inst))
> 
> nitpick: i think this looks really ugly. maybe move the ()?():()
> logic to a define ?

Since it is already inside a macro, I would say that the improvement is minor.
This is the also the same pattern we have used in all include/asm/xlp-hal/ files,
I cannot change it in just one place.

JC.
