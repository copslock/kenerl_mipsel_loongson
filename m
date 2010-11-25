Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Nov 2010 17:18:30 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:62937 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491941Ab0KYQSZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Nov 2010 17:18:25 +0100
Received: by iwn36 with SMTP id 36so222193iwn.36
        for <linux-mips@linux-mips.org>; Thu, 25 Nov 2010 08:18:23 -0800 (PST)
Received: by 10.231.12.11 with SMTP id v11mr591968ibv.13.1290701900036; Thu,
 25 Nov 2010 08:18:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.231.196.10 with HTTP; Thu, 25 Nov 2010 08:17:59 -0800 (PST)
In-Reply-To: <1290692075.689.20.camel@concordia>
References: <1290607413.12457.44.camel@concordia> <1290692075.689.20.camel@concordia>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Thu, 25 Nov 2010 09:17:59 -0700
X-Google-Sender-Auth: STLccsBRy_JQO_-jBtMTxeJsW9s
Message-ID: <AANLkTiknyKi1pzvUP2WnasudZwH27-a0FxCX0BSHBdQp@mail.gmail.com>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
To:     michael@ellerman.id.au
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        microblaze-uclinux@itee.uq.edu.au,
        devicetree-discuss@lists.ozlabs.org,
        linuxppc-dev list <linuxppc-dev@ozlabs.org>,
        sparclinux@vger.kernel.org,
        Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Thu, Nov 25, 2010 at 6:34 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Thu, 2010-11-25 at 01:03 +1100, Michael Ellerman wrote:
>> Hi all,
>>
>> There were some murmurings on IRC last week about renaming the of_*()
>> routines.
> ...
>> The thinking is that on many platforms that use the of_() routines
>> OpenFirmware is not involved at all, this is true even on many powerpc
>> platforms. Also for folks who don't know the OpenFirmware connection
>> it reads as "of", as in "a can of worms".
> ...
>> So I'm hoping people with either say "YES this is a great idea", or "NO
>> this is stupid".
>
> I'm still hoping, but so far it seems most people have got better things
> to do, and of those that do have an opinion the balance is slightly
> positive.

I assume you'll be also publishing the script that you use for
generating the massive patch.  I expect that there will be a few
iterations of running the rename script to convert over all the
stragglers.  It should also be negotiated with Linus about when this
patch should get applied.  I do NOT want to cause massive merge pain
during the merge window.

Andrew/Linus: Before Michael proceeds too far with this rename, are
you okay with a mass rename of the device tree functions from of_* to
dt_*?  Nobody likes the ambiguous 'of_' prefix ("of?  of what?"), but
to fix it means large cross-tree patches and potential merge
conflicts.

> So here's a first cut of a patch to add the new names. I've not touched
> of_platform because that is supposed to go away. That will lead to some
> odd looking code in the interim, but I think is the right approach.

I would split it up into separate dt*.h files, one for each of*.h file
so that the #include lines can be changed in the C code at the same
time.  Each dt*.h file would include it's of*.h counterpart.  Then
after the code is renamed, and a release or two has passed to catch
the majority of users, the old definitions can be moved into the dt*.h
files.

However, it may be better to move and rename the definitions
immediately, and leave "#define of_*  dt_*" macros in the old of*.h
files which can be removed with a simple patch after all the users are
converted.  That would have a smaller impact in the cleanup stage.

> Most of these are straight renames, but some have changed more
> substantially. The routines for the flat tree have all become fdt_foo().
> I'd be inclined to drop "early_init" from them too, because they're
> basically all about early init, but Grant said he'd prefer not to I
> think. I've also renamed the flat tree tag constants to match libfdt.

It is all about early init now in Linus' tree, but Stephen
Neuendorffer has patches that use the fdt code at driver probe time
for parsing device tree fragments that describe an FPGA add-in board.

>
> I've left for_each_child_of_node(), because I read it as "of", but maybe
> it's "OF"?

hahaha!  I never considered that it might be OF, but now I probably
won't be able to help but read it that way!  I like Geert's suggestion
of dt_for_each_child_node

g.

>
> cheers
>
> #ifndef __DT_H
> #define __DT_H
>
> /* include/linux/device.h */
> #define dt_match_table � � � � � � � � �of_match_table
> #define dt_node � � � � � � � � � � � � of_node

This could be very messy.  I've nervous about using #define to rename
structure members.  You'll need to check that any structure members
that use the same name as a global symbol are handled appropriately.

>
> /* include/linux/mod_devicetable.h */
> #define dt_device_id � � � � � � � � � �of_device_id
>
> /* include/linux/of.h */
> #define dt_node_to_nid � � � � � � � � �of_node_to_nid
> #define dt_chosen � � � � � � � � � � � of_chosen
> #define dt_node_is_root � � � � � � � � of_node_is_root
> #define dt_node_check_flag � � � � � � �of_node_check_flag
> #define dt_node_set_flag � � � � � � � �of_node_set_flag
> #define dt_find_all_nodes � � � � � � � of_find_all_nodes
> #define dt_node_get � � � � � � � � � � of_node_get
> #define dt_node_put � � � � � � � � � � of_node_put
> #define dt_read_number � � � � � � � � �of_read_number
> #define dt_read_ulong � � � � � � � � � of_read_ulong
> #define dt_find_node_by_name � � � � � �of_find_node_by_name
> #define dt_find_node_by_type � � � � � �of_find_node_by_type
> #define dt_find_compatible_node � � � � of_find_compatible_node
> #define dt_find_matching_node � � � � � of_find_matching_node
> #define dt_find_node_by_path � � � � � �of_find_node_by_path
> #define dt_find_node_by_phandle � � � � of_find_node_by_phandle
> #define dt_get_parent � � � � � � � � � of_get_parent
> #define dt_get_next_parent � � � � � � �of_get_next_parent
> #define dt_get_next_child � � � � � � � of_get_next_child
> #define dt_find_node_with_property � � �of_find_node_with_property
> #define dt_device_is_compatible � � � � of_device_is_compatible
> #define dt_device_is_available � � � � �of_device_is_available
> #define dt_get_property � � � � � � � � of_get_property
> #define dt_n_addr_cells � � � � � � � � of_n_addr_cells
> #define dt_n_size_cells � � � � � � � � of_n_size_cells
> #define dt_match_node � � � � � � � � � of_match_node
> #define dt_modalias_node � � � � � � � �of_modalias_node
> #define dt_parse_phandle � � � � � � � �of_parse_phandle
> #define dt_parse_phandles_with_args � � of_parse_phandles_with_args
> #define dt_machine_is_compatible � � � �of_machine_is_compatible
> #define dt_attach_node � � � � � � � � �of_attach_node
> #define dt_detach_node � � � � � � � � �of_detach_node
> #define dt_find_property � � � � � � � �of_find_property
>
> /* include/linux/of_fdt.h */
> #define fdt_find_string � � � � � � � � find_flat_dt_string
> #define fdt_scan � � � � � � � � � � � �of_scan_flat_dt
> #define fdt_get_prop � � � � � � � � � �of_get_flat_dt_prop
> #define fdt_is_compatible � � � � � � � of_flat_dt_is_compatible
> #define fdt_get_root � � � � � � � � � �of_get_flat_dt_root
> #define fdt_early_init_scan_chosen � � �early_init_dt_scan_chosen
> #define fdt_early_init_check_for_initrd early_init_dt_check_for_initrd
> #define fdt_early_init_scan_memory � � �early_init_dt_scan_memory
> #define fdt_early_init_add_memory_arch �early_init_dt_add_memory_arch
> #define fdt_early_init_alloc_memory_arch early_init_dt_alloc_memory_arch
> #define fdt_early_init_setup_initrd_arch early_init_dt_setup_initrd_arch
> #define fdt_early_init_scan_root � � � �early_init_dt_scan_root
> #define fdt_unflatten � � � � � � � � � unflatten_device_tree
> #define fdt_early_init � � � � � � � � �early_init_devtree
> #define FDT_MAGIC � � � � � � � � � � � OF_DT_HEADER
> #define FDT_BEGIN_NODE � � � � � � � � �OF_DT_BEGIN_NODE
> #define FDT_END_NODE � � � � � � � � � �OF_DT_END_NODE
> #define FDT_PROP � � � � � � � � � � � �OF_DT_PROP
> #define FDT_NOP � � � � � � � � � � � � OF_DT_NOP
> #define FDT_END � � � � � � � � � � � � OF_DT_END
> #define FDT_VERSION � � � � � � � � � � OF_DT_VERSION
>
> /* include/linux/of_address.h */
> #define dt_translate_address � � � � � �of_translate_address
> #define dt_address_to_resource � � � � �of_address_to_resource
> #define dt_iomap � � � � � � � � � � � �of_iomap
> #define dt_get_address � � � � � � � � �of_get_address
> #define dt_get_pci_address � � � � � � �of_get_pci_address
> #define dt_pci_address_to_resource � � �of_pci_address_to_resource
>
> /* include/linux/of_device.h */
> #define dt_match_device � � � � � � � � of_match_device
> #define dt_device_make_bus_id � � � � � of_device_make_bus_id
> #define dt_driver_match_device � � � � �of_driver_match_device
> #define dt_dev_get � � � � � � � � � � �of_dev_get
> #define dt_dev_put � � � � � � � � � � �of_dev_put
> #define dt_device_add � � � � � � � � � of_device_add
> #define dt_device_register � � � � � � �of_device_register
> #define dt_device_unregister � � � � � �of_device_unregister
> #define dt_device_get_modalias � � � � �of_device_get_modalias
> #define dt_device_uevent � � � � � � � �of_device_uevent
> #define dt_device_node_put � � � � � � �of_device_node_put
>
> /* include/linux/of_irq.h */
> #define dt_irq � � � � � � � � � � � � �of_irq
> #define dt_irq_parse_and_map � � � � � �irq_of_parse_and_map
> #define dt_irq_workarounds � � � � � � �of_irq_workarounds
> #define dt_irq_dflt_pic � � � � � � � � of_irq_dflt_pic
> #define dt_irq_map_oldworld � � � � � � of_irq_map_oldworld
> #define dt_irq_map_raw � � � � � � � � �of_irq_map_raw
> #define dt_irq_map_one � � � � � � � � �of_irq_map_one
> #define dt_irq_create_mapping � � � � � irq_create_of_mapping
> #define dt_irq_to_resource � � � � � � �of_irq_to_resource
> #define dt_irq_count � � � � � � � � � �of_irq_count
> #define dt_irq_to_resource_table � � � �of_irq_to_resource_table
> #define DT_IRQ_MAX_SPEC � � � � � � � � OF_MAX_IRQ_SPEC
> #define DT_IRQ_QUIRK_OLDWORLD_MAC � � � OF_IMAP_OLDWORLD_MAC
> #define DT_IRQ_QUIRK_NO_PHANDLE � � � � OF_IMAP_NO_PHANDLE
>
> /* include/linux/of_mdio.h */
> #define dt_mdiobus_register � � � � � � of_mdiobus_register
> #define dt_phy_find_device � � � � � � �of_phy_find_device
> #define dt_phy_connect � � � � � � � � �of_phy_connect
> #define dt_phy_connect_fixed_link � � � of_phy_connect_fixed_link
>
> /* include/linux/of_spi.h */
> #define dt_register_spi_devices � � � � of_register_spi_devices
>
> /* include/linux/of_gpio.h */
> #define dt_gpio_flags � � � � � � � � � of_gpio_flags
> #define DT_GPIO_ACTIVE_LOW � � � � � � �OF_GPIO_ACTIVE_LOW
> #define dt_mm_gpio_chip � � � � � � � � of_mm_gpio_chip
> #define to_dt_mm_gpio_chip � � � � � � �to_of_mm_gpio_chip
> #define dt_get_gpio_flags � � � � � � � of_get_gpio_flags
> #define dt_gpio_count � � � � � � � � � of_gpio_count
> #define dt_mm_gpiochip_add � � � � � � �of_mm_gpiochip_add
> #define dt_gpiochip_add � � � � � � � � of_gpiochip_add
> #define dt_gpiochip_remove � � � � � � �of_gpiochip_remove
> #define dt_node_to_gpiochip � � � � � � of_node_to_gpiochip
> #define dt_get_gpio � � � � � � � � � � of_get_gpio
>
> /* include/linux/dt_i2c.h */
> #define dt_i2c_register_devices � � � � of_i2c_register_devices
> #define dt_find_i2c_device_by_node � � �of_find_i2c_device_by_node
>
> #endif /* __DT_H */
>
>
>
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
