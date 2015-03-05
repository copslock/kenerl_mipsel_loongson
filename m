Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 14:33:51 +0100 (CET)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:44530 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007162AbbCENduIzqel (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2015 14:33:50 +0100
Received: by wivr20 with SMTP id r20so6779570wiv.3;
        Thu, 05 Mar 2015 05:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w5KUFgc1iukABxNFjD1rdZqfmkyewdcCrNM8Hi6d8To=;
        b=VEOVF2bxQlFITfkKQFa5B6qC7YhcihgUsT5TgXXB1aEA/HM8vK8weu5uuU+sI9Rkbj
         dSkVm/SxmCU+ylFQgA+0uCbwQMN4cLmcLPnDgDO1v2x771M/FiX07MMfDkUMaldXryB5
         Zw0hirOEHRLGyX7569kwU5P+KReNoZdbVUhqe7QkVa1oES8SY/WmI3OV8x3gOz6O0vwt
         x+Rado9f/F6DNp9j3g3/4wWcBsr8f156y9TTe2vliEJG/hwWTpqWX74me2lkzop1ng7K
         0D3YpsONJIOaH25J70JUSuuRA3JK2df/3V1KkhUMSwyOBw8zfCdJ8wVczN7p77BsL5bK
         KYHw==
X-Received: by 10.194.61.65 with SMTP id n1mr18837826wjr.53.1425562425451;
 Thu, 05 Mar 2015 05:33:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.180.198.145 with HTTP; Thu, 5 Mar 2015 05:33:13 -0800 (PST)
In-Reply-To: <20150305130850.GK5437@mwanda>
References: <1425560442-13367-1-git-send-email-valentinrothberg@gmail.com> <20150305130850.GK5437@mwanda>
From:   Valentin Rothberg <valentinrothberg@gmail.com>
Date:   Thu, 5 Mar 2015 14:33:13 +0100
Message-ID: <CAD3Xx4L3QWW91NupRevugvixNxoE8bk5Hf5XrgG-NYcPu9S=Sg@mail.gmail.com>
Subject: Re: [PATCH] Remove deprecated IRQF_DISABLED flag entirely
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     akpm@linux-foundation.org, Jonathan Corbet <corbet@lwn.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Bolle <pebolle@tiscali.nl>, Jiri Kosina <jkosina@suse.cz>,
        Ewan Milne <emilne@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rajendra Nayak <rnayak@ti.com>,
        Sricharan R <r.sricharan@ti.com>,
        Afzal Mohammed <afzal@ti.com>, Keerthy <j-keerthy@ti.com>,
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
X-archive-position: 46203
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

On Thu, Mar 5, 2015 at 2:08 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Thu, Mar 05, 2015 at 01:59:39PM +0100, Valentin Rothberg wrote:
>> diff --git a/drivers/mtd/nand/hisi504_nand.c b/drivers/mtd/nand/hisi504_nand.c
>> index 289ad3ac3e80..7f9f9c827c1d 100644
>> --- a/drivers/mtd/nand/hisi504_nand.c
>> +++ b/drivers/mtd/nand/hisi504_nand.c
>> @@ -758,8 +758,7 @@ static int hisi_nfc_probe(struct platform_device *pdev)
>>
>>       hisi_nfc_host_init(host);
>>
>> -     ret = devm_request_irq(dev, irq, hinfc_irq_handle, IRQF_DISABLED,
>> -                             "nandc", host);
>> +     ret = devm_request_irq(dev, irq, hinfc_irq_handle, "nandc", host);
>
> I think this breaks the build.

You're completely right, thanks!  Obviously I missed compiling this
driver.  I will fix it.

Kind regards,
 Valentin
