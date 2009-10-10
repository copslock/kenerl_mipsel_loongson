Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Oct 2009 21:20:09 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:64389 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493045AbZJJTUC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 Oct 2009 21:20:02 +0200
Received: by pzk35 with SMTP id 35so2720495pzk.22
        for <multiple recipients>; Sat, 10 Oct 2009 12:19:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=bMzPtqSoB/bnDMZ4FKg152rQicC264ncbq6c+BIE8P4=;
        b=kY79MMg2tQA6aZ7FHtDTYyq0AiyiM/GJN2IoD+C5kttVvlCCPLlQrIslYEc8cIX999
         v34rSRNPzjLA+587gKlltyaczxMotwbLfddPhv8zBRA77g3HnzsPN/y5xXo4TNUjUYyR
         YA7O4iWa84fJFVakuHWb+ucoPKyAKk3gy4fy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=cKDsczQdIXPbybITjP8Bvbh1hH38PhQ6aoyofBSH+VtD50vSVLCk8C5meSZw78WSoQ
         IterPX0mQ8wwBMt6Hh/Gc7xUIXQdSSqYUa14EDg6jKXwUcQG1dI31/x2i/PlRhMWuSpD
         ZvkpK3R5iP2odzHNeDxurDTLouPUQM0Fq7aEQ=
Received: by 10.115.65.11 with SMTP id s11mr5934689wak.170.1255202393921;
        Sat, 10 Oct 2009 12:19:53 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1588790pzk.3.2009.10.10.12.19.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Oct 2009 12:19:52 -0700 (PDT)
Subject: Re: [PATCH -v1] MIPS: fix pfn_valid() for FLATMEM
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips <linux-mips@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	rjw@sisk.pl, Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Pavel Machek <pavel@ucw.cz>, yanh@lemote.com,
	Hongbing Hu <huhb@lemote.com>
In-Reply-To: <1255185520.6883.28.camel@falcon>
References: <1255104936-14921-1-git-send-email-wuzhangjin@gmail.com>
	 <1255185520.6883.28.camel@falcon>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sun, 11 Oct 2009 03:19:47 +0800
Message-Id: <1255202387.20765.23.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-10-10 at 22:38 +0800, Wu Zhangjin wrote:
> Hello, all
> 
> Please ignore This Patch, And I have tried to register_nosave_region
> from 20000000 to 7fffffff(include the reserved page and pci memory
> space), it will make the wifi driver not work(read/write_nic_word fail,
> DMA relative, something bad with pci memory space), So I choose the last
> choice, come back to the oldest patch I have sent: "Hibernation: only
> save pages in system ram".
> 
Sorry to disturb you again :-)

Just talked with another guy who are also playing with the Hibernation
support of Yeeloong laptop, he told me the bug existed before my
pfn_valid() patch, that is:

After Hibernation and resuming it, the rtl8187b wifi will not work, 

...
[  338.172000] usb 1-1: reset high speed USB device using ehci_hcd and
address 2
[  338.752000] usb 2-1: reset high speed USB device using ehci_hcd and
address 2
[  338.892000] rtl8187: SCI interrupt Methord Will Turn Radio On
[  338.892000] read_nic_byte TimeOut!addr:50, status:ffffff6c
[  338.892000] write_nic_byte TimeOut!addr:50, status:ffffff6c
[  338.892000] read_nic_byte TimeOut!addr:59, status:ffffff6c
[  338.892000] write_nic_byte TimeOut!addr:59, status:ffffff6c
[  338.892000] rtl8187: Now Radio ON!
[  338.892000] write_nic_dword TimeOut!addr:54, status:ffffff6c
[  338.892000] write_nic_dword TimeOut!addr:60, status:ffffff6c
[  338.892000] write_nic_byte TimeOut!addr:85, status:ffffff6c
[  338.892000] read_nic_word TimeOut!addr:80, status:ffffff6c
[  338.892000] read_nic_word TimeOut!addr:84, status:ffffff6c
[  338.892000] write_nic_word TimeOut!addr:84, status:ffffff6c
[  338.892000] write_nic_word TimeOut!addr:80, status:ffffff6c
[  338.892000] write_nic_word TimeOut!addr:80, status:ffffff6c
[  338.892000] write_nic_word TimeOut!addr:80, status:ffffff6c
[  338.892000] write_nic_word TimeOut!addr:84, status:ffffff6c
[  338.892000] write_nic_byte TimeOut!addr:61, status:ffffff6c
[  338.892000] read_nic_byte TimeOut!addr:62, status:ffffff6c
[  338.892000] write_nic_byte TimeOut!addr:62, status:ffffff6c
[  338.892000] write_nic_byte TimeOut!addr:62, status:ffffff6c
[  338.892000] read_nic_byte TimeOut!addr:24e, status:ffffff6c
[  338.892000] write_nic_byte TimeOut!addr:24e, status:ffffff6c
[  338.892000] write_nic_byte TimeOut!addr:59, status:ffffff6c
[  338.892000] write_nic_byte TimeOut!addr:50, status:ffffff6c
[  339.004000] usb 2-4: reset high speed USB device using ehci_hcd and
address 3
[  339.136000] rtl8187 2-4:1.0: no reset_resume for driver rtl8187?
[  339.396000] rtl8187: Now Radio OFF!
[  339.408000] rtl8187: Card successfully reset
[  339.420000] rtl8187: wlan driver removed
[  339.472000] rtl8187: idProduct:0x8189, bcdDevice:0x200
[  339.520000] rtl8187: Channel plan is 0 
[  339.524000] rtl8187: Reported EEPROM chip is a 93c46 (1Kbit)
[  339.824000] rtl8187: Card MAC address is 00:17:c4:5a:1b:f9
[  340.332000] rtl8187: EEPROM Customer ID: 00
[  340.336000] There is a handler installed for event: 48
[  340.336000] rtl8187: SCI interrupt Methord Will Turn Radio Off
[  340.340000] rtl8187: Driver probe completed
[  340.344000] Restarting tasks ... 
[  340.396000] rtl8187: rtl8187_open process failed because radio off
[  340.408000] done.
[  340.476000] rtl8187: rtl8187_open process failed because radio off
...

(I tried to turn on the radio, can not turn it on)

but if he did something like this, it will "fix" the bug.

# before hibernation, remove the r8187 driver 
modprobe -r r8187

# enter into hibernation
echo disk > /sys/power/state

# ????
echo 0 >/sys/bus/usb/drivers_autoprobe
echo 4 >/sys/class/usb_host/usb_host2/companion
echo 1 >/sys/class/usb_host/usb_host1/companion
sleep 1
echo 1 >/sys/bus/usb/drivers_autoprobe
echo -4 >/sys/class/usb_host/usb_host2/companion
echo -1 >/sys/class/usb_host/usb_host1/companion
sleep 1  #wait for some devices stable

# reinsert the r8187 driver
modprobe r8187

So, that pfn_valid() should be okay, it made Hibernation works with
FLATMEM and have no side effect currently.

Regards,
	Wu Zhangjin

> 
> On Sat, 2009-10-10 at 00:15 +0800, Wu Zhangjin wrote:
> > When CONFIG_FLATMEM enabled, STD/Hiberation will fail on YeeLoong
> > laptop, This patch fixes it:
> > 
> > if pfn is between min_low_pfn and max_mapnr, the old pfn_valid() will
> > return TRUE, but if the memory is not continuous, for example:
> > 
> > $ cat /proc/iomem | grep "System RAM"
> > 00000000-0fffffff : System RAM
> > 90000000-bfffffff : System RAM
> > 
> > as we can see, it is not continuous, so, some of the memory is not
> > valid, and at last make STD/Hibernate fail when shrinking a too large
> > number of invalid memory.
> > 
> > the "invalid" memory here include the memory space we never used.
> > 
> > 10000000-3fffffff
> > 80000000-8fffffff
> > 
> > and also include the meory space we have mapped into pci space.
> > 
> > 40000000-7fffffff : pci memory space
> > 
> > Here, we fix it via checking pfn is in the "System RAM" or not. and
> > Seems pfn_valid() is not called in assembly code, we move it to
> > "!__ASSEMBLY__" to ensure we can simply declare it via "extern int
> > pfn_valid(unsigned long)" without Compiling Error.
> > 
> > (This -v1 version incorporates feedback from Pavel Machek <pavel@ucw.cz>
> >  and Sergei Shtylyov <sshtylyov@ru.mvista.com> and Ralf)
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > ---
> >  arch/mips/include/asm/page.h |   50 ++++++++++++++++++-----------------------
> >  arch/mips/mm/page.c          |   18 +++++++++++++++
> >  2 files changed, 40 insertions(+), 28 deletions(-)
> > 
> > diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> > index f266295..dc28d0a 100644
> > --- a/arch/mips/include/asm/page.h
> > +++ b/arch/mips/include/asm/page.h
> > @@ -146,36 +146,9 @@ typedef struct { unsigned long pgprot; } pgprot_t;
> >   */
> >  #define ptep_buddy(x)	((pte_t *)((unsigned long)(x) ^ sizeof(pte_t)))
> >  
> > -#endif /* !__ASSEMBLY__ */
> > -
> > -/*
> > - * __pa()/__va() should be used only during mem init.
> > - */
> > -#ifdef CONFIG_64BIT
> > -#define __pa(x)								\
> > -({									\
> > -    unsigned long __x = (unsigned long)(x);				\
> > -    __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);			\
> > -})
> > -#else
> > -#define __pa(x)								\
> > -    ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
> > -#endif
> > -#define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
> > -#define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
> > -
> > -#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
> > -
> >  #ifdef CONFIG_FLATMEM
> >  
> > -#define pfn_valid(pfn)							\
> > -({									\
> > -	unsigned long __pfn = (pfn);					\
> > -	/* avoid <linux/bootmem.h> include hell */			\
> > -	extern unsigned long min_low_pfn;				\
> > -									\
> > -	__pfn >= min_low_pfn && __pfn < max_mapnr;			\
> > -})
> > +extern int pfn_valid(unsigned long);
> >  
> >  #elif defined(CONFIG_SPARSEMEM)
> >  
> > @@ -194,6 +167,27 @@ typedef struct { unsigned long pgprot; } pgprot_t;
> >  
> >  #endif
> >  
> > +
> > +#endif /* !__ASSEMBLY__ */
> > +
> > +/*
> > + * __pa()/__va() should be used only during mem init.
> > + */
> > +#ifdef CONFIG_64BIT
> > +#define __pa(x)								\
> > +({									\
> > +    unsigned long __x = (unsigned long)(x);				\
> > +    __x < CKSEG0 ? XPHYSADDR(__x) : CPHYSADDR(__x);			\
> > +})
> > +#else
> > +#define __pa(x)								\
> > +    ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
> > +#endif
> > +#define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
> > +#define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
> > +
> > +#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
> > +
> >  #define virt_to_page(kaddr)	pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
> >  #define virt_addr_valid(kaddr)	pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
> >  
> > diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
> > index f5c7375..203d805 100644
> > --- a/arch/mips/mm/page.c
> > +++ b/arch/mips/mm/page.c
> > @@ -689,3 +689,21 @@ void copy_page(void *to, void *from)
> >  }
> >  
> >  #endif /* CONFIG_SIBYTE_DMA_PAGEOPS */
> > +
> > +#ifdef CONFIG_FLATMEM
> > +int pfn_valid(unsigned long pfn)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < boot_mem_map.nr_map; i++) {
> > +		if ((boot_mem_map.map[i].type == BOOT_MEM_RAM) ||
> > +			(boot_mem_map.map[i].type == BOOT_MEM_ROM_DATA)) {
> > +			if ((pfn >= PFN_DOWN(boot_mem_map.map[i].addr)) &&
> > +				(pfn < PFN_UP(boot_mem_map.map[i].addr +
> > +					boot_mem_map.map[i].size)))
> > +				return 1;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +#endif
