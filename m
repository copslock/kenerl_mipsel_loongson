Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2012 05:20:01 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:47439 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903318Ab2IUDT5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2012 05:19:57 +0200
Received: by lbbgf7 with SMTP id gf7so3253981lbb.36
        for <linux-mips@linux-mips.org>; Thu, 20 Sep 2012 20:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record;
        bh=Rtw/GkRDlF7fki5PjlDcM6jPF9f0BbRmFMmdNfrs20k=;
        b=RMOxlJ35LjtETIc2eAIf5cUH41K9yX+YZWyguFHI+Ja1FHr63nesPrT0pUhXqqXBX7
         8TV0rMd5R9NA3LsMsmqmjviuadijPg3BJI3n8R5dRJSb8w8dBKAczghZTs+XgkB2Oqnb
         bAveLvYXu/oYwJi7fa+TMx20Gk+iuv3JpVOQkaX2T8atBH37OwKyl3K8WzOmmMX+Kfw0
         E92hJgn5jLAd0Q3JnsnXo68W791Husi1OvnenBKacuw8vgivfOSuUEPtoJeFdl++z7LV
         7huHBKlURmJGBjIqL1cU6SMpD3gC+nyGVw7TdTeWKbAx72ivHB1g2WX99YwcBFXfuikJ
         w8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=Rtw/GkRDlF7fki5PjlDcM6jPF9f0BbRmFMmdNfrs20k=;
        b=YHHGfuUwSedGa2XomtzBGx2SvLDOZ6QVXIRYfMnzPrwJ9AS8CT4CNTVMKuCDUwc5+X
         Q67leLgllZu3orBjS8x4ctUHmEq3GHSmJHq7vSnu3tk/vJHaMuSgn5uKCZOA2refevfq
         8Ay7kkso4X/3xkFNj1whrfRYfa65uGtApHF4in0JrjSRU4jONyaYgkslWhm4hgHTuaHe
         Zh+y+LIV+qKwJ+82AElJjWSkJxaSKVTIhh3HOvVDgbTqEU1Hjyuc6bh8OGaCr/qiqB4v
         mLoSn+E+BZA0fZpF3QL/UZGX2TZm2s4MmNmerc/a1KthVZHvh79vgkeOVYfmCvH7oHvg
         sq2g==
Received: by 10.152.114.3 with SMTP id jc3mr3154370lab.11.1348197590589;
        Thu, 20 Sep 2012 20:19:50 -0700 (PDT)
Received: by 10.152.114.3 with SMTP id jc3mr3154333lab.11.1348197590451; Thu,
 20 Sep 2012 20:19:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.132.73 with HTTP; Thu, 20 Sep 2012 20:19:30 -0700 (PDT)
In-Reply-To: <20120920083731.b99255eb8fdeea908d34ed2f@canb.auug.org.au>
References: <1347880974-13615-1-git-send-email-thierry.reding@avionic-design.de>
 <1347880974-13615-2-git-send-email-thierry.reding@avionic-design.de> <20120920083731.b99255eb8fdeea908d34ed2f@canb.auug.org.au>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 20 Sep 2012 21:19:30 -0600
Message-ID: <CAErSpo4RgNjFE7zH9vKTgAq_7djbWi5sR7k_DJYr8=G3A=0zeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI: Provide a default pcibios_update_irq()
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thierry Reding <thierry.reding@avionic-design.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Greg Ungerer <gerg@uclinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQl3qJUaL4zconefUv2Av5jGDQmdUb53MkboklHy99Sey/WSO+uWpc+RoIKEbNqLJ1AGHpBPDIW1zuPMIXK9pduEqVmEOHXcyNIckwGwYdvBnTh2R+agtpjX2TfrPWyEJQJJPJZEcp9NkLF/F+Lzg1EMKxRlCGs+lGw0nFIDbMWtyrMQjRLT1xvLRIyBLcCQU8xRvrYCh8nuGVPG/njhIBmoq+rKIg==
X-archive-position: 34533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Sep 19, 2012 at 4:37 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi,
>
> On Mon, 17 Sep 2012 13:22:54 +0200 Thierry Reding <thierry.reding@avionic-design.de> wrote:
>>
>> diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
>> index 270ae7b..3d61ce3 100644
>> --- a/drivers/pci/setup-irq.c
>> +++ b/drivers/pci/setup-irq.c
>> @@ -17,6 +17,11 @@
>>  #include <linux/ioport.h>
>>  #include <linux/cache.h>
>>
>> +void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
>> +{
>> +     dev_dbg(&dev->dev, "Assigning IRQ %02d\n", irq);
>> +     pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
>> +}
>>
>>  static void
>>  pdev_fixup_irq(struct pci_dev *dev,
>
> Didn't we have a problem with some compiler versions when the weak
> definition was in the same file as the call (there is a call to this
> function in drivers/pci/setup-irq.c)?

There was such a bug, but as far as I know, we aren't worrying about
it anymore: https://lkml.org/lkml/2011/7/4/9
