Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2015 12:42:21 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:49669 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014211AbbLRLmTjZzOe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Dec 2015 12:42:19 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C67F9491;
        Fri, 18 Dec 2015 03:41:47 -0800 (PST)
Received: from e106497-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA9053F24D;
        Fri, 18 Dec 2015 03:42:12 -0800 (PST)
Received: by e106497-lin.cambridge.arm.com (Postfix, from userid 1005)
        id 2FDD5107D8A0; Fri, 18 Dec 2015 11:42:11 +0000 (GMT)
Date:   Fri, 18 Dec 2015 11:42:11 +0000
From:   Liviu.Dudau@arm.com
To:     Matti Laakso <malaakso@elisanet.fi>
Cc:     linux-mips@linux-mips.org
Subject: Re: Unable to allocate PCI I/O resources
Message-ID: <20151218114210.GJ960@e106497-lin.cambridge.arm.com>
References: <56732950.4060201@elisanet.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56732950.4060201@elisanet.fi>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <Liviu.Dudau@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Liviu.Dudau@arm.com
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

On Thu, Dec 17, 2015 at 11:29:52PM +0200, Matti Laakso wrote:
> Hello all,
> 
> I have some oldish MIPS-based (Lantiq Danube) routers that have a PCI
> bus and a VIA 6212 USB-controller connected to it. The USB controller
> requires I/O resources in addition to memory. It seems that with kernel
> 3.18 and newer PCI I/O resources can no longer be allocated on this
> platform. I tracked the problem down to a patch set from Liviu Dudau
> (Support for creating generic PCI host bridges from DT). After this
> patch the function pci_address_to_pio in drivers/of/address.c hits the check
> 
> address > IO_SPACE_LIMIT
> 
> since address on this SoC is 0x1AE00000 and IO_SPACE_LIMIT is 0xFFFF on
> MIPS (PCI_IOBASE is not defined). Changing IO_SPACE_LIMIT to 0xFFFFFFFF
> I can work around the problem, but I think that is not the proper solution.

if PCI_IOBASE is not defined then you should not hit the code I have added
with commit 41f8bba7f5552d0 but the old code path, in which case I would
guess the code was broken before my change?

> 
> Any ideas on how to fix this?
> 

There is a distinction between IO range being visible from the CPU @ 0x1AE00000
and the IO address being used by the PCI subsystem. The IO address is a
bus address and it should be between 0 - IO_SPACE_LIMIT.

I would look into the actual user of pci_address_to_pio(), and maybe define
PCI_IOBASE for your platform to tell it where the IO space starts from CPU
point of view.

Best regards,
Liviu

> Best regards,
> Matti Laakso
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
