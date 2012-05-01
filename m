Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 May 2012 15:29:54 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:47858 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903717Ab2EAN3p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 May 2012 15:29:45 +0200
Message-ID: <4F9FE4F6.5070909@openwrt.org>
Date:   Tue, 01 May 2012 15:28:22 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] OF: PCI: const usage needed by MIPS
References: <1335808019-24502-1-git-send-email-blogic@openwrt.org> <4F9ED1DC.3050007@gmail.com>
In-Reply-To: <4F9ED1DC.3050007@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 30/04/12 19:54, David Daney wrote:
> On 04/30/2012 10:46 AM, John Crispin wrote:
>> On MIPS we want to call of_irq_map_pci from inside
>>
>> arch/mips/include/asm/pci.h:extern int pcibios_map_irq(
>>                 const struct pci_dev *dev, u8 slot, u8 pin);
>>
>> For this to work we need to change several functions to const usage.
>
> I think there is a mismatch on this throughout the kernel.
>
> Properly fixing it requires touching many more places than these.
> Although I haven't tried it, I wouldn't be surprised if doing this
> caused warnings to appear in non-MIPS code.
>
> Ralf had a patch at one point that tried to make this consistent
> tree-wide, but it is not yet applied.
>
> David Daney

Hi,

Ok, lets see what Ralf has to say.

I just tested the patch on x86 with OF enabled and drivers turned on
that use the API. I did not see any errors appear.

Thanks,
John
