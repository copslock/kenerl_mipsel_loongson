Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 May 2017 15:31:47 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12576 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992126AbdEINblNPToX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 May 2017 15:31:41 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 53B254737A3A6
        for <linux-mips@linux-mips.org>; Tue,  9 May 2017 14:31:31 +0100 (IST)
Received: from [10.150.130.85] (10.150.130.85) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 9 May
 2017 14:31:34 +0100
Subject: Re: Loongson 3 kernel crashes with PAGE_EXTENSION and PAGE_POISONING
To:     <linux-mips@linux-mips.org>
References: <20170421231358.yszzvk3qzvbpxcrs@aurel32.net>
From:   James Cowgill <James.Cowgill@imgtec.com>
Message-ID: <e8c309b2-a24f-bf08-504d-185f2408f663@imgtec.com>
Date:   Tue, 9 May 2017 14:31:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170421231358.yszzvk3qzvbpxcrs@aurel32.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.85]
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

Hi,

On 22/04/17 00:13, Aurelien Jarno wrote:
> Hi all,
> 
> The Debian kernel recently enabled the PAGE_EXTENSION and PAGE_POISONING
> options. Unfortunately this causes a kernel crash very early during the
> boot on Loongson 3 machines:
[...]
> Adding page_poison=0 to the command line improves the things a bit, the
> kernel is able to boot, but crashes a bit later in different ways:
[...]
> Note that the malta and octeon flavours are not affected by this bug, so
> it looks like Loongson 3 specific. Any help to find the root cause would
> be appreciated.

I have investigated this a bit, although I haven't been able to get to
the very bottom of it.

The PAGE_EXTENSION option is a red herring. The bug actually occurs
whenever a very large amount of .bss is used by the kernel. The loongson
kernel allocates this .bss because it enables SPARSEMEM and
SPARSEMEM_STATIC which has this documented side effect:

(From mm/Kconfig SPARSEMEM_STATIC)
> # SPARSEMEM_EXTREME (which is the default) does some bootmem
> # allocations when memory_present() is called.  If this cannot
> # be done on your architecture, select this option.  However,
> # statically allocating the mem_section[] array can potentially
> # consume vast quantities of .bss, so be careful.

On Loongson about 16M of .bss is allocated for the mem_section array.
When PAGE_EXTENSION is enabled, this doubles to 32M.

Having a large .bss shifts the location where the dentry cache is
allocated from to a region containing 0x0B020000. When the Loongson
boots, something early on in the boot process writes to this physical
address and places some garbage there which later crashes the kernel
(since it's in the middle of the dentry cache). Unfortunately I have no
idea what might be causing this, but if I hack arch/mips/kernel/setup.c
to reserve 0x0B020000 - 0x0B040000 then the crashes disappear.

The second workaround I have is to enable NUMA and disable
SPARSEMEM_STATIC. This prevents the large .bss and I think it's safe
because loongson64 uses some alternative memory initialization code when
NUMA is enabled and only calls memory_present at the end. However, I'm
not sure if it works on multi-node Loongsons (like the 3B) since I don't
have any to test it on.

Hopefully that helps a little.

James
