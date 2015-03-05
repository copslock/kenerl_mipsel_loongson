Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 14:11:07 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:37784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007189AbbCENLFalUy2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Mar 2015 14:11:05 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E8FE3AC2B;
        Thu,  5 Mar 2015 13:11:02 +0000 (UTC)
Message-ID: <54F855E4.9030106@suse.de>
Date:   Thu, 05 Mar 2015 14:11:00 +0100
From:   Hannes Reinecke <hare@suse.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Valentin Rothberg <valentinrothberg@gmail.com>,
        akpm@linux-foundation.org
CC:     Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Bolle <pebolle@tiscali.nl>, Jiri Kosina <jkosina@suse.cz>,
        Ewan Milne <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rajendra Nayak <rnayak@ti.com>,
        Sricharan R <r.sricharan@ti.com>,
        Afzal Mohammed <afzal@ti.com>, Keerthy <j-keerthy@ti.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Felipe Balbi <balbi@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kukjin Kim <kgene.kim@samsung.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Quentin Lambert <lambert.quentin@gmail.com>,
        Eyal Perry <eyalpe@mellanox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, iss_storagedev@hp.com,
        linux-mtd@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] Remove deprecated IRQF_DISABLED flag entirely
References: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com>
In-Reply-To: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <hare@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hare@suse.de
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

On 03/05/2015 01:59 PM, Valentin Rothberg wrote:
> The IRQF_DISABLED is a NOOP and has been scheduled for removal since
> Linux v2.6.36 by commit 6932bf37bed4 ("genirq: Remove IRQF_DISABLED from
> core code").
> 
> According to commit e58aa3d2d0cc ("genirq: Run irq handlers with
> interrupts disabled") running IRQ handlers with interrupts enabled can
> cause stack overflows when the interrupt line of the issuing device is
> still active.
> 
> This patch ends the grace period for IRQF_DISABLED (i.e., SA_INTERRUPT
> in older versions of Linux) and removes the definition and all remaining
> usages of this flag.
> 
> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
> ---
> The bigger hunk in Documentation/scsi/ncr53c8xx.txt is removed entirely
> as IRQF_DISABLED is gone now; the usage in older kernel versions
> (including the old SA_INTERRUPT flag) should be discouraged.  The
> trouble of using IRQF_SHARED is a general problem and not specific to
> any driver.
> 
> I left the reference in Documentation/PCI/MSI-HOWTO.txt untouched since
> it has already been removed in linux-next by commit b0e1ee8e1405
> ("MSI-HOWTO.txt: remove reference on IRQF_DISABLED").
> 
> All remaining references are changelogs that I suggest to keep.

While you're at it: having '0x0' as a value for the irq flags looks
a bit silly, and makes you wonder what the parameter is for.

I would rather like to have

#define IRQF_NONE 0x0

and use it for these cases.
That way the scope of that parameter is clear.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
