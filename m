Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2015 18:25:06 +0100 (CET)
Received: from mail-we0-f179.google.com ([74.125.82.179]:34604 "EHLO
        mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007908AbbCIRZEx66JY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2015 18:25:04 +0100
Received: by wesx3 with SMTP id x3so23500644wes.1;
        Mon, 09 Mar 2015 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ixtNUdRnCYGYBCOJLlKcZFiClqe9b2ypT+p95R7vrvs=;
        b=JPUeschiOCEc/hxQ3E6DAKPkLoPtwr0edL2CFtqzy3pTLQTtCLXp191DgYrLVdnFvs
         du9NcyaAH9dCouuwE085qslGfBnHjAomXRqOG5lvzVAQXR6n2Gn7mOdV6Rhout1bfBsD
         7ZD2vIKofcaO9PK5UZmEuP6TuhKLwTwPEbdcBXHYhfaIfSo15Vgyl09TIbvQPMCsUAOP
         CF6tvtrPWk5JEu8LrbKW0H6TiW6ehlpKseL61BmYCC52+/GJKCez3Gn+kUW1+b5+WudJ
         8R7bZATfsGTz4YoMaLNWQPirsdqLknOLzAKISjrVKuy+jcV5irhkQSLjijF+ZhTG9jhh
         N86g==
X-Received: by 10.194.82.226 with SMTP id l2mr61453514wjy.11.1425921900233;
 Mon, 09 Mar 2015 10:25:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.180.198.145 with HTTP; Mon, 9 Mar 2015 10:24:29 -0700 (PDT)
In-Reply-To: <20150309165242.GK3739@saruman.tx.rr.com>
References: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com>
 <1425565425-12604-1-git-send-email-valentinrothberg@gmail.com> <20150309165242.GK3739@saruman.tx.rr.com>
From:   Valentin Rothberg <valentinrothberg@gmail.com>
Date:   Mon, 9 Mar 2015 18:24:29 +0100
Message-ID: <CAD3Xx4JCL7Gt9SEoumiKSvmQOL-JQmg0Qth5wRE7COFZ-Oap8g@mail.gmail.com>
Subject: Re: [PATCH v2] Remove deprecated IRQF_DISABLED flag entirely
To:     balbi@ti.com
Cc:     akpm@linux-foundation.org, Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Bolle <pebolle@tiscali.nl>, Jiri Kosina <jkosina@suse.cz>,
        Hannes Reinecke <hare@suse.de>, Ewan Milne <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>, Nishanth Menon <nm@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Afzal Mohammed <afzal@ti.com>, Keerthy <j-keerthy@ti.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Quentin Lambert <lambert.quentin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
        Eyal Perry <eyalpe@mellanox.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, iss_storagedev@hp.com,
        linux-mtd@lists.infradead.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <valentinrothberg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46299
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

On Mon, Mar 9, 2015 at 5:52 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Mar 05, 2015 at 03:23:08PM +0100, Valentin Rothberg wrote:
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
>>
>> Changelog
>>
>> v2: Correct previous change to drivers/mtd/nand/hisi504_nand.c that
>> broke compilation.  Reported by Dan Carpenter.
>> ---
>>  drivers/usb/isp1760/isp1760-core.c   |  3 +--
>>  drivers/usb/isp1760/isp1760-udc.c    |  4 ++--
>
> I have a commit in my tree for isp1760:
>
> https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=testing/fixes&id=80b4a0f8feeb6ee7fa4430a2b4ae1155ed923bd2

I am sorry, but I did not receive an email that it has been applied.
Andrew asked me to do this patch, so I replied to the one you
mentioned to avoid this conflict:

http://comments.gmane.org/gmane.linux.kernel/1896211

Kind regards,
 Valentin
