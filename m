Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2015 05:39:37 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:48036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006157AbbJ2EjfKjaqx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Oct 2015 05:39:35 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 0FB9D209F1;
        Thu, 29 Oct 2015 04:39:32 +0000 (UTC)
Received: from mail-yk0-f169.google.com (mail-yk0-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A0F209EC;
        Thu, 29 Oct 2015 04:39:29 +0000 (UTC)
Received: by ykba4 with SMTP id a4so30924258ykb.3;
        Wed, 28 Oct 2015 21:39:28 -0700 (PDT)
X-Received: by 10.129.51.196 with SMTP id z187mr36481494ywz.198.1446093568983;
 Wed, 28 Oct 2015 21:39:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.254.65 with HTTP; Wed, 28 Oct 2015 21:39:09 -0700 (PDT)
In-Reply-To: <1432309875-9712-15-git-send-email-paul.burton@imgtec.com>
References: <1432309875-9712-1-git-send-email-paul.burton@imgtec.com> <1432309875-9712-15-git-send-email-paul.burton@imgtec.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 28 Oct 2015 23:39:09 -0500
Message-ID: <CAL_JsqKrJWg=9Try=+2efz_JRGuthLSVDCdy2BQAGSdutoGvnA@mail.gmail.com>
Subject: Re: [PATCH 14/15] MIPS: malta: setup RAM regions via DT
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh+dt@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh+dt@kernel.org
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

On Fri, May 22, 2015 at 10:51 AM, Paul Burton <paul.burton@imgtec.com> wrote:
> Move memory configuration to be performed via device tree for the Malta
> board. This moves more Malta specific code to malta-dtshim.c, leaving
> the rest of the mti-malta code a little more board-agnostic. This will
> be useful to share more code between boards, with the device tree
> providing the board specifics as intended.
>
> Since we can't rely upon Malta boards running a bootloader capable of
> handling devictrees & filling in the required information, the
> malta_dt_shim code is extended to consume the (e)memsize variables
> provided as part of the bootloader environment (or on the kernel command
> line) then generate the DT memory node using the provided values.

IMO, I think this all belongs in a shim outside of the kernel. This is
how ARM and powerpc generally deal with old or broken bootloaders. But
then MIPS is such a mess of DT code with every platform doing things
their own way.

Rob

>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>
>  arch/mips/boot/dts/mti/malta.dts   |   4 ++
>  arch/mips/mti-malta/malta-dtshim.c | 104 +++++++++++++++++++++++++++++++++++++
>  arch/mips/mti-malta/malta-memory.c |  88 -------------------------------
>  3 files changed, 108 insertions(+), 88 deletions(-)
>
> diff --git a/arch/mips/boot/dts/mti/malta.dts b/arch/mips/boot/dts/mti/malta.dts
> index 9720c66..2fe2364 100644
> --- a/arch/mips/boot/dts/mti/malta.dts
> +++ b/arch/mips/boot/dts/mti/malta.dts
> @@ -1,5 +1,9 @@
>  /dts-v1/;
>
> +/memreserve/ 0x00000000 0x00001000;    /* reserved */
> +/memreserve/ 0x00001000 0x000ef000;    /* YAMON */
> +/memreserve/ 0x000f0000 0x00010000;    /* PIIX4 ISA memory */
> +
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/mips-gic.h>
>
> diff --git a/arch/mips/mti-malta/malta-dtshim.c b/arch/mips/mti-malta/malta-dtshim.c
> index ca33201..9074951 100644
> --- a/arch/mips/mti-malta/malta-dtshim.c
> +++ b/arch/mips/mti-malta/malta-dtshim.c
> @@ -20,6 +20,109 @@
>
>  static unsigned char fdt_buf[16 << 10] __initdata;
>
> +/* determined physical memory size, not overridden by command line args         */
> +extern unsigned long physical_memsize;
> +
> +#define MAX_MEM_ARRAY_ENTRIES 1
> +
> +static unsigned __init gen_fdt_mem_array(__be32 *mem_array, unsigned long size)
> +{
> +       unsigned long size_preio;
> +       unsigned entries;
> +
> +       entries = 1;
> +       mem_array[0] = cpu_to_be32(PHYS_OFFSET);
> +       if (config_enabled(CONFIG_EVA)) {
> +               mem_array[1] = cpu_to_be32(PHYS_OFFSET + size);
> +       } else {
> +               size_preio = min_t(unsigned long, size, 256 << 20);
> +               mem_array[1] = cpu_to_be32(PHYS_OFFSET + size_preio);
> +       }
> +
> +       BUG_ON(entries > MAX_MEM_ARRAY_ENTRIES);
> +       return entries;
> +}
> +
> +static void __init append_memory(void *fdt, int root_off)
> +{
> +       __be32 mem_array[2 * MAX_MEM_ARRAY_ENTRIES];
> +       unsigned long memsize;
> +       unsigned mem_entries;
> +       int i, err, mem_off;
> +       char *var, param_name[10], *var_names[] = {
> +               "ememsize", "memsize",
> +       };
> +
> +       /* if a memory node already exists, leave it alone */
> +       mem_off = fdt_path_offset(fdt, "/memory");
> +       if (mem_off >= 0)
> +               return;
> +
> +       /* find memory size from the bootloader environment */
> +       for (i = 0; i < ARRAY_SIZE(var_names); i++) {
> +               var = fw_getenv(var_names[i]);
> +               if (!var)
> +                       continue;
> +
> +               err = kstrtoul(var, 0, &physical_memsize);
> +               if (!err)
> +                       break;
> +
> +               pr_warn("Failed to read the '%s' env variable '%s'\n",
> +                       var_names[i], var);
> +       }
> +
> +       if (!physical_memsize) {
> +               pr_warn("The bootloader didn't provide memsize: defaulting to 32MB\n");
> +               physical_memsize = 32 << 20;
> +       }
> +
> +       if (config_enabled(CONFIG_CPU_BIG_ENDIAN)) {
> +               /*
> +                * SOC-it swaps, or perhaps doesn't swap, when DMA'ing
> +                * the last word of physical memory.
> +                */
> +               physical_memsize -= PAGE_SIZE;
> +       }
> +
> +       /* default to using all available RAM */
> +       memsize = physical_memsize;
> +
> +       /* allow the user to override the usable memory */
> +       for (i = 0; i < ARRAY_SIZE(var_names); i++) {
> +               snprintf(param_name, sizeof(param_name), "%s=", var_names[i]);
> +               var = strstr(arcs_cmdline, param_name);
> +               if (!var)
> +                       continue;
> +
> +               memsize = memparse(var + strlen(param_name), NULL);
> +       }
> +
> +       /* if the user says there's more RAM than we thought, believe them */
> +       physical_memsize = max_t(unsigned long, physical_memsize, memsize);
> +
> +       /* append memory to the DT */
> +       mem_off = fdt_add_subnode(fdt, root_off, "memory");
> +       if (mem_off < 0)
> +               panic("Unable to add memory node to DT: %d", mem_off);
> +
> +       err = fdt_setprop_string(fdt, mem_off, "device_type", "memory");
> +       if (err)
> +               panic("Unable to set memory node device_type: %d", err);
> +
> +       mem_entries = gen_fdt_mem_array(mem_array, physical_memsize);
> +       err = fdt_setprop(fdt, mem_off, "reg", mem_array,
> +                         mem_entries * 2 * sizeof(mem_array[0]));
> +       if (err)
> +               panic("Unable to set memory regs property: %d", err);
> +
> +       mem_entries = gen_fdt_mem_array(mem_array, memsize);
> +       err = fdt_setprop(fdt, mem_off, "linux,usable-memory", mem_array,
> +                         mem_entries * 2 * sizeof(mem_array[0]));
> +       if (err)
> +               panic("Unable to set linux,usable-memory property: %d", err);
> +}
> +
>  static void __init remove_gic(void *fdt)
>  {
>         int err, gic_off, i8259_off, cpu_off;
> @@ -118,6 +221,7 @@ void __init *malta_dt_shim(void *fdt)
>         if (strncmp(compat, "mti,malta", len))
>                 return fdt;
>
> +       append_memory(fdt_buf, root_off);
>         remove_gic(fdt_buf);
>
>         err = fdt_pack(fdt_buf);
> diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
> index 831f583..5203241 100644
> --- a/arch/mips/mti-malta/malta-memory.c
> +++ b/arch/mips/mti-malta/malta-memory.c
> @@ -32,97 +32,9 @@ static void free_init_pages_eva_malta(void *begin, void *end)
>
>  void __init fw_meminit(void)
>  {
> -       char *memsize_str, *ememsize_str = NULL, *ptr;
> -       unsigned long memsize = 0, ememsize = 0;
> -       unsigned long kernel_start_phys, kernel_end_phys;
> -       static char cmdline[COMMAND_LINE_SIZE] __initdata;
>         bool eva = config_enabled(CONFIG_EVA);
> -       int tmp;
>
>         free_init_pages_eva = eva ? free_init_pages_eva_malta : NULL;
> -
> -       memsize_str = fw_getenv("memsize");
> -       if (memsize_str) {
> -               tmp = kstrtoul(memsize_str, 0, &memsize);
> -               if (tmp)
> -                       pr_warn("Failed to read the 'memsize' env variable.\n");
> -       }
> -       if (eva) {
> -       /* Look for ememsize for EVA */
> -               ememsize_str = fw_getenv("ememsize");
> -               if (ememsize_str) {
> -                       tmp = kstrtoul(ememsize_str, 0, &ememsize);
> -                       if (tmp)
> -                               pr_warn("Failed to read the 'ememsize' env variable.\n");
> -               }
> -       }
> -       if (!memsize && !ememsize) {
> -               pr_warn("memsize not set in YAMON, set to default (32Mb)\n");
> -               physical_memsize = 0x02000000;
> -       } else {
> -               if (memsize > (256 << 20)) { /* memsize should be capped to 256M */
> -                       pr_warn("Unsupported memsize value (0x%lx) detected! "
> -                               "Using 0x10000000 (256M) instead\n",
> -                               memsize);
> -                       memsize = 256 << 20;
> -               }
> -               /* If ememsize is set, then set physical_memsize to that */
> -               physical_memsize = ememsize ? : memsize;
> -       }
> -
> -#ifdef CONFIG_CPU_BIG_ENDIAN
> -       /* SOC-it swaps, or perhaps doesn't swap, when DMA'ing the last
> -          word of physical memory */
> -       physical_memsize -= PAGE_SIZE;
> -#endif
> -
> -       /* Check the command line for a memsize directive that overrides
> -          the physical/default amount */
> -       strcpy(cmdline, arcs_cmdline);
> -       ptr = strstr(cmdline, "memsize=");
> -       if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
> -               ptr = strstr(ptr, " memsize=");
> -       /* And now look for ememsize */
> -       if (eva) {
> -               ptr = strstr(cmdline, "ememsize=");
> -               if (ptr && (ptr != cmdline) && (*(ptr - 1) != ' '))
> -                       ptr = strstr(ptr, " ememsize=");
> -       }
> -
> -       if (ptr)
> -               memsize = memparse(ptr + 8 + (eva ? 1 : 0), &ptr);
> -       else
> -               memsize = physical_memsize;
> -
> -       add_memory_region(PHYS_OFFSET, 0x00001000, BOOT_MEM_RESERVED);
> -
> -       /*
> -        * YAMON may still be using the region of memory from 0x1000 to 0xfffff
> -        * if it has started secondary CPUs.
> -        */
> -       add_memory_region(PHYS_OFFSET + 0x00001000, 0x000ef000,
> -                         BOOT_MEM_ROM_DATA);
> -
> -       /*
> -        * The area 0x000f0000-0x000fffff is allocated for BIOS memory by the
> -        * south bridge and PCI access always forwarded to the ISA Bus and
> -        * BIOSCS# is always generated.
> -        * This mean that this area can't be used as DMA memory for PCI
> -        * devices.
> -        */
> -       add_memory_region(PHYS_OFFSET + 0x000f0000, 0x00010000,
> -                         BOOT_MEM_RESERVED);
> -
> -       /*
> -        * Reserve the memory used by kernel code, and allow the rest of RAM to
> -        * be used.
> -        */
> -       kernel_start_phys = PHYS_OFFSET + 0x00100000;
> -       kernel_end_phys = PHYS_OFFSET + CPHYSADDR(PFN_ALIGN(&_end));
> -       add_memory_region(kernel_start_phys, kernel_end_phys,
> -                         BOOT_MEM_RESERVED);
> -       add_memory_region(kernel_end_phys, memsize - kernel_end_phys,
> -                         BOOT_MEM_RAM);
>  }
>
>  void __init prom_free_prom_memory(void)
> --
> 2.4.1
>
