Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 07:28:48 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:41765 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008385AbaIPF2qAogK5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Sep 2014 07:28:46 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 95727140143;
        Tue, 16 Sep 2014 15:28:38 +1000 (EST)
Message-ID: <1410845317.12488.2.camel@concordia>
Subject: Re: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to
 configure MSI/MSI-X irq
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Yijing Wang <wangyijing@huawei.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-pci@vger.kernel.org,
        Bharat.Bhushan@freescale.com, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        xen-devel@lists.xenproject.org, arnab.basu@freescale.com,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Xinwei Hu <huxinwei@huawei.com>,
        Tony Luck <tony.luck@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        iommu@lists.linux-foundation.org, Wuyun <wuyun.wu@huawei.com>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Date:   Tue, 16 Sep 2014 15:28:37 +1000
In-Reply-To: <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
         <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

On Fri, 2014-09-05 at 18:10 +0800, Yijing Wang wrote:
> Use MSI chip framework instead of arch MSI functions to configure
> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

This looks fine and seems to boot OK.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
