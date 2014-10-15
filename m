Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Oct 2014 04:36:55 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:32787 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010607AbaJOCgxF1gOd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Oct 2014 04:36:53 +0200
Received: from localhost (cpe-67-247-12-89.nyc.res.rr.com [67.247.12.89])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 284E158817D;
        Tue, 14 Oct 2014 19:36:46 -0700 (PDT)
Date:   Tue, 14 Oct 2014 22:36:41 -0400 (EDT)
Message-Id: <20141014.223641.1750858832286185881.davem@davemloft.net>
To:     wangyijing@huawei.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, huxinwei@huawei.com,
        wuyun.wu@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux@arm.linux.org.uk, linux-arch@vger.kernel.org,
        arnab.basu@freescale.com, Bharat.Bhushan@freescale.com,
        x86@kernel.org, arnd@arndb.de, tglx@linutronix.de,
        konrad.wilk@oracle.com, xen-devel@lists.xenproject.org,
        joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-mips@linux-mips.org, benh@kernel.crashing.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sebott@linux.vnet.ibm.com, tony.luck@intel.com,
        linux-ia64@vger.kernel.org, sparclinux@vger.kernel.org,
        cmetcalf@tilera.com, ralf@linux-mips.org, l.stach@pengutronix.de,
        david.vrabel@citrix.com, sergei.shtylyov@cogentembedded.com,
        mpe@ellerman.id.au, thierry.reding@gmail.com,
        thomas.petazzoni@free-electrons.com, liviu@dudau.co.uk
Subject: Re: [PATCH v3 25/27] Sparc/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1413342435-7876-26-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
        <1413342435-7876-26-git-send-email-wangyijing@huawei.com>
X-Mailer: Mew version 6.6 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.7 (shards.monkeyblade.net [149.20.54.216]); Tue, 14 Oct 2014 19:36:49 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Yijing Wang <wangyijing@huawei.com>
Date: Wed, 15 Oct 2014 11:07:13 +0800

> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Acked-by: David S. Miller <davem@davemloft.net>
