Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 14:41:41 +0100 (CET)
Received: from mail-we0-f169.google.com ([74.125.82.169]:38012 "EHLO
        mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007162AbbCENlits3CQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 14:41:38 +0100
Received: by wevk48 with SMTP id k48so6397843wev.5;
        Thu, 05 Mar 2015 05:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=y+3j+NKiFIdKNXFALObF4GXJrx9SBgnSFLUPr3fK2Wc=;
        b=uPRhctnX8BHML5JqrNNMNugchnkmtnwnGXavwmvGGlbyIqTK9FMum2yroLpK19SE/R
         v+JuwnDQaM4ptew9iLYpnK4GgqpUNmbOs/cUyFWUxzXNvnbIJrqqG11QIUotP6qYeKZP
         +tSV++nLIHKjUZk3jFq/3RaYIzC10I9VZ2E8LtkF2s4IW8rbP9h3/nGlwN7AB6XvJ4Y7
         xWSaTkwGUJLNGVw2J/DuP9ngnVjshWaAfTBPoYN+nvBzi0YGwZ3brq+/24ulyuV0D8tC
         b9swYEaAeyFU1SabAS7mAELqasPt4hOfLfb1q77YcnWC8rmv0lJa09n8V1keOr6TMIWL
         tI5w==
X-Received: by 10.180.108.13 with SMTP id hg13mr22601919wib.7.1425562894075;
 Thu, 05 Mar 2015 05:41:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.180.198.145 with HTTP; Thu, 5 Mar 2015 05:41:03 -0800 (PST)
In-Reply-To: <54F855E4.9030106@suse.de>
References: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com> <54F855E4.9030106@suse.de>
From:   Valentin Rothberg <valentinrothberg@gmail.com>
Date:   Thu, 5 Mar 2015 14:41:03 +0100
Message-ID: <CAD3Xx4K+ewe3RK479J_Vsm69pC3NO4q-u76Xy5L6Ps=FjVcQrw@mail.gmail.com>
Subject: Re: [PATCH] Remove deprecated IRQF_DISABLED flag entirely
To:     Hannes Reinecke <hare@suse.de>
Cc:     akpm@linux-foundation.org, Jonathan Corbet <corbet@lwn.net>,
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
Content-Type: text/plain; charset=UTF-8
Return-Path: <valentinrothberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: valentinrothberg@gmail.com
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

On Thu, Mar 5, 2015 at 2:11 PM, Hannes Reinecke <hare@suse.de> wrote:
> On 03/05/2015 01:59 PM, Valentin Rothberg wrote:
>> The IRQF_DISABLED is a NOOP and has been scheduled for removal since
>> Linux v2.6.36 by commit 6932bf37bed4 ("genirq: Remove IRQF_DISABLED from
>> core code").
>>
>> According to commit e58aa3d2d0cc ("genirq: Run irq handlers with
>> interrupts disabled") running IRQ handlers with interrupts enabled can
>> cause stack overflows when the interrupt line of the issuing device is
>> still active.
>>
>> This patch ends the grace period for IRQF_DISABLED (i.e., SA_INTERRUPT
>> in older versions of Linux) and removes the definition and all remaining
>> usages of this flag.
>>
>> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
>> ---
>> The bigger hunk in Documentation/scsi/ncr53c8xx.txt is removed entirely
>> as IRQF_DISABLED is gone now; the usage in older kernel versions
>> (including the old SA_INTERRUPT flag) should be discouraged.  The
>> trouble of using IRQF_SHARED is a general problem and not specific to
>> any driver.
>>
>> I left the reference in Documentation/PCI/MSI-HOWTO.txt untouched since
>> it has already been removed in linux-next by commit b0e1ee8e1405
>> ("MSI-HOWTO.txt: remove reference on IRQF_DISABLED").
>>
>> All remaining references are changelogs that I suggest to keep.
>
> While you're at it: having '0x0' as a value for the irq flags looks
> a bit silly, and makes you wonder what the parameter is for.
>
> I would rather like to have
>
> #define IRQF_NONE 0x0
>
> and use it for these cases.
> That way the scope of that parameter is clear.

I like the idea.  I checked the source code for such cases and passing
0 or 0x0 as IRQ flags appears quite often (also in the devm
counterparts).
If nobody is against your proposal, then I will prepare a Coccinelle
script that takes care of it and send it in  a patch series (e.g.,
introduce definition of IRQF_NONE, the Coccinelle and following a big
patch that applies changes proposed by the script).

Kind regards,
 Valentin
