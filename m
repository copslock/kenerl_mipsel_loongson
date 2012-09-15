Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Sep 2012 00:22:44 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:38713 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903239Ab2IOWWh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Sep 2012 00:22:37 +0200
Received: by lagu2 with SMTP id u2so3384018lag.36
        for <linux-mips@linux-mips.org>; Sat, 15 Sep 2012 15:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record;
        bh=5Wt5qkgo+oOBcu3h8EKDod3tPReHpckJ7yb6KaH2bgU=;
        b=JH7+btohi/2TyfzE5GKoDZF0YVfcFBB2RpB3XPn3CtutcjQnFTCIhYoMw2QgPcEYmU
         uHi2yIVa3Pzr6M0BZU8tpg9tBs4Slywcvy/LVCyHi2VmODhZW1hvaBJ1oWH0xyRkAELj
         HPRtdqZdCRyPTgo3znsEnOnavedOc6yzfESLyKTt/MKH0q3eo4m6bqbsVzRgYeinkUjH
         HrER5rBXWi01UJOqP1/6SiwIzpXTMPsXeHCmjckFVxP1HE18gMsVc1Q9IcjI9fmlVBiB
         yZf3Hff8M9qtSSMZC7l3zHs3YegSGqh/7JIEAjnjdC7/Okj0BUzWnwfQstuJz7PehNDD
         ZsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=5Wt5qkgo+oOBcu3h8EKDod3tPReHpckJ7yb6KaH2bgU=;
        b=MV/3pNm0fHG2y2ALeFSLCqZaOxp5TW2+BOwMgSBkXcQ8uya+Xui3tzaNFyideoa0XI
         p5rBKnDN0eyNH2vfE9kFOTwc95otbg549km4A58HVrZR6VpQuMKai9bbCtUUsf3ptsLg
         G1FZ6FriYbac6EkbD5uGrJC3klgiaBVjFQlvyZtDLQRAzZrrYFu2gClh1Uuunv7ajetJ
         6cSkrrfSbm1dRUXRig9bMARPHvppLSif/yd7sJlfcuYw6+X1WxECE0kxO8oh4wps7k0Q
         2vBou0nB44dZIpKR1OJ/8t4Ha3P9ekYdGv8TGOBwZHE89V1pfT5A1y1I89yEdehZ6EsJ
         vcog==
Received: by 10.152.114.3 with SMTP id jc3mr6171158lab.11.1347747751566;
        Sat, 15 Sep 2012 15:22:31 -0700 (PDT)
Received: by 10.152.114.3 with SMTP id jc3mr6171113lab.11.1347747751398; Sat,
 15 Sep 2012 15:22:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.132.73 with HTTP; Sat, 15 Sep 2012 15:22:11 -0700 (PDT)
In-Reply-To: <20120915075301.GA31044@avionic-0098.mockup.avionic-design.de>
References: <1347655456-2542-1-git-send-email-thierry.reding@avionic-design.de>
 <1347655456-2542-2-git-send-email-thierry.reding@avionic-design.de>
 <CAMuHMdWuR_tdMw9iVkaQ3D9p1HVU_L05ap=MzBuo1jLD6YdHHw@mail.gmail.com> <20120915075301.GA31044@avionic-0098.mockup.avionic-design.de>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Sat, 15 Sep 2012 16:22:11 -0600
Message-ID: <CAErSpo7q9fvtjatfKqtb8SP3UOJdEXpbvFC_qMBTc6mAoRTQuA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Provide a default pcibios_update_irq()
To:     Thierry Reding <thierry.reding@avionic-design.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Greg Ungerer <gerg@uclinux.org>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQnbIur6eyJqKOpVuVPerbGLVOZB7tYTmNts9eFDFSIRIoNPd2L39kej7qqdMvuB0lb/+YXGfyvkSQqN9ak12oc/UFh1Baf6azjHinm7AIeYz4fFLRCUgAu2YiNBf/xbTlwHAjT7bkv59glJHM5lCD4zM+8qQ/WSOmbh8DgV+ANPBp/ZhC66DgD9juDB7GU8ZXRgW3aGph/KvNFuhHBJFmFu5dWHMQ==
X-archive-position: 34512
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

On Sat, Sep 15, 2012 at 1:53 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Sat, Sep 15, 2012 at 09:32:10AM +0200, Geert Uytterhoeven wrote:
>> On Fri, Sep 14, 2012 at 10:44 PM, Thierry Reding
>> <thierry.reding@avionic-design.de> wrote:
>> > --- a/drivers/pci/setup-irq.c
>> > +++ b/drivers/pci/setup-irq.c
>> > @@ -17,6 +17,14 @@
>> >  #include <linux/ioport.h>
>> >  #include <linux/cache.h>
>> >
>> > +void __devinit __weak pcibios_update_irq(struct pci_dev *dev, int irq)
>> > +{
>> > +#ifdef CONFIG_PCI_DEBUG
>> > +       printk(KERN_DEBUG "PCI: Assigning IRQ %02d to %s\n", irq,
>> > +              pci_name(dev));
>>
>> pr_debug()?
>> Or even better, dev_dbg()?
>
> The problem with pr_debug() and dev_dbg() is that they will be compiled
> out if DEBUG is not defined. Perhaps we should pass -DDEBUG if PCI_DEBUG
> is configured and make this dev_dbg()?
