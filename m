Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 07:40:30 +0100 (CET)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:38940 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006918AbbCEGk3H3qZZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Mar 2015 07:40:29 +0100
Received: by iecat20 with SMTP id at20so20495317iec.6
        for <linux-mips@linux-mips.org>; Wed, 04 Mar 2015 22:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bpQFtqzd4NZIbO6iFHNEhcXEAOo6msSIMnB7m+n97ek=;
        b=DIVjOOPIST9fH6qPQn0EELuxBFCiEurEKmzBAnFBmb+GcuQUMixjnCZHU/ydKKQlxi
         SDJPeo/RitNpacpiOa+7KQY9cE1b1oqsdDxNUMYFlgFo7BVy0kucv72N1ATUkjEIqW7S
         wI2J3Zg5VpqFncTkLakJxFfdzA1/8NXgCu63kSwUPtGueCFrLvj2wb+mtrRWWhlENyTK
         h35TTXLPVH+NRtNUS3dPdQFb/D8T78B2KM861H++coVjsQOPh6OVa4oHnz6g8gUALEOQ
         X6DCREF8QbNBJyWQAsWpQ2avQiTja1jZsPd89GQvHC+krxjfhOxNPIfyFmpwPK0Bn4VJ
         /0Fw==
MIME-Version: 1.0
X-Received: by 10.107.170.33 with SMTP id t33mr3809417ioe.7.1425537624075;
 Wed, 04 Mar 2015 22:40:24 -0800 (PST)
Received: by 10.107.16.139 with HTTP; Wed, 4 Mar 2015 22:40:23 -0800 (PST)
In-Reply-To: <CAHNKnsRKFSutwKHtOY9QZTqBr_+2q4atuo=mg7QOBj35ipuUYQ@mail.gmail.com>
References: <CACna6rx+3TbNfLmT1Br-JjhDnTQLrFFtVzfmid=yOdBfcOwHoA@mail.gmail.com>
        <CAHNKnsRKFSutwKHtOY9QZTqBr_+2q4atuo=mg7QOBj35ipuUYQ@mail.gmail.com>
Date:   Thu, 5 Mar 2015 07:40:23 +0100
Message-ID: <CACna6ryM+iX-z+3rttp2psrX=-8nqq0S8cLvONrNHeG7DDFmGg@mail.gmail.com>
Subject: Re: Looking for an idea/workaround for using MIPS ioremap_nocache
 (__ioremap) in IRQ
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 3 March 2015 at 14:06, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
> 2015-02-16 10:35 GMT+03:00 Rafał Miłecki <zajec5@gmail.com>:
>> Once I've hit
>> BUG_ON(in_interrupt());
>> when hacking PCI drivers locally on MIPS board. I see the problem but
>> don't know the solution.
>>
>> 1) I think "read" and "write" of struct pci_ops should be safe to call
>> in IRQ handler
>> 2) In drivers/bcma/driver_pci_host.c we use ioremap_nocache
>>
>> This causes a problem for boards with 2 PCI(e) cards. The base address
>> for the 2nd card is
>> #define BCMA_SOC_PCI1_CFG               0x44000000U
>> which doesn't allow MIPS to use KSEG1.
>>
>> As the result forwardtrace looks like this:
>> 1) ioremap_nocache
>> 2) __ioremap_mode
>> 3) __ioremap
>> 4) get_vm_area
>> 5) __get_vm_area_node
>> And then we can hit BUG_ON(in_interrupt());
>>
>> Can you see any solution for this? Currently there isn't any mainline
>> code triggering this problem, but it would be nice to have everything
>> working anyway.
>>
> Why do you need to read the PCI configuration space in the interrupt
> handler? As you wrote, it uncommon that driver tries to do that.
> Usually the PCI configuration read/updated during device
> initialization stage (by the PCI core and by a device driver) and then
> you interact with the I/O memory and not with the configuration space.

This is what brcmsmac does. I copied this behavior locally to b43 when
debugging some DMA controller problem.

They do:
request_irq(pdev->irq, brcms_isr, IRQF_SHARED, KBUILD_MODNAME, wl)

And then the forwardtrace looks like this:
brcms_isr
brcms_c_isr
wlc_intstatus
brcms_deviceremoved
ai_deviceremoved
pci_read_config_dword(sii->pcibus, PCI_VENDOR_ID, &w);

-- 
Rafał
