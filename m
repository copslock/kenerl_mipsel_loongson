Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2012 18:47:26 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:1556 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825952Ab2KPRrZ4It06 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 16 Nov 2012 18:47:25 +0100
Received: from [10.9.200.133] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Fri, 16 Nov 2012 09:45:23 -0800
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Fri, 16 Nov 2012 09:46:47 -0800
Received: from jayachandranc.netlogicmicro.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 6295940FE8; Fri, 16
 Nov 2012 09:47:12 -0800 (PST)
Date:   Fri, 16 Nov 2012 23:18:07 +0530
From:   "Jayachandran C." <jchandra@broadcom.com>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: PCI: Update XLR/XLS PCI for the new PIC code
Message-ID: <20121116174806.GB3954@jayachandranc.netlogicmicro.com>
References: <1352976355-2780-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1352976355-2780-1-git-send-email-jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-WSS-ID: 7CB8A4391QK3613451-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 35027
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Ralf,

On Thu, Nov 15, 2012 at 04:15:55PM +0530, Jayachandran C wrote:
> Use the nlm_set_pic_extra_ack() call to setup the extra interrupt
> ACK needed by XLR PCI and XLS PCIe. Simplify the code by adding
> nlm_pci_link_to_irq().

This is needed to make XLR/XLS PCI work again in upstream-sfr.
I missed sending it out with the rest of the patchset which updated
PIC handling for multi-chip boards.

JC.
