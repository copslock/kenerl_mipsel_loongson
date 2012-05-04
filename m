Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2012 02:30:49 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:60634 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903782Ab2EDAap convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 May 2012 02:30:45 +0200
Received: by lagy4 with SMTP id y4so2085942lag.36
        for <linux-mips@linux-mips.org>; Thu, 03 May 2012 17:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=Y/Ftqp2+f0C33bWO5FyppNYLGW3qQdI+lguCiWNzNQ8=;
        b=WvIdsWIiYGPAVs28j/adO49txkSfOwjnEKxRrzL3JHXyh5K2Bpy+DO8N/EXopovbWk
         ZiT/JFpJa11Cezq/YviVhEzny0KDFO05CkpWbFSvfs2WFRj6X7wBWbYcp/mVuuP1PMDU
         Pohmk6ZP8RK+j33ltsFAxVrsuYRz1lhFGJ6ceIplZm3bU4NEN2YI2Hd2QdljVoMdUCOc
         jkbZp5/a+3dYGYgU7A/2xcMERnsy1EakEoeo1Zk/ndZm0Gkv1uAaLlSGqdxx1EQYOskx
         KceGw2A1+/5eBTg8Cut0L5aFXZfNh0A0qxfZTNTLMlA5NLvzlBCD98oDYjeVJ2htfzFa
         qLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=Y/Ftqp2+f0C33bWO5FyppNYLGW3qQdI+lguCiWNzNQ8=;
        b=mHvV4IaOBGsNypwxtOWSbpGzGK0co8b9dHMX4m2vdvVpLUZMgYVwDvr4cOlneF2ZHs
         HW24PRTMN9YN1TeOaw4jDHe6ZndVOriMF5CFYpT/GZ8NslcSISbaa+R5BaxhPFXw1/0b
         8fQzfsTzYWt8uSBBks1a6Z5LoJ9AfElZLk3W9I2mHmxF+IrGJYW3K0fv/PhIVhKOIZSu
         2MPtDrzjfOS8yaWmb5YnryrOMkE8BphkFbrTcwykc3HMydrljcwh2X95Ng7UOOHJjS/x
         rIVCLVy1qJC5a6F8Y8712H65Us8Rk/0jIciDkIAewUD1e0EsTPe6gG/jq+4El4e6ooTM
         kgCA==
Received: by 10.152.128.137 with SMTP id no9mr3890873lab.2.1336091440360;
        Thu, 03 May 2012 17:30:40 -0700 (PDT)
Received: by 10.152.128.137 with SMTP id no9mr3890856lab.2.1336091440239; Thu,
 03 May 2012 17:30:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.86.6 with HTTP; Thu, 3 May 2012 17:30:20 -0700 (PDT)
In-Reply-To: <4F9FE4F6.5070909@openwrt.org>
References: <1335808019-24502-1-git-send-email-blogic@openwrt.org>
 <4F9ED1DC.3050007@gmail.com> <4F9FE4F6.5070909@openwrt.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 3 May 2012 18:30:20 -0600
Message-ID: <CAErSpo4bZ=0=DtbDots_GOGeLNhX6Q4eJrdetaFQMv4iiv5+XA@mail.gmail.com>
Subject: Re: [PATCH] OF: PCI: const usage needed by MIPS
To:     John Crispin <blogic@openwrt.org>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQk4H8292E23VWjI4gKTNW2/gsXG/EmIThKYLZ2CAL5WoBbWMxTNmBnGhNzUDCImPxDocN6tZ8sQ7yJ3rGIpyUkPorG2F5xF3WpG7xyEvJFOczugHo08Kr0piSlN/7zQvl5xxu+xFy638AB29+uqagba7PQtcg==
X-archive-position: 33135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, May 1, 2012 at 7:28 AM, John Crispin <blogic@openwrt.org> wrote:
> On 30/04/12 19:54, David Daney wrote:
>> On 04/30/2012 10:46 AM, John Crispin wrote:
>>> On MIPS we want to call of_irq_map_pci from inside
>>>
>>> arch/mips/include/asm/pci.h:extern int pcibios_map_irq(
>>>                 const struct pci_dev *dev, u8 slot, u8 pin);
>>>
>>> For this to work we need to change several functions to const usage.
>>
>> I think there is a mismatch on this throughout the kernel.
>>
>> Properly fixing it requires touching many more places than these.
>> Although I haven't tried it, I wouldn't be surprised if doing this
>> caused warnings to appear in non-MIPS code.
>>
>> Ralf had a patch at one point that tried to make this consistent
>> tree-wide, but it is not yet applied.
>>
>> David Daney
>
> Hi,
>
> Ok, lets see what Ralf has to say.
>
> I just tested the patch on x86 with OF enabled and drivers turned on
> that use the API. I did not see any errors appear.

I'm far from a const expert, but I think this should be safe.  Here's
my reasoning:

We're changing pci_swizzle_interrupt_pin() to take a pointer to a
constant struct pci_dev.  pci_swizzle_interrupt_pin() only reads the
struct pci_dev; it doesn't modify it.  It is legal to pass either
"struct pci_dev *" or "const struct pci_dev *" to a function expecting
"const struct pci_dev *"; the callee just won't be able to modify the
struct, even if the caller can.

Similar reasoning applies to of_irq_map_pci().

So I'm fine with this.  You sent it to Grant, so I'll assume he'll
merge it unless I hear otherwise.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
