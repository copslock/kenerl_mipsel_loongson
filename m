Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2015 08:56:43 +0100 (CET)
Received: from mail-yk0-f179.google.com ([209.85.160.179]:40892 "EHLO
        mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007137AbbCEH4mQGCTN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 5 Mar 2015 08:56:42 +0100
Received: by ykr79 with SMTP id 79so5780069ykr.7
        for <linux-mips@linux-mips.org>; Wed, 04 Mar 2015 23:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=srjVOeDXRrVq5Bgmb+PPvnq9vcXyqHRL2pOxwcJL+RE=;
        b=w91g2E7cC47VxVnrdMYn1/r8VlEtXEnl/EPILUZzDLoLkudZFS7xr9OJZS0t5JBCQt
         ox30q15LhJ/mulYx1Un5dig/8aUjs2cmhFxaZT0P9f3WmI7kcSP5Qq7L85icMIDXM8pn
         fMpfyRyMB91R4o1uXwYZkWkOicHw1GtUmjSu+MBmBXV4bq689r6vZCS+sHzs5zOjABUX
         nWLGQByOzAB5QFE4uoBmgLCqvClEIxKNenMaz32oO1f3qyyK5vEqqaNbyElbhwu5x9Iu
         2OUlDXrU5uO7JLRkIzEy/rwjiISt6DykNO9RLd/3oySVZU6jKDmxH2+aDS+BfizuTBr2
         rjbg==
X-Received: by 10.170.136.19 with SMTP id d19mr7070104ykc.2.1425542196220;
 Wed, 04 Mar 2015 23:56:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.170.186.67 with HTTP; Wed, 4 Mar 2015 23:56:16 -0800 (PST)
In-Reply-To: <CACna6ryM+iX-z+3rttp2psrX=-8nqq0S8cLvONrNHeG7DDFmGg@mail.gmail.com>
References: <CACna6rx+3TbNfLmT1Br-JjhDnTQLrFFtVzfmid=yOdBfcOwHoA@mail.gmail.com>
 <CAHNKnsRKFSutwKHtOY9QZTqBr_+2q4atuo=mg7QOBj35ipuUYQ@mail.gmail.com> <CACna6ryM+iX-z+3rttp2psrX=-8nqq0S8cLvONrNHeG7DDFmGg@mail.gmail.com>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Thu, 5 Mar 2015 10:56:16 +0300
Message-ID: <CAHNKnsRTpiqJRptSxttt7u5dyW59YYWrxrPyyg7zfGV_VVNQsw@mail.gmail.com>
Subject: Re: Looking for an idea/workaround for using MIPS ioremap_nocache
 (__ioremap) in IRQ
To:     =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

2015-03-05 9:40 GMT+03:00 Rafa³ Mi³ecki <zajec5@gmail.com>:
> On 3 March 2015 at 14:06, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>> 2015-02-16 10:35 GMT+03:00 Rafa³ Mi³ecki <zajec5@gmail.com>:
>>> Once I've hit
>>> BUG_ON(in_interrupt());
>>> when hacking PCI drivers locally on MIPS board. I see the problem but
>>> don't know the solution.
>>>
>>> 1) I think "read" and "write" of struct pci_ops should be safe to call
>>> in IRQ handler
>>> 2) In drivers/bcma/driver_pci_host.c we use ioremap_nocache
>>>
>>> This causes a problem for boards with 2 PCI(e) cards. The base address
>>> for the 2nd card is
>>> #define BCMA_SOC_PCI1_CFG               0x44000000U
>>> which doesn't allow MIPS to use KSEG1.
>>>
>>> As the result forwardtrace looks like this:
>>> 1) ioremap_nocache
>>> 2) __ioremap_mode
>>> 3) __ioremap
>>> 4) get_vm_area
>>> 5) __get_vm_area_node
>>> And then we can hit BUG_ON(in_interrupt());
>>>
>>> Can you see any solution for this? Currently there isn't any mainline
>>> code triggering this problem, but it would be nice to have everything
>>> working anyway.
>>>
>> Why do you need to read the PCI configuration space in the interrupt
>> handler? As you wrote, it uncommon that driver tries to do that.
>> Usually the PCI configuration read/updated during device
>> initialization stage (by the PCI core and by a device driver) and then
>> you interact with the I/O memory and not with the configuration space.
>
> This is what brcmsmac does. I copied this behavior locally to b43 when
> debugging some DMA controller problem.
>
> They do:
> request_irq(pdev->irq, brcms_isr, IRQF_SHARED, KBUILD_MODNAME, wl)
>
> And then the forwardtrace looks like this:
> brcms_isr
> brcms_c_isr
> wlc_intstatus
> brcms_deviceremoved
> ai_deviceremoved
> pci_read_config_dword(sii->pcibus, PCI_VENDOR_ID, &w);
>
Looks like as some kind of workaround and also marked as cardbus
specific in wlc_intstatus().

In any case, Jonas already noted in this thread that this PCI
controller driver serves only two devices, so you free to pre-remap
I/O mem at the controller initialization stage.

-- 
Sergey
