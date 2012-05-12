Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 May 2012 07:57:09 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:44886 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903564Ab2ELF5F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 May 2012 07:57:05 +0200
Message-ID: <4FADFB39.6010100@openwrt.org>
Date:   Sat, 12 May 2012 07:55:05 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org,
        devicetree-discuss@lists.ozlabs.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] OF: PCI: const usage needed by MIPS
References: <1335808019-24502-1-git-send-email-blogic@openwrt.org> <4F9ED1DC.3050007@gmail.com> <4F9FE4F6.5070909@openwrt.org> <CAErSpo4bZ=0=DtbDots_GOGeLNhX6Q4eJrdetaFQMv4iiv5+XA@mail.gmail.com> <4FA32E47.7020406@gmail.com> <4FA3B596.3050106@openwrt.org> <CAErSpo4AQh3cJzULkmP_Dqsf0cSPRP1WqvhuQR3gePXw2rN7rQ@mail.gmail.com>
In-Reply-To: <CAErSpo4AQh3cJzULkmP_Dqsf0cSPRP1WqvhuQR3gePXw2rN7rQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


> I compiled alpha, ia64, mips, parisc, powerpc, sh, sparc, and x86 and
> didn't see any issues related to this patch.  There might still be
> something,  but I'm willing to help work through them or revert this
> if it turns out to be a problem.  I'm still assuming that Grant will
> handle this.
>
> Bjorn
Hi Grant,

Is this patch ok with you ? If so would you mind if Ralf takes this via
his tree ? (this would avoid merge order problems)

Thanks,
John
