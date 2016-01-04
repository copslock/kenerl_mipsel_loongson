Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 12:32:38 +0100 (CET)
Received: from smtp.citrix.com ([66.165.176.89]:37389 "EHLO SMTP.CITRIX.COM"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009352AbcADLcgGit2O (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 12:32:36 +0100
X-IronPort-AV: E=Sophos;i="5.20,520,1444694400"; 
   d="scan'208";a="322700815"
Message-ID: <568A584C.2070501@citrix.com>
Date:   Mon, 4 Jan 2016 11:32:28 +0000
From:   David Vrabel <david.vrabel@citrix.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>, <linux-ia64@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        <virtualization@lists.linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <sparclinux@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <linux-arch@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <x86@kernel.org>,
        <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>,
        <linux-xtensa@linux-xtensa.org>,
        <user-mode-linux-devel@lists.sourceforge.net>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        <adi-buildroot-devel@lists.sourceforge.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-metag@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        David Vrabel <david.vrabel@citrix.com>,
        <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>
Subject: Re: [Xen-devel] [PATCH v2 34/34] xen/io: use virt_xxx barriers
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-35-git-send-email-mst@redhat.com>
In-Reply-To: <1451572003-2440-35-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-DLP:  MIA1
Return-Path: <prvs=8047ed68d=david.vrabel@citrix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50836
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

On 31/12/15 19:10, Michael S. Tsirkin wrote:
> include/xen/interface/io/ring.h uses
> full memory barriers to communicate with the other side.
> 
> For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
> would be sufficient, so mb() and wmb() here are only needed if
> a non-SMP guest runs on an SMP host.
> 
> Switch to virt_xxx barriers which serve this exact purpose.

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
