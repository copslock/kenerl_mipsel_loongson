Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 13:27:19 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:40662 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903463Ab2HQL1Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Aug 2012 13:27:16 +0200
Message-ID: <502E2A4D.1020502@phrozen.org>
Date:   Fri, 17 Aug 2012 13:26:05 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     "Anoop P.A" <anoop.pa@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] Fix pci id check.
References: <1297779151-26595-1-git-send-email-anoop.pa@gmail.com> <1297779250-26798-1-git-send-email-anoop.pa@gmail.com>
In-Reply-To: <1297779250-26798-1-git-send-email-anoop.pa@gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

Hi Anoop,

> -#define MSP_HAS_PCI(ID)	(((u32)(ID) <= 0x4236) && ((u32)(ID) >= 0x4220))
> +#define MSP_HAS_PCI(ID)  ((((u32)(ID) <= (0x4236)) && \
> +			((u32)(ID) >= (0x4220))) || \
> +			((u32)(ID) == (0x7140)))
> +#define MSP_PCI_READ_REG32(base, byte_offset) \
> +	(*((volatile u32 *)((u8 *)(base) + (byte_offset))))

why not use __raw_readl() ?

>  	/* Extract Device ID */
> -	id = read_reg32(PCI_JTAG_DEVID_REG, 0xFFFF) >> 12;
> +	id = (MSP_PCI_READ_REG32(PCI_JTAG_DEVID_REG, 0) >> 12) & 0x0FFFF;

You can simplify the macro above as byte_offset == 0 ... do we even need
a macro as there is only one user of it ... ?

John
