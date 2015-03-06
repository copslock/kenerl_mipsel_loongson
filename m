Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 20:41:52 +0100 (CET)
Received: from mail-la0-f51.google.com ([209.85.215.51]:38109 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008272AbbCFTluj5Bic (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 20:41:50 +0100
Received: by labgf13 with SMTP id gf13so35179353lab.5;
        Fri, 06 Mar 2015 11:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fFCjkS94TKBXco3FWlsF3MsZxbSzJXqLSQEuszcluoY=;
        b=XUEbvSVaayyCG5rlt2H5bDE4v3wpKshB6of/2DY2HtnPOE5UEa+FHNSXgTvBCDuLQS
         NV1KYzBJMv5RUaYjROmWr+HmcszIGqp28Fz8ZiE4R2v9GMa53P92yQQk5hi0JikSvzg+
         K+gto9sVZyhqjnPWvmx6P5roKhmhHg5Hog24qOl4SgRMmzAC8pU0sXQ3umOp4TebB5nQ
         XQY1BHbY5fLv6YpHa0JFxwl4GBoY0o8RQhz9xZ82u2V2hT8CPtL7iRf1O1H4cd+46bp0
         uyu+B2ZTkkNoj7GynBqlsWOG+XYr5OzWrq1t6sSuTvRJcP2t5tjDIZp3IeGYt8xcDh2A
         A1jA==
MIME-Version: 1.0
X-Received: by 10.112.8.101 with SMTP id q5mr8546632lba.19.1425670905722; Fri,
 06 Mar 2015 11:41:45 -0800 (PST)
Received: by 10.25.155.130 with HTTP; Fri, 6 Mar 2015 11:41:45 -0800 (PST)
In-Reply-To: <54F855E4.9030106@suse.de>
References: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com>
        <54F855E4.9030106@suse.de>
Date:   Fri, 6 Mar 2015 11:41:45 -0800
Message-ID: <CAKdAkRRLk8rHyUw_fAGpNu_u8wkNyL2kDqFQ-=bigefkXqUcxA@mail.gmail.com>
Subject: Re: [PATCH] Remove deprecated IRQF_DISABLED flag entirely
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Valentin Rothberg <valentinrothberg@gmail.com>,
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
Return-Path: <dmitry.torokhov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitry.torokhov@gmail.com
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

On Thu, Mar 5, 2015 at 5:11 AM, Hannes Reinecke <hare@suse.de> wrote:
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

No, that would imply that IRQ never triggers whereas passing 0 means
we keep triggers that have been set by the platform.

Thanks.

-- 
Dmitry
