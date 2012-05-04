Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2012 03:18:15 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64253 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903771Ab2EDBSI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 May 2012 03:18:08 +0200
Received: by pbbrq13 with SMTP id rq13so3428443pbb.36
        for <multiple recipients>; Thu, 03 May 2012 18:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=l4sAEpx8MjtX1KI7Lhv/D/Am3O/SilbAfdb4moW3Uko=;
        b=H/8yAbyfwkQj0JVsdNbDGzpAgV005Sxg3Ry1nCViXQzGuC85XIvW+4MZcuAxDFAJVj
         KCP6poyWYlQNvVYz5VaGHlB7KybhchPgwN2Il3EimgtUPnEzOjRzJRLoH+SOcJ/2+p1+
         kSycSLIXxhV6cCiKNLq+rqyhSVdLmhGPW6u6c0WA9vc+M6EasioEe5z/4i0BOtZN+471
         myrkHP/4Leuo1B6Mp+k8wdgH5okw5RKuHrUi5nnzO55aI4ugPAHU869xYQ5bGKgeLYjh
         YUCw9EwON05xpRWBUOBGlgfqOMuO0ZbRLtvJN/8fKxTJXyZGVF2aE8A8xDNkLh5VRyQz
         2Jlw==
Received: by 10.68.200.74 with SMTP id jq10mr1839952pbc.66.1336094282010;
        Thu, 03 May 2012 18:18:02 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ky10sm117171pbc.0.2012.05.03.18.18.00
        (version=SSLv3 cipher=OTHER);
        Thu, 03 May 2012 18:18:00 -0700 (PDT)
Message-ID: <4FA32E47.7020406@gmail.com>
Date:   Thu, 03 May 2012 18:17:59 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] OF: PCI: const usage needed by MIPS
References: <1335808019-24502-1-git-send-email-blogic@openwrt.org> <4F9ED1DC.3050007@gmail.com> <4F9FE4F6.5070909@openwrt.org> <CAErSpo4bZ=0=DtbDots_GOGeLNhX6Q4eJrdetaFQMv4iiv5+XA@mail.gmail.com>
In-Reply-To: <CAErSpo4bZ=0=DtbDots_GOGeLNhX6Q4eJrdetaFQMv4iiv5+XA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/03/2012 05:30 PM, Bjorn Helgaas wrote:
> On Tue, May 1, 2012 at 7:28 AM, John Crispin<blogic@openwrt.org>  wrote:
>> On 30/04/12 19:54, David Daney wrote:
>>> On 04/30/2012 10:46 AM, John Crispin wrote:
>>>> On MIPS we want to call of_irq_map_pci from inside
>>>>
>>>> arch/mips/include/asm/pci.h:extern int pcibios_map_irq(
>>>>                  const struct pci_dev *dev, u8 slot, u8 pin);
>>>>
>>>> For this to work we need to change several functions to const usage.
>>>
>>> I think there is a mismatch on this throughout the kernel.
>>>
>>> Properly fixing it requires touching many more places than these.
>>> Although I haven't tried it, I wouldn't be surprised if doing this
>>> caused warnings to appear in non-MIPS code.
>>>
>>> Ralf had a patch at one point that tried to make this consistent
>>> tree-wide, but it is not yet applied.
>>>
>>> David Daney
>>
>> Hi,
>>
>> Ok, lets see what Ralf has to say.
>>
>> I just tested the patch on x86 with OF enabled and drivers turned on
>> that use the API. I did not see any errors appear.
>
> I'm far from a const expert, but I think this should be safe.

> Here's my reasoning:
>
> We're changing pci_swizzle_interrupt_pin() to take a pointer to a
> constant struct pci_dev.  pci_swizzle_interrupt_pin() only reads the
> struct pci_dev; it doesn't modify it.  It is legal to pass either
> "struct pci_dev *" or "const struct pci_dev *" to a function expecting
> "const struct pci_dev *"; the callee just won't be able to modify the
> struct, even if the caller can.
>

The problem is when you start declaring function pointers in various ops 
vectors.

Consider:

void (*foo)(const struct pci_dev *)
void (*bar)(struct pci_dev *)

foo and bar are not type compatible, and you will get compiler warnings 
if you use one where the other is expected.

So the question is:  Are we ever going to the address of any of the 
functions that are being modified?  If so, we have created a problem.

> Similar reasoning applies to of_irq_map_pci().
>
> So I'm fine with this.  You sent it to Grant, so I'll assume he'll
> merge it unless I hear otherwise.
>
> Acked-by: Bjorn Helgaas<bhelgaas@google.com>
>
