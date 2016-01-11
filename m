Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2016 12:12:22 +0100 (CET)
Received: from smtp02.citrix.com ([66.165.176.63]:51039 "EHLO
        SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009437AbcAKLMTT-LLe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jan 2016 12:12:19 +0100
X-IronPort-AV: E=Sophos;i="5.20,552,1444694400"; 
   d="scan'208";a="330353750"
Message-ID: <56938E06.9050702@citrix.com>
Date:   Mon, 11 Jan 2016 11:12:06 +0000
From:   David Vrabel <david.vrabel@citrix.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        <virtualization@lists.linux-foundation.org>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>,
        <linux-ia64@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-s390@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-metag@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <x86@kernel.org>, <user-mode-linux-devel@lists.sourceforge.net>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        <linux-sh@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        <xen-devel@lists.xenproject.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Julien Grall <julien.grall@citrix.com>,
        "Ross Lagerwall" <ross.lagerwall@citrix.com>,
        Stefano Stabellini <stefano.stabellini@citrix.com>,
        Wei Liu <wei.liu2@citrix.com>
Subject: Re: [PATCH v3 39/41] xen/events: use virt_xxx barriers
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
 <1452426622-4471-40-git-send-email-mst@redhat.com>
In-Reply-To: <1452426622-4471-40-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-DLP:  MIA2
Return-Path: <prvs=81176a5d5=david.vrabel@citrix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.vrabel@citrix.com
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

On 10/01/16 14:21, Michael S. Tsirkin wrote:
> drivers/xen/events/events_fifo.c uses rmb() to communicate with the
> other side.
> 
> For guests compiled with CONFIG_SMP, smp_rmb would be sufficient, so
> rmb() here is only needed if a non-SMP guest runs on an SMP host.
> 
> Switch to the virt_rmb barrier which serves this exact purpose.
> 
> Pull in asm/barrier.h here to make sure the file is self-contained.
> 
> Suggested-by: David Vrabel <david.vrabel@citrix.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
