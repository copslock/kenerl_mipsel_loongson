Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2012 12:56:57 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:34022 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903663Ab2EDK4q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 May 2012 12:56:46 +0200
Message-ID: <4FA3B596.3050106@openwrt.org>
Date:   Fri, 04 May 2012 12:55:18 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] OF: PCI: const usage needed by MIPS
References: <1335808019-24502-1-git-send-email-blogic@openwrt.org> <4F9ED1DC.3050007@gmail.com> <4F9FE4F6.5070909@openwrt.org> <CAErSpo4bZ=0=DtbDots_GOGeLNhX6Q4eJrdetaFQMv4iiv5+XA@mail.gmail.com> <4FA32E47.7020406@gmail.com>
In-Reply-To: <4FA32E47.7020406@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi David,

> The problem is when you start declaring function pointers in various
> ops vectors.
>
> Consider:
>
> void (*foo)(const struct pci_dev *)
> void (*bar)(struct pci_dev *)
>
> foo and bar are not type compatible, and you will get compiler
> warnings if you use one where the other is expected.
>
> So the question is:  Are we ever going to the address of any of the
> functions that are being modified?  If so, we have created a problem.
>



i could not find any place in the code where this happens, which does
not mean that there are none.


>> Similar reasoning applies to of_irq_map_pci().
>>
>> So I'm fine with this.  You sent it to Grant, so I'll assume he'll
>> merge it unless I hear otherwise.
>>
>> Acked-by: Bjorn Helgaas<bhelgaas@google.com>
>>
>

Thanks for the Ack, i hope this patch gets accepted as is. I am simply
missing the overview of the pci subsystem to evaluate if this can cause
regressions.


John
