Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 16:00:13 +0200 (CEST)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36697 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026277AbcFQOALBtB3w convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 16:00:11 +0200
Received: by mail-lf0-f68.google.com with SMTP id a2so8427417lfe.3;
        Fri, 17 Jun 2016 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NS6/KKW8B4aDWPcw7NEyxpk/8W55lmKTWA9hUHs6qN0=;
        b=zpwxCXP61YdbkFXdRLF4k/cF6awaX6M2igbMDB9qAkuBdpJU88PgyF42Cl/gmODe7T
         g/gRJrWlmPa9boITHm/DbhQUrCYEAC5c6qpJVWgBzZqQn7Z2JAavzcX2JSjGIf2S1pV2
         ddEJ8QHOoeQI0I7dRmpIJ3vN98tb4GQP8K/AcPSXlWXJmhvt0J1yaJI5rh5jyKUSRZS/
         FrAbo23iUp3zvV14LbuOImDw7X6SmQ0R9nFcrSEkkQ2voWGPPECZJYXD7k6hy1eG9hxY
         5h65U+bZLIfKfIr4BabhWAgSoHFNDDFPJ+haZM/JO2LTbRy3NUf7B5jqJf/ntMNB0pF1
         Eiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NS6/KKW8B4aDWPcw7NEyxpk/8W55lmKTWA9hUHs6qN0=;
        b=QRTSOT7ov6J0/xxv8OT9XH3lBHWZFgrPAKJLH4MyAX1CjI76svkRVMmP+bMr9p9kM9
         5DRnh+1hX7KKfVGqNOOt8rHEWiUOM4GkPnvpMSiRvHAp+HtL2FpVlcfEVeb4qGyA0nGR
         Dj5sL1XFaECDWt7rWJr9/0PF3v4q6/w/e1nl/P4j5ep73OKZplbfVJuRqmQsluPOrCr3
         ORSeyyx7v9cELAGvIVpFImeJYUzOWHl8pnpkPOGD9JEkjcacHPQ31bLSTfCERdNpcceV
         aGnUDACqWNWGYSu1RQIixCCpBzoU4OlIZtReEZ+5J8d4imqA6Ma6iuaKlqxMpoIzdXVm
         JMiQ==
X-Gm-Message-State: ALyK8tIIY+0MzSnqnX5lIpAs2ZjbA2C7ET+kX4DIzJbQk9OAnK/EuhS2jlcoWD+eBGFGuQ==
X-Received: by 10.25.196.216 with SMTP id u207mr643883lff.164.1466172005487;
        Fri, 17 Jun 2016 07:00:05 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id 16sm3442639ljj.47.2016.06.17.07.00.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Jun 2016 07:00:04 -0700 (PDT)
Date:   Fri, 17 Jun 2016 17:01:41 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Alban Bedel <albeu@free.fr>,
        Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
Subject: Re: [PATCH 1/2] MIPS: ZBOOT: copy appended dtb to the end of the
 kernel
Message-Id: <20160617170141.faf0b14b26177f820f01d140@gmail.com>
In-Reply-To: <1466165260-6897-2-git-send-email-jogo@openwrt.org>
References: <1466165260-6897-1-git-send-email-jogo@openwrt.org>
        <1466165260-6897-2-git-send-email-jogo@openwrt.org>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Fri, 17 Jun 2016 14:07:39 +0200
Jonas Gorski <jogo@openwrt.org> wrote:

> Instead of rewriting the arguments, just move the appended dtb to where
> the decompressed kernel expects it. This eliminates the need for special
> casing vmlinuz.bin appended dtb files.
> 
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
>  arch/mips/Kconfig                      | 22 ++--------------------
>  arch/mips/boot/compressed/Makefile     |  1 +
>  arch/mips/boot/compressed/decompress.c | 21 +++++++++++++++++++++
>  arch/mips/boot/compressed/head.S       | 16 ----------------
>  4 files changed, 24 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index ac91939..0d0f71e 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2885,10 +2885,10 @@ choice
>  		  the documented boot protocol using a device tree.
>  
>  	config MIPS_RAW_APPENDED_DTB
> -		bool "vmlinux.bin"
> +		bool "vmlinux.bin or vmlinuz.bin"
>  		help
>  		  With this option, the boot code will look for a device tree binary
> -		  DTB) appended to raw vmlinux.bin (without decompressor).
> +		  DTB) appended to raw vmlinux.bin or vmlinuz.bin.
>  		  (e.g. cat vmlinux.bin <filename>.dtb > vmlinux_w_dtb).
>  
>  		  This is meant as a backward compatibility convenience for those
> @@ -2900,24 +2900,6 @@ choice
>  		  look like a DTB header after a reboot if no actual DTB is appended
>  		  to vmlinux.bin.  Do not leave this option active in a production kernel
>  		  if you don't intend to always append a DTB.
> -
> -	config MIPS_ZBOOT_APPENDED_DTB
> -		bool "vmlinuz.bin"
> -		depends on SYS_SUPPORTS_ZBOOT
> -		help
> -		  With this option, the boot code will look for a device tree binary
> -		  DTB) appended to raw vmlinuz.bin (with decompressor).
> -		  (e.g. cat vmlinuz.bin <filename>.dtb > vmlinuz_w_dtb).
> -
> -		  This is meant as a backward compatibility convenience for those
> -		  systems with a bootloader that can't be upgraded to accommodate
> -		  the documented boot protocol using a device tree.
> -
> -		  Beware that there is very little in terms of protection against
> -		  this option being confused by leftover garbage in memory that might
> -		  look like a DTB header after a reboot if no actual DTB is appended
> -		  to vmlinuz.bin.  Do not leave this option active in a production kernel
> -		  if you don't intend to always append a DTB.
>  endchoice
>  
>  choice
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 90aca95..f31ec89 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -29,6 +29,7 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
>  	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
>  	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
>  
> +

Could you please remote this extra empty line?

>  # decompressor objects (linked with vmlinuz)
>  vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o
>  
> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> index 080cd53..e18ab3e 100644
> --- a/arch/mips/boot/compressed/decompress.c
> +++ b/arch/mips/boot/compressed/decompress.c
> @@ -36,6 +36,12 @@ extern void puthex(unsigned long long val);
>  #define puthex(val) do {} while (0)
>  #endif
>  
> +#ifdef CONFIG_MIPS_RAW_APPENDED_DTB

Do we really need this '#ifdef' here?

> +#include <linux/libfdt.h>
> +
> +extern char __appended_dtb[];
> +#endif
> +

-- 
Best regards,
  Antony Pavlov
