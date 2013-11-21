Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Nov 2013 20:08:17 +0100 (CET)
Received: from top.free-electrons.com ([176.31.233.9]:54195 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6816069Ab3KUTIOAiq5i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 Nov 2013 20:08:14 +0100
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id 2A742848; Thu, 21 Nov 2013 20:08:11 +0100 (CET)
Received: from skate (AToulouse-651-1-274-104.w109-220.abo.wanadoo.fr [109.220.93.104])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 5901C81E;
        Thu, 21 Nov 2013 20:08:10 +0100 (CET)
Date:   Thu, 21 Nov 2013 20:08:04 +0100
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Richard Zhu <r65037@freescale.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, linux-s390@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 24/34] PCI: use weak functions for MSI arch-specific
 functions
Message-ID: <20131121200804.617d6ae6@skate>
In-Reply-To: <20131121173933.GT10382@linux-mips.org>
References: <1384915853-31006-1-git-send-email-r65037@freescale.com>
        <1384915853-31006-24-git-send-email-r65037@freescale.com>
        <20131121173933.GT10382@linux-mips.org>
Organization: Free Electrons
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Dear Ralf Baechle,

On Thu, 21 Nov 2013 18:39:33 +0100, Ralf Baechle wrote:
> On Wed, Nov 20, 2013 at 10:50:43AM +0800, Richard Zhu wrote:
> 
> Looking good,
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

I think this patch was mistakenly sent by Richard Zhu. It is already
part of mainline since 3.12:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/pci/msi.c?id=4287d824f265451cd10f6d20266b27a207a6cdd7.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
