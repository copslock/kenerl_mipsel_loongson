Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 09:41:56 +0100 (CET)
Received: from mail-oi0-f44.google.com ([209.85.218.44]:32789 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006157AbbCIIlyadoXH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2015 09:41:54 +0100
Received: by oifz81 with SMTP id z81so27919413oif.0;
        Mon, 09 Mar 2015 01:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6CebQjC2sAYJLAffFnIGTRhmHGDY1MH9IwP2sxSKSuE=;
        b=tIoT7XwfhGIG3RTt2zp23wMAm8lQ5zQUKJtekOnp12sJlmjoXBoO/r4YbRXcRcoiHO
         kI2NxvPqSG4Ad21xmBv5ORdsDazTViYc7f+k3YQFOHiw9Kk5eX0K1kBEbJz2O0NwEirh
         9cx4xZAxPIM1uiucCdA9OwDdMkAni+EGqeMEAyKqTCEorsYVoFu/fS0wcsH63J+Ns5lH
         kyFLu1asNjY9TrfpvigWrNk6xgyQLO0Uguktgj7RPJ6BtYjvXOBn2OF0EaBg9cKvW/AW
         Mp2ukBjB9J11kvrSQuoXB6dlQ2KUw8QPwTaoz1ggAYxgQxk8USDCoG7XuI7D5iweWKRb
         HJAA==
X-Received: by 10.202.194.212 with SMTP id s203mr19366944oif.115.1425890509060;
 Mon, 09 Mar 2015 01:41:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.116.4 with HTTP; Mon, 9 Mar 2015 01:41:18 -0700 (PDT)
In-Reply-To: <CAKdAkRRLk8rHyUw_fAGpNu_u8wkNyL2kDqFQ-=bigefkXqUcxA@mail.gmail.com>
References: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com>
 <54F855E4.9030106@suse.de> <CAKdAkRRLk8rHyUw_fAGpNu_u8wkNyL2kDqFQ-=bigefkXqUcxA@mail.gmail.com>
From:   Valentin Rothberg <valentinrothberg@gmail.com>
Date:   Mon, 9 Mar 2015 09:41:18 +0100
Message-ID: <CAD3Xx4L6T0_MFjC+7OwgaB40kn7wZX-RAMNWi5WOjJ9z+ZV46g@mail.gmail.com>
Subject: Re: [PATCH] Remove deprecated IRQF_DISABLED flag entirely
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        iss_storagedev@hp.com, linux-mtd@lists.infradead.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <valentinrothberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46282
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

On Fri, Mar 6, 2015 at 8:41 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Mar 5, 2015 at 5:11 AM, Hannes Reinecke <hare@suse.de> wrote:
>> On 03/05/2015 01:59 PM, Valentin Rothberg wrote:
>>> The IRQF_DISABLED is a NOOP and has been scheduled for removal since
>>> Linux v2.6.36 by commit 6932bf37bed4 ("genirq: Remove IRQF_DISABLED from
>>> core code").
>>>
>>> According to commit e58aa3d2d0cc ("genirq: Run irq handlers with
>>> interrupts disabled") running IRQ handlers with interrupts enabled can
>>> cause stack overflows when the interrupt line of the issuing device is
>>> still active.
>>>
>>> This patch ends the grace period for IRQF_DISABLED (i.e., SA_INTERRUPT
>>> in older versions of Linux) and removes the definition and all remaining
>>> usages of this flag.
>>>
>>> Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
>>> ---
>>> The bigger hunk in Documentation/scsi/ncr53c8xx.txt is removed entirely
>>> as IRQF_DISABLED is gone now; the usage in older kernel versions
>>> (including the old SA_INTERRUPT flag) should be discouraged.  The
>>> trouble of using IRQF_SHARED is a general problem and not specific to
>>> any driver.
>>>
>>> I left the reference in Documentation/PCI/MSI-HOWTO.txt untouched since
>>> it has already been removed in linux-next by commit b0e1ee8e1405
>>> ("MSI-HOWTO.txt: remove reference on IRQF_DISABLED").
>>>
>>> All remaining references are changelogs that I suggest to keep.
>>
>> While you're at it: having '0x0' as a value for the irq flags looks
>> a bit silly, and makes you wonder what the parameter is for.
>>
>> I would rather like to have
>>
>> #define IRQF_NONE 0x0
>>
>> and use it for these cases.
>> That way the scope of that parameter is clear.
>
> No, that would imply that IRQ never triggers whereas passing 0 means
> we keep triggers that have been set by the platform.

Are you against introducing a new flag or just don't like 'IRQF_NONE'?
 I think that passing 0 could mean anything when one does not know the
semantics.  Combining yours and Hannes' proposal could look like this:

#define IRQF_PLAT 0x0 - keep triggers that have been set by the platform

I wrote a Coccinelle script to check for such 0-flags and find 758
cases in current Linus' mainline.  The script only checks function
calls to {devm_}request_{threaded_}IRQ() but does not find flags
passed to wrapper functions or flags that are stored in a struct etc.

Kind regards,
 Valentin
