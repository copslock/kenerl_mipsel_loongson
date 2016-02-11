Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 17:32:56 +0100 (CET)
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35429 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011283AbcBKQcywRZfr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 17:32:54 +0100
Received: by mail-pf0-f196.google.com with SMTP id w128so2161166pfb.2;
        Thu, 11 Feb 2016 08:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+RLLYdXejehBcggVpiK9AsUIPMZMA1xflR6BVXu28iU=;
        b=kroGRlGsrkVAL6/ZXn0pewP7PiGucuxqUhAT/1MeLrIcIND4vmQYq6uZYQPtqGUAHK
         EMCXvm+Xhodvtd6/6HUpJ3lQZ67Qj6cVCeVls3PdVR89W9Fk8bPVvoNjjjrf2psfDjsh
         JISdcQvRdZK7TBlOnDZ4X3gjshOiYduduyeRDCYe70XJWQsOzYHrsldsACsnRE+UzMiV
         iA9Hj4dqGHW1xBKCHAKj0OAynaNb5KULiqY4N6mwOU2ZVgNidMC2b+ubutgtZGaCaBn6
         bm2EZyoLdpPCdeYxbDjvUZ/KtDAiZ5FlJrHbFeqFyi7grh/Fq9ICmbs5q++5jwIKZVaX
         t0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+RLLYdXejehBcggVpiK9AsUIPMZMA1xflR6BVXu28iU=;
        b=Bw52y0R6hrQkETdVQrABtwPcCd6hP4+rCZ1ipFshrg0Znqa2I0uiRvmM2B4yIxMufC
         xfaazyHeDROh14e5GmAbo8AYZwQ5BtSXuvtN8MfvfH9htu7rtByvLddzErWx0UdbOb3p
         2DEXCmtgnkUgT/zL11VyTGHsadTCpFFg5trhqERQ54CtwlzxJ8aebOQ/RlG9IVuilizK
         7eAEus06VwBtNWCl1xrV8vmp4gFs8mHpsWuHmQ2pWbtEkk8YH4+PAhK9vkJfD3DFF6db
         QbU2xrQwxHPHrthd+uPOf5vzNwH6T3d4lLCsJd5wBBi/q/pxMP0MStAPaadhCb3TTLOr
         uiKg==
X-Gm-Message-State: AG10YOSvGP/a+7a/HsjwoYPK2EReZ+taO4+k0Tan5zLPbcM1/mMedW1cQLoyXvjYiHRKMw==
X-Received: by 10.98.7.146 with SMTP id 18mr34034915pfh.47.1455208368849;
        Thu, 11 Feb 2016 08:32:48 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id m16sm13416847pfi.75.2016.02.11.08.32.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Feb 2016 08:32:47 -0800 (PST)
Message-ID: <56BCB7AE.2050901@gmail.com>
Date:   Thu, 11 Feb 2016 08:32:46 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     david.daney@cavium.com, aleksey.makarov@caviumnetworks.com,
        ulf.hansson@linaro.org, robh@kernel.org, ralf@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/3] MIPS: OCTEON: Rename legacy properties in internal
 device trees.
References: <1455207976-2262-1-git-send-email-matt.redfearn@imgtec.com> <1455207976-2262-2-git-send-email-matt.redfearn@imgtec.com>
In-Reply-To: <1455207976-2262-2-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52016
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 02/11/2016 08:26 AM, Matt Redfearn wrote:
> Many OCTEON devices have been shipped in products with fixed DTBs. These
> DTBS contain properties which are not compatible with newer kernels with
> upstream drivers.
> Therefore some mechanism is necessary to convert legacy naming into
> upstream naming. In the first instance this is to support the OCTEON MMC
> controller, which is in a later patch of this series.
> This patch adds a octeon_handle_legacy_device_tree() function which is
> always called from device_tree_init() to fix up the device tree so that
> drivers need have no knowledge of the legacy naming or properties.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

NAK...

I already sent e-mail on this, but it crossed in flight.

Basically, this patch is much more complex than the original code which 
was just a few lines to check the alternate "legacy" names.

Also this code is prone to breakage, see below...


> ---
> For reference, the legacy MMC bindings are as follows. Only the
> spi-max-frequency and bus-width properties currently need renaming.
>
> mmc: mmc@1180000002000 {
> 	compatible = "cavium,octeon-6130-mmc";
> 	reg = <0x11800 0x00002000 0x0 0x100>,
> 		<0x11800 0x00000168 0x0 0x20>;
> 	#address-cells = <1>;
> 	#size-cells = <0>;
> 	/* EMM irq, DMA irq */
> 	interrupts = <1 19>, <0 63>;
>
> 	/* The board only has a single MMC slot */
> 	mmc-slot@2 {
> 		compatible = "cavium,octeon-6130-mmc-slot";
> 		reg = <2>;
> 		voltage-ranges = <3300 3300>;
> 		spi-max-frequency = <26000000>;
> 		/* Power on GPIO 8, active high */
> 		/* power-gpios = <&gpio 8 0>; */
> 		power-gpios = <&gpio 8 1>;
>
> 	/*      spi-max-frequency = <52000000>; */
> 		/* bus width can be 1, 4 or 8 */
> 		cavium,bus-max-width = <8>;
> 	};
> 	mmc-slot@0 {
> 		compatible = "cavium,octeon-6130-mmc-slot";
> 		reg = <0>;
> 		voltage-ranges = <3300 3300>;
> 		spi-max-frequency = <26000000>;
> 		/* non-removable; */
> 		bus-width = <8>;
> 		/* bus width can be 1, 4 or 8 */
> 		cavium,bus-max-width = <8>;
> 	};
> };
> ---
>   arch/mips/cavium-octeon/octeon-platform.c | 57 +++++++++++++++++++++++++++++++
>   arch/mips/cavium-octeon/setup.c           |  3 ++
>   2 files changed, 60 insertions(+)
>
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index d113c8ded6e2..7933978bdfa5 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -980,6 +980,63 @@ end_led:
>   	return 0;
>   }
>
> +/*
> + * Rename a DT property from legacy to upstream accepted name.
> + * The value is copied from old legacy name to new name.
> + */
> +static void __init octeon_fdt_renameprop(int node, const char *old, const char *new)
> +{
> +	const u32 *pv;
> +	u32 v;
> +
> +	pv = fdt_getprop(initial_boot_params, node, old, NULL);
> +	if (pv) {
> +		v = *pv;
> +		fdt_delprop(initial_boot_params, node, old);
> +		fdt_setprop_u32(initial_boot_params, node, new, v);
> +	}
> +}
> +
> +/*
> + * This function is called for every machine type to replace legacy entries
> + * in the device tree blob passed from older firmwares.
> + * It is impractical to change the DTB in shipped devices, but to support newer
> + * kernels with upstreamed drivers and DT bindings some massaging of the DTB
> + * must be done.
> + */
> +int __init octeon_handle_legacy_device_tree(void)
> +{
> +	const char *alias_prop;
> +	int aliases;
> +
> +	if (fdt_check_header(initial_boot_params))
> +		panic("Corrupt Device Tree.");
> +
> +	aliases = fdt_path_offset(initial_boot_params, "/aliases");
> +	if (aliases < 0) {
> +		pr_err("Error: No /aliases node in device tree.");
> +		return -EINVAL;
> +	}
> +

/aliases doesn't exist on many boards, so this will likely fail.


> +	/* MMC */
> +	alias_prop = fdt_getprop(initial_boot_params, aliases,
> +				 "emmc", NULL);
> +	if (alias_prop) {
> +		int mmc = fdt_path_offset(initial_boot_params, alias_prop);
> +		int slot = fdt_first_subnode(initial_boot_params, mmc);
> +
> +		while (slot > 0) {
> +			octeon_fdt_renameprop(slot, "cavium,bus-max-width",
> +					      "bus-width");
> +			octeon_fdt_renameprop(slot, "spi-max-frequency",
> +					      "max-frequency");
> +			slot = fdt_next_subnode(initial_boot_params, slot);
> +		}
> +	}
> +	return 0;
> +}
> +
> +
>   static int __init octeon_publish_devices(void)
>   {
>   	return of_platform_bus_probe(NULL, octeon_ids, NULL);
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index cd7101fb6227..f1f5191d02be 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -1080,6 +1080,7 @@ void __init prom_free_prom_memory(void)
>   }
>
>   int octeon_prune_device_tree(void);
> +int octeon_handle_legacy_device_tree(void);
>
>   extern const char __appended_dtb;
>   extern const char __dtb_octeon_3xxx_begin;
> @@ -1112,6 +1113,8 @@ void __init device_tree_init(void)
>
>   	initial_boot_params = (void *)fdt;
>
> +	octeon_handle_legacy_device_tree();
> +
>   	if (do_prune) {
>   		octeon_prune_device_tree();
>   		pr_info("Using internal Device Tree.\n");
>
