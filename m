Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6L9LAu16639
	for linux-mips-outgoing; Sat, 21 Jul 2001 02:21:10 -0700
Received: from earth.ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6L9L1V16635;
	Sat, 21 Jul 2001 02:21:01 -0700
Received: from [10.21.56.226] (earth.ayrnetworks.com [10.1.1.24])
	by earth.ayrnetworks.com (8.11.0/8.8.7) with ESMTP id f6L9KKr10694;
	Sat, 21 Jul 2001 02:20:20 -0700
User-Agent: Microsoft-Entourage/9.0.2509
Date: Sat, 21 Jul 2001 03:22:17 -0600
Subject: Re: SHN_MIPS_SCOMMON
From: Greg Satz <satz@ayrnetworks.com>
To: Ralf Baechle <ralf@oss.sgi.com>
CC: <linux-mips@oss.sgi.com>
Message-ID: <B77EA5E8.883E%satz@ayrnetworks.com>
In-Reply-To: <20010721033019.A22637@bacchus.dhis.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi Ralf, maybe I am missing something but after downloading and some perusal
I don't see where the newer (2.4.5) kernel addresses this problem. At the
risk of being redundant, the issue, as I see it, is the use of SCOMMON
symbols in ELF section SHN_MIPS_SCOMMON (0xff03). These symbols are
overlooked when insmod relocates symbols in the SHN_COMMON ELF section. They
end up in the kernel with a value of 4. Upon being referenced, the module
gets a page fault opps.

The file obj/obj_reloc.c in the modutils package is where the SHN_COMMON
symbol relocation work is performed. Using the gcc flag -fno-common forces
all commons info bss thus preventing the problem. We do this as a
work-around now.

The question is whether the gcc -fno-common flag is the real fix or is
obj/obj_reloc.c deficient. I have a patch that appears to work for
obj/obj_reloc.c

We create the problem situation by declaring variables in one file as extern
and defining them in another. The compiler puts these variables in the
SCOMMON segment instead of the COMMON segment.

Thanks,
Greg

on 7/20/01 7:30 PM, Ralf Baechle at ralf@oss.sgi.com wrote:

> On Fri, Jul 20, 2001 at 04:15:28PM -0600, Greg Satz wrote:
> 
>> When making modules for the 2.4.2 kernel, gcc and friends will generate
> 
> Rotten kernel error.  Upgrade to >= 2.4.5.
> 
> Ralf
> 
