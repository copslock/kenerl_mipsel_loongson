Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2016 00:16:57 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:59191 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27027695AbcEEWQvwRbn5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 May 2016 00:16:51 +0200
Received: from [2001:bc8:30d7:120:daeb:97ff:feb6:3f19] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <aurelien@aurel32.net>)
        id 1ayRZh-0005W4-KA; Fri, 06 May 2016 00:16:49 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.87)
        (envelope-from <aurelien@aurel32.net>)
        id 1ayRZh-0000bj-9N; Fri, 06 May 2016 00:16:49 +0200
Date:   Fri, 6 May 2016 00:16:49 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Octeon: byteswap initramfs in little endian mode
Message-ID: <20160505221649.GA29979@aurel32.net>
Mail-Followup-To: David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
References: <1462484017-29988-1-git-send-email-aurelien@aurel32.net>
 <572BBDB8.8000300@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572BBDB8.8000300@caviumnetworks.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On 2016-05-05 14:40, David Daney wrote:
> On 05/05/2016 02:33 PM, Aurelien Jarno wrote:
> >The initramfs if loaded in memory by U-Boot running in big endian mode.
> >When the kernel is running in little endian mode, we need to byteswap it
> >as it is accessed byte by byte.
> 
> Ouch!
> 
> Really it should be fixed in the bootloader, but that probably won't happen.

How would you see that fixed in the bootloader? I doubt it's difficult
to autodetect that, as the initramfs is basically loaded in memory
first, and later only the address and size are passed on the kernel
command line using the rd_start= and rd_size= options.

The other alternative would be to provide reversed endian fatload,
ext2load, ext4load, ... versions. Or maybe a better alternative would be
a function to byteswap a memory area, it could be inserted in a bootcmd
between the load and the bootoctlinux.

> I wonder, is there a magic number that the initrd has?  If so, we could
> probe for a byteswapped initrd and not do the byte reversal unconditionally.

There is a magic number... after it has been uncompressed. The magics
for the compressed version are defined in lib/decompress.c. Maybe we can
call decompress_method() from the finalize_initrd with the first 8 bytes
byteswapped and check for the result.

> The logic seems correct, we need to byte swap each 8-byte aligned 8-byte
> word in the image.
> 
> >
> >Cc: David Daney <david.daney@cavium.com>
> >Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> >---
> >  arch/mips/kernel/setup.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> >Note: It might not be the best place to byteswap the initramfs not the
> >best way to do it. At least it shows the problem and what shoudl be done.
> >Suggestions to improve the patch are welcome.
> >
> >diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> >index 4f60734..e7d015e 100644
> >--- a/arch/mips/kernel/setup.c
> >+++ b/arch/mips/kernel/setup.c
> >@@ -263,6 +263,16 @@ static void __init finalize_initrd(void)
> >  		goto disable;
> >  	}
> >
> >+#if defined(CONFIG_CPU_CAVIUM_OCTEON) && defined(CONFIG_CPU_LITTLE_ENDIAN)
> >+	{
> >+		unsigned long i;
> >+		pr_info("Cavium Octeon kernel in little endian mode "
> >+			"detected, byteswapping ramdisk\n");
> >+		for (i = initrd_start; i < ALIGN(initrd_end, 8); i += 8)
> >+			*((unsigned long *)i) = swab64(*((unsigned long *)i));
> >+	}
> >+#endif
> >+
> >  	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
> >  	initrd_below_start_ok = 1;
> >
> >
> 
> 

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
