Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9TJeJw04225
	for linux-mips-outgoing; Mon, 29 Oct 2001 11:40:19 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9TJdf004217
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 11:39:41 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA02626
	for <linux-mips@oss.sgi.com>; Mon, 29 Oct 2001 11:39:36 -0800 (PST)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f9TJPwB27118;
	Mon, 29 Oct 2001 11:25:58 -0800
Message-ID: <3BDDACD2.7121F905@mvista.com>
Date: Mon, 29 Oct 2001 11:24:02 -0800
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Bradley D. LaRonde" <brad@ltc.com>
CC: linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: PATCH: pci_auto bridge support
References: <20011026210746.A20395@dev1.ltc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Brad,

Have you considered embedding "topbus" argument into hose structure?  That
sounds like potentially better solution.



"Bradley D. LaRonde" wrote:
> 
> 2001-10-26  Bradley D. LaRonde <brad@ltc.com>
> 
> * PCI bridge support.  See change log entry below.
> 
> --- arch/mips/kernel/pci_auto.c 2001/08/18 06:21:53     1.1
> +++ arch/mips/kernel/pci_auto.c 2001/10/27 01:01:21
> @@ -4,6 +4,7 @@
>   * Author: Matt Porter <mporter@mvista.com>
>   *
>   * Copyright 2000, 2001 MontaVista Software Inc.
> + * Copyright 2001 Bradley D. LaRonde <brad@ltc.com>
>   *
>   * This program is free software; you can redistribute  it and/or modify it
>   * under  the terms of  the GNU General  Public License as published by the
> @@ -19,6 +20,15 @@
>   * . change most int to u32.
>   *
>   * Further modified to include it as mips generic code, ppopov@mvista.com.
> + *
> + * 2001-10-26  Bradley D. LaRonde <brad@ltc.com>
> + * - Add a top_bus argument to the "early config" functions so that
> + *   they can set a fake parent bus pointer to convince the underlying
> + *   pci ops to use type 1 configuration for sub busses.
> + * - Set bridge base and limit registers correctly.
> + * - Align io and memory base properly before and after bridge setup.
> + * - Don't fall through to pci_setup_bars for bridge.
> + * - Reformat the debug output to look more like lspci's output.
>   */
> 
>  #include <linux/kernel.h>
> @@ -34,14 +44,47 @@
>  #else
>  #define        DBG(x...)
>  #endif
> +
> +/*
> + * These functions are used early on before PCI scanning is done
> + * and all of the pci_dev and pci_bus structures have been created.
> + */
> +static struct pci_dev *fake_pci_dev(struct pci_channel *hose,
> +       int top_bus, int busnr, int devfn)
> +{
> +       static struct pci_dev dev;
> +       static struct pci_bus bus;
> +
> +       dev.bus = &bus;
> +       dev.sysdata = hose;
> +       dev.devfn = devfn;
> +       bus.number = busnr;
> +       bus.ops = hose->pci_ops;
> +
> +       if(busnr != top_bus)
> +               /* Fake a parent bus structure. */
> +               bus.parent = &bus;
> +       else
> +               bus.parent = NULL;
> +
> +       return &dev;
> +}
> +
> +#define EARLY_PCI_OP(rw, size, type)                                   \
> +int early_##rw##_config_##size(struct pci_channel *hose,               \
> +       int top_bus, int bus, int devfn, int offset, type value)        \
> +{                                                                      \
> +       return pci_##rw##_config_##size(                                \
> +               fake_pci_dev(hose, top_bus, bus, devfn),                \
> +               offset, value);                                         \
> +}
> 
> -/* These are used for config access before all the PCI probing has been done. */
> -int early_read_config_byte(struct pci_channel *hose, int bus, int dev_fn, int where, u8 *val);
> -int early_read_config_word(struct pci_channel *hose, int bus, int dev_fn, int where, u16 *val);
> -int early_read_config_dword(struct pci_channel *hose, int bus, int dev_fn, int where, u32 *val);
> -int early_write_config_byte(struct pci_channel *hose, int bus, int dev_fn, int where, u8 val);
> -int early_write_config_word(struct pci_channel *hose, int bus, int dev_fn, int where, u16 val);
> -int early_write_config_dword(struct pci_channel *hose, int bus, int dev_fn, int where, u32 val);
> +EARLY_PCI_OP(read, byte, u8 *)
> +EARLY_PCI_OP(read, word, u16 *)
> +EARLY_PCI_OP(read, dword, u32 *)
> +EARLY_PCI_OP(write, byte, u8)
> +EARLY_PCI_OP(write, word, u16)
> +EARLY_PCI_OP(write, dword, u32)
> 
>  static u32 pciauto_lower_iospc;
>  static u32 pciauto_upper_iospc;
> @@ -51,6 +94,7 @@
> 
>  void __init
>  pciauto_setup_bars(struct pci_channel *hose,
> +                  int top_bus,
>                    int current_bus,
>                    int pci_devfn)
>  {
> @@ -60,17 +104,14 @@
>         u32 * lower_limit;
>         int found_mem64 = 0;
> 
> -       DBG("PCI Autoconfig: Found Bus %d, Device %d, Function %d\n",
> -           current_bus, PCI_SLOT(pci_devfn), PCI_FUNC(pci_devfn) );
> -
>         for (bar = PCI_BASE_ADDRESS_0; bar <= PCI_BASE_ADDRESS_5; bar+=4) {
>                 /* Tickle the BAR and get the response */
> -               early_write_config_dword(hose,
> +               early_write_config_dword(hose, top_bus,
>                                          current_bus,
>                                          pci_devfn,
>                                          bar,
>                                          0xffffffff);
> -               early_read_config_dword(hose,
> +               early_read_config_dword(hose, top_bus,
>                                         current_bus,
>                                         pci_devfn,
>                                         bar,
> @@ -80,12 +121,20 @@
>                 if (!bar_response)
>                         continue;
> 
> +               /*
> +                * Workaround for a BAR that doesn't use its upper word,
> +                * like the ALi 1535D+ PCI DC-97 Controller Modem (M5457).
> +                * bdl <brad@ltc.com>
> +                */
> +               if (!(bar_response & 0xffff0000))
> +                       bar_response |= 0xffff0000;
> +
>                 /* Check the BAR type and set our address mask */
>                 if (bar_response & PCI_BASE_ADDRESS_SPACE) {
>                         addr_mask = PCI_BASE_ADDRESS_IO_MASK;
>                         upper_limit = &pciauto_upper_iospc;
>                         lower_limit = &pciauto_lower_iospc;
> -                       DBG("PCI Autoconfig: BAR %d, I/O, ", bar_nr);
> +                       DBG("        I/O");
>                 } else {
>                         if ((bar_response & PCI_BASE_ADDRESS_MEM_TYPE_MASK) ==
>                             PCI_BASE_ADDRESS_MEM_TYPE_64)
> @@ -94,7 +143,7 @@
>                         addr_mask = PCI_BASE_ADDRESS_MEM_MASK;
>                         upper_limit = &pciauto_upper_memspc;
>                         lower_limit = &pciauto_lower_memspc;
> -                       DBG("PCI Autoconfig: BAR %d, Mem, ", bar_nr);
> +                       DBG("        Mem");
>                 }
> 
>                 /* Calculate requested size */
> @@ -104,7 +153,7 @@
>                 bar_value = ((*lower_limit - 1) & ~(bar_size - 1)) + bar_size;
> 
>                 /* Write it out and update our limit */
> -               early_write_config_dword(hose, current_bus, pci_devfn,
> +               early_write_config_dword(hose, top_bus, current_bus, pci_devfn,
>                                          bar, bar_value);
> 
>                 *lower_limit = bar_value + bar_size;
> @@ -116,97 +165,99 @@
>                  */
>                 if (found_mem64) {
>                         bar += 4;
> -                       early_write_config_dword(hose,
> +                       early_write_config_dword(hose, top_bus,
>                                                  current_bus,
>                                                  pci_devfn,
>                                                  bar,
>                                                  0x00000000);
>                 }
> 
> -               bar_nr++;
> +               DBG(" at 0x%.8x [size=0x%x]\n", bar_value, bar_size);
> 
> -               DBG("size=0x%x, address=0x%x\n",
> -                   bar_size, bar_value);
> +               bar_nr++;
>         }
> 
>  }
> 
>  void __init
>  pciauto_prescan_setup_bridge(struct pci_channel *hose,
> +                            int top_bus,
>                              int current_bus,
>                              int pci_devfn,
>                              int sub_bus)
>  {
> -       int cmdstat;
> -
>         /* Configure bus number registers */
> -       early_write_config_byte(hose, current_bus, pci_devfn,
> +       early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
>                                 PCI_PRIMARY_BUS, current_bus);
> -       early_write_config_byte(hose, current_bus, pci_devfn,
> +       early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
>                                 PCI_SECONDARY_BUS, sub_bus + 1);
> -       early_write_config_byte(hose, current_bus, pci_devfn,
> +       early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
>                                 PCI_SUBORDINATE_BUS, 0xff);
> -
> -       /* Round memory allocator to 1MB boundary */
> -       pciauto_upper_memspc &= ~(0x100000 - 1);
> 
> -       /* Round I/O allocator to 4KB boundary */
> -       pciauto_upper_iospc &= ~(0x1000 - 1);
> +       /* Align memory and I/O to 1MB and 4KB boundaries. */
> +       pciauto_lower_memspc = (pciauto_lower_memspc + (0x100000 - 1))
> +               & ~(0x100000 - 1);
> +       pciauto_lower_iospc = (pciauto_lower_iospc + (0x1000 - 1))
> +               & ~(0x1000 - 1);
> +
> +       /* Set base (lower limit) of address range behind bridge. */
> +       early_write_config_word(hose, top_bus, current_bus, pci_devfn,
> +               PCI_MEMORY_BASE, pciauto_lower_memspc >> 16);
> +       early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
> +               PCI_IO_BASE, (pciauto_lower_iospc & 0x0000f000) >> 8);
> +       early_write_config_word(hose, top_bus, current_bus, pci_devfn,
> +               PCI_IO_BASE_UPPER16, pciauto_lower_iospc >> 16);
> 
> -       /* Set up memory and I/O filter limits, assume 32-bit I/O space */
> -       early_write_config_word(hose, current_bus, pci_devfn, PCI_MEMORY_LIMIT,
> -                               ((pciauto_upper_memspc - 1) & 0xfff00000) >> 16);
> -       early_write_config_byte(hose, current_bus, pci_devfn, PCI_IO_LIMIT,
> -                               ((pciauto_upper_iospc - 1) & 0x0000f000) >> 8);
> -       early_write_config_word(hose, current_bus, pci_devfn,
> -                               PCI_IO_LIMIT_UPPER16,
> -                               ((pciauto_upper_iospc - 1) & 0xffff0000) >> 16);
> -
>         /* We don't support prefetchable memory for now, so disable */
> -       early_write_config_word(hose, current_bus, pci_devfn,
> -                               PCI_PREF_MEMORY_BASE, 0x1000);
> -       early_write_config_word(hose, current_bus, pci_devfn,
> -                               PCI_PREF_MEMORY_LIMIT, 0x1000);
> -
> -       /* Enable memory and I/O accesses, enable bus master */
> -       early_read_config_dword(hose, current_bus, pci_devfn, PCI_COMMAND,
> -                               &cmdstat);
> -       early_write_config_dword(hose, current_bus, pci_devfn, PCI_COMMAND,
> -                                cmdstat | PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
> -                                PCI_COMMAND_MASTER);
> +       early_write_config_word(hose, top_bus, current_bus, pci_devfn,
> +                               PCI_PREF_MEMORY_BASE, 0);
> +       early_write_config_word(hose, top_bus, current_bus, pci_devfn,
> +                               PCI_PREF_MEMORY_LIMIT, 0);
>  }
> 
>  void __init
>  pciauto_postscan_setup_bridge(struct pci_channel *hose,
> +                             int top_bus,
>                               int current_bus,
>                               int pci_devfn,
>                               int sub_bus)
>  {
> +       u32 temp;
> +
>         /* Configure bus number registers */
> -       early_write_config_byte(hose, current_bus, pci_devfn,
> +       early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
>                                 PCI_SUBORDINATE_BUS, sub_bus);
> 
> -       /* Round memory allocator to 1MB boundary */
> -       pciauto_upper_memspc &= ~(0x100000 - 1);
> -       early_write_config_word(hose, current_bus, pci_devfn, PCI_MEMORY_BASE,
> -                               pciauto_upper_memspc >> 16);
> -
> -       /* Round I/O allocator to 4KB boundary */
> -       pciauto_upper_iospc &= ~(0x1000 - 1);
> -       early_write_config_byte(hose, current_bus, pci_devfn, PCI_IO_BASE,
> -                               (pciauto_upper_iospc & 0x0000f000) >> 8);
> -       early_write_config_word(hose, current_bus, pci_devfn,
> -                               PCI_IO_BASE_UPPER16, pciauto_upper_iospc >> 16);
> +       /* Set upper limit of address range behind bridge. */
> +       early_write_config_word(hose, top_bus, current_bus, pci_devfn,
> +               PCI_MEMORY_LIMIT, pciauto_lower_memspc >> 16);
> +       early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
> +               PCI_IO_LIMIT, (pciauto_lower_iospc & 0x0000f000) >> 8);
> +       early_write_config_word(hose, top_bus, current_bus, pci_devfn,
> +               PCI_IO_LIMIT_UPPER16, pciauto_lower_iospc >> 16);
> +
> +       /* Align memory and I/O to 1MB and 4KB boundaries. */
> +       pciauto_lower_memspc = (pciauto_lower_memspc + (0x100000 - 1))
> +               & ~(0x100000 - 1);
> +       pciauto_lower_iospc = (pciauto_lower_iospc + (0x1000 - 1))
> +               & ~(0x1000 - 1);
> +
> +       /* Enable memory and I/O accesses, enable bus master */
> +       early_read_config_dword(hose, top_bus, current_bus, pci_devfn,
> +               PCI_COMMAND, &temp);
> +       early_write_config_dword(hose, top_bus, current_bus, pci_devfn,
> +               PCI_COMMAND, temp | PCI_COMMAND_IO | PCI_COMMAND_MEMORY
> +               | PCI_COMMAND_MASTER);
>  }
> 
>  #define      PCIAUTO_IDE_MODE_MASK           0x05
> 
>  int __init
> -pciauto_bus_scan(struct pci_channel *hose, int current_bus)
> +pciauto_bus_scan(struct pci_channel *hose, int top_bus, int current_bus)
>  {
>         int sub_bus;
>         u32 pci_devfn, pci_class, cmdstat, found_multi=0;
> -       unsigned short vid;
> +       unsigned short vid, did;
>         unsigned char header_type;
>         int devfn_start = 0;
>         int devfn_stop = 0xff;
> @@ -223,54 +274,70 @@
>                 if (PCI_FUNC(pci_devfn) && !found_multi)
>                         continue;
> 
> -               early_read_config_byte(hose, current_bus, pci_devfn,
> +               early_read_config_word(hose, top_bus, current_bus, pci_devfn,
> +                                      PCI_VENDOR_ID, &vid);
> +
> +               if (vid == 0xffff) continue;
> +
> +               early_read_config_byte(hose, top_bus, current_bus, pci_devfn,
>                                        PCI_HEADER_TYPE, &header_type);
> 
>                 if (!PCI_FUNC(pci_devfn))
>                         found_multi = header_type & 0x80;
> 
> -               early_read_config_word(hose, current_bus, pci_devfn,
> -                                      PCI_VENDOR_ID, &vid);
> +               early_read_config_word(hose, top_bus, current_bus, pci_devfn,
> +                                      PCI_DEVICE_ID, &did);
> 
> -               if (vid == 0xffff) continue;
> -
> -               early_read_config_dword(hose, current_bus, pci_devfn,
> +               early_read_config_dword(hose, top_bus, current_bus, pci_devfn,
>                                         PCI_CLASS_REVISION, &pci_class);
> +
> +               DBG("%.2x:%.2x.%x Class %.4x: %.4x:%.4x",
> +                       current_bus, PCI_SLOT(pci_devfn), PCI_FUNC(pci_devfn),
> +                       pci_class >> 16, vid, did);
> +               if (pci_class & 0xff)
> +                       DBG(" (rev %.2x)", pci_class & 0xff);
> +               DBG("\n");
> +
>                 if ((pci_class >> 16) == PCI_CLASS_BRIDGE_PCI) {
> -                       DBG("PCI Autoconfig: Found P2P bridge, device %d\n", PCI_SLOT(pci_devfn));
> -                       pciauto_prescan_setup_bridge(hose, current_bus,
> +                       DBG("        Bridge: primary=%.2x, secondary=%.2x\n",
> +                               current_bus, sub_bus + 1);
> +                       pciauto_prescan_setup_bridge(hose, top_bus, current_bus,
>                                                      pci_devfn, sub_bus);
> -                       sub_bus = pciauto_bus_scan(hose, sub_bus+1);
> -                       pciauto_postscan_setup_bridge(hose, current_bus,
> +                       DBG("Scanning sub bus %.2x, I/O 0x%.8x, Mem 0x%.8x\n",
> +                               sub_bus + 1,
> +                               pciauto_lower_iospc, pciauto_lower_memspc);
> +                       sub_bus = pciauto_bus_scan(hose, top_bus, sub_bus+1);
> +                       DBG("Back to bus %.2x\n", current_bus);
> +                       pciauto_postscan_setup_bridge(hose, top_bus, current_bus,
>                                                       pci_devfn, sub_bus);
> -
> +                       continue;
>                 } else if ((pci_class >> 16) == PCI_CLASS_STORAGE_IDE) {
> 
>                         unsigned char prg_iface;
> 
> -                       early_read_config_byte(hose, current_bus, pci_devfn,
> -                                              PCI_CLASS_PROG, &prg_iface);
> +                       early_read_config_byte(hose, top_bus, current_bus,
> +                               pci_devfn, PCI_CLASS_PROG, &prg_iface);
>                         if (!(prg_iface & PCIAUTO_IDE_MODE_MASK)) {
> -                               DBG("PCI Autoconfig: Skipping legacy mode IDE controller\n");
> +                               DBG("Skipping legacy mode IDE controller\n");
>                                 continue;
>                         }
>                 }
> 
> -               /*
> +               /*
>                  * Found a peripheral, enable some standard
>                  * settings
>                  */
> -               early_read_config_dword(hose, current_bus, pci_devfn,
> +               early_read_config_dword(hose, top_bus, current_bus, pci_devfn,
>                                         PCI_COMMAND, &cmdstat);
> -               early_write_config_dword(hose, current_bus, pci_devfn,
> +               early_write_config_dword(hose, top_bus, current_bus, pci_devfn,
>                                          PCI_COMMAND, cmdstat | PCI_COMMAND_IO |
>                                          PCI_COMMAND_MEMORY |
>                                          PCI_COMMAND_MASTER);
> -               early_write_config_byte(hose, current_bus, pci_devfn,
> +               early_write_config_byte(hose, top_bus, current_bus, pci_devfn,
>                                         PCI_LATENCY_TIMER, 0x80);
> 
>                 /* Allocate PCI I/O and/or memory space */
> -               pciauto_setup_bars(hose, current_bus, pci_devfn);
> +               pciauto_setup_bars(hose, top_bus, current_bus, pci_devfn);
>         }
>         return sub_bus;
>  }
> @@ -283,41 +350,9 @@
>         pciauto_upper_iospc = hose->io_resource->end + 1;
>         pciauto_lower_memspc = hose->mem_resource->start;
>         pciauto_upper_memspc = hose->mem_resource->end + 1;
> +       DBG("Autoconfig PCI channel 0x%p\n", hose);
> +       DBG("Scanning bus %.2x, I/O 0x%.8x, Mem 0x%.8x\n",
> +               busno, pciauto_lower_iospc, pciauto_lower_memspc);
> 
> -       return pciauto_bus_scan(hose, busno);
> +       return pciauto_bus_scan(hose, busno, busno);
>  }
> -
> -
> -/*
> - * These functions are used early on before PCI scanning is done
> - * and all of the pci_dev and pci_bus structures have been created.
> - */
> -static struct pci_dev *fake_pci_dev(struct pci_channel *hose, int busnr,
> -                                    int devfn)
> -{
> -       static struct pci_dev dev;
> -       static struct pci_bus bus;
> -
> -       dev.bus = &bus;
> -       dev.sysdata = hose;
> -       dev.devfn = devfn;
> -       bus.number = busnr;
> -       bus.ops = hose->pci_ops;
> -
> -       return &dev;
> -}
> -
> -#define EARLY_PCI_OP(rw, size, type)                                   \
> -int early_##rw##_config_##size(struct pci_channel *hose, int bus,      \
> -                               int devfn, int offset, type value)      \
> -{                                                                      \
> -       return pci_##rw##_config_##size(fake_pci_dev(hose, bus, devfn), \
> -                                       offset, value);                 \
> -}
> -
> -EARLY_PCI_OP(read, byte, u8 *)
> -EARLY_PCI_OP(read, word, u16 *)
> -EARLY_PCI_OP(read, dword, u32 *)
> -EARLY_PCI_OP(write, byte, u8)
> -EARLY_PCI_OP(write, word, u16)
> -EARLY_PCI_OP(write, dword, u32)
