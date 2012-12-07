Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 08:42:16 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:44171 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823012Ab2LGHmP3myGM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Dec 2012 08:42:15 +0100
Message-ID: <50C19D6D.5010700@phrozen.org>
Date:   Fri, 07 Dec 2012 08:40:29 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] OF: MIPS: sead3: Implement OF support.
References: <1354857297-28863-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1354857297-28863-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35241
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

Hi,

>   obj-y				+= sead3-i2c-dev.o sead3-i2c.o \
> @@ -17,3 +19,11 @@ obj-y				+= sead3-i2c-dev.o sead3-i2c.o \
>
>   obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
>   obj-$(CONFIG_USB_EHCI_HCD)	+= sead3-ehci.o
> +
> +DTS_FILES = sead3.dts
> +DTB_FILES = $(patsubst %.dts, %.dtb, $(DTS_FILES))
> +
> +obj-y += $(patsubst %.dts, %.dtb.o, $(DTS_FILES))
> +
> +$(obj)/%.dtb: $(obj)/%.dts FORCE
> +	$(call if_changed_dep,dtc)

there is a patch already in -next that obseletes this


> +void __init device_tree_init(void)
> +{
> +	unsigned long base, size;
> +
> +	if (!initial_boot_params)
> +		return;
> +
> +	base = virt_to_phys((void *)initial_boot_params);
> +	size = be32_to_cpu(initial_boot_params->totalsize);
> +
> +	/* Before we do anything, lets reserve the dt blob */
> +	reserve_bootmem(base, size, BOOTMEM_DEFAULT);
> +
> +	unflatten_device_tree();
> +
> +	/* free the space reserved for the dt blob */
> +	free_bootmem(base, size);

this free is one free too many. it will kill the devcietree. the code 
where you copied this from has been fixed in -next



John
