Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2016 17:05:10 +0200 (CEST)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33568 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041562AbcFQPFJfkckn convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jun 2016 17:05:09 +0200
Received: by mail-lf0-f68.google.com with SMTP id l188so93465lfe.0;
        Fri, 17 Jun 2016 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gCYiINp9yQ19ycEkdwSh3xUEkwTOWqtvBTdA9GPRDg0=;
        b=GFuLDtM8dI7bQY8R6kT34u8AW775JyXK13F6L+12h8o0eXuxN0+htEw/0Am7ENe3WV
         cLqyBwnz7nnGDILeatMLE6TDhGpn8yjQlGrmkl/mww1o9S7wva0ZIeewJxXqJ8siVkxf
         4yI8u+T4V/Y6nG4Try+is5gAGOEo+zXuqCvkpAALPQLpTo+x/UHzs4Wsz+DZ8DPX7h+5
         d2AVHHR+5YIlVkkDp2m96Zcu5Pq/RGUawKuX6sRPDAuc6kzqU1doKN4oiwZror+iRO9+
         MUimdI+zhAE783uvBKdGdP5tfRXae2XqpirrLb8pNZo8UnFyTwb9WVky/HQvZUV6KRB5
         VwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCYiINp9yQ19ycEkdwSh3xUEkwTOWqtvBTdA9GPRDg0=;
        b=LKuzJzZ+Yg5hAkQ3iyvPIE6Sn4reXQzZA3IbvdnGTzTY22vUTvp/a8NmBYmyrbEvAH
         IhCIli6w0M3wyvWXmNqfj7XL2yWrDHupeMJGyi44PgAUcAGqLevR5/RqSsxKCvofcZqp
         BCK1ZKW4JtHBRj/XO6H6hP/StgCCKBJcei5XJK8fF4kbCNJrXknZjChOdFz1BwL4RErT
         MNI8jPxWYbn5wuRU0KC91jl45eDsllDkNV7Wr02dhdrjzqwJR5vWprXt6KzS7wDsMt8J
         DpdBg7QgaNYEtWyY7U7acu7nGuHfiX1snqZEpI5YgZViSr7GFEzQOBQJnmU3hJUtkTGb
         CLEA==
X-Gm-Message-State: ALyK8tLeZDt6X3clSb0MzWCwcPcN4C+emIZWB/e0uigzN7Pk7SHNBq+VycSLDvfzwEiL/A==
X-Received: by 10.46.32.73 with SMTP id g70mr801265ljg.28.1466175904152;
        Fri, 17 Jun 2016 08:05:04 -0700 (PDT)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id g1sm4166336lbd.36.2016.06.17.08.05.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Jun 2016 08:05:03 -0700 (PDT)
Date:   Fri, 17 Jun 2016 18:06:41 +0300
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
Message-Id: <20160617180641.b8996bd61014fa1aae68e4b8@gmail.com>
In-Reply-To: <b57eb27d-f7fe-b457-1915-75e995668a06@openwrt.org>
References: <1466165260-6897-1-git-send-email-jogo@openwrt.org>
        <1466165260-6897-2-git-send-email-jogo@openwrt.org>
        <20160617170141.faf0b14b26177f820f01d140@gmail.com>
        <b57eb27d-f7fe-b457-1915-75e995668a06@openwrt.org>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54101
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

On Fri, 17 Jun 2016 16:44:09 +0200
Jonas Gorski <jogo@openwrt.org> wrote:

> Hi Antony,
> 
> On 17.06.2016 16:01, Antony Pavlov wrote:
> > On Fri, 17 Jun 2016 14:07:39 +0200
> > Jonas Gorski <jogo@openwrt.org> wrote:
> > 
> >> Instead of rewriting the arguments, just move the appended dtb to where
> >> the decompressed kernel expects it. This eliminates the need for special
> >> casing vmlinuz.bin appended dtb files.
> >>
> >> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> >> ---
> >>  arch/mips/Kconfig                      | 22 ++--------------------
> >>  arch/mips/boot/compressed/Makefile     |  1 +
> >>  arch/mips/boot/compressed/decompress.c | 21 +++++++++++++++++++++
> >>  arch/mips/boot/compressed/head.S       | 16 ----------------
> >>  4 files changed, 24 insertions(+), 36 deletions(-)
> >>
> >> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> >> index ac91939..0d0f71e 100644
> >> --- a/arch/mips/Kconfig
> >> +++ b/arch/mips/Kconfig
> >> @@ -2885,10 +2885,10 @@ choice
> >>  		  the documented boot protocol using a device tree.
> >>  
> >>  	config MIPS_RAW_APPENDED_DTB
> >> -		bool "vmlinux.bin"
> >> +		bool "vmlinux.bin or vmlinuz.bin"
> >>  		help
> >>  		  With this option, the boot code will look for a device tree binary
> >> -		  DTB) appended to raw vmlinux.bin (without decompressor).
> >> +		  DTB) appended to raw vmlinux.bin or vmlinuz.bin.
> >>  		  (e.g. cat vmlinux.bin <filename>.dtb > vmlinux_w_dtb).
> >>  
> >>  		  This is meant as a backward compatibility convenience for those
> >> @@ -2900,24 +2900,6 @@ choice
> >>  		  look like a DTB header after a reboot if no actual DTB is appended
> >>  		  to vmlinux.bin.  Do not leave this option active in a production kernel
> >>  		  if you don't intend to always append a DTB.
> >> -
> >> -	config MIPS_ZBOOT_APPENDED_DTB
> >> -		bool "vmlinuz.bin"
> >> -		depends on SYS_SUPPORTS_ZBOOT
> >> -		help
> >> -		  With this option, the boot code will look for a device tree binary
> >> -		  DTB) appended to raw vmlinuz.bin (with decompressor).
> >> -		  (e.g. cat vmlinuz.bin <filename>.dtb > vmlinuz_w_dtb).
> >> -
> >> -		  This is meant as a backward compatibility convenience for those
> >> -		  systems with a bootloader that can't be upgraded to accommodate
> >> -		  the documented boot protocol using a device tree.
> >> -
> >> -		  Beware that there is very little in terms of protection against
> >> -		  this option being confused by leftover garbage in memory that might
> >> -		  look like a DTB header after a reboot if no actual DTB is appended
> >> -		  to vmlinuz.bin.  Do not leave this option active in a production kernel
> >> -		  if you don't intend to always append a DTB.
> >>  endchoice
> >>  
> >>  choice
> >> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> >> index 90aca95..f31ec89 100644
> >> --- a/arch/mips/boot/compressed/Makefile
> >> +++ b/arch/mips/boot/compressed/Makefile
> >> @@ -29,6 +29,7 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
> >>  	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
> >>  	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
> >>  
> >> +
> > 
> > Could you please remote this extra empty line?
> 
> Oops, that must have slipped through. Fixed locally.
> 
> >>  # decompressor objects (linked with vmlinuz)
> >>  vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o
> >>  
> >> diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
> >> index 080cd53..e18ab3e 100644
> >> --- a/arch/mips/boot/compressed/decompress.c
> >> +++ b/arch/mips/boot/compressed/decompress.c
> >> @@ -36,6 +36,12 @@ extern void puthex(unsigned long long val);
> >>  #define puthex(val) do {} while (0)
> >>  #endif
> >>  
> >> +#ifdef CONFIG_MIPS_RAW_APPENDED_DTB
> > 
> > Do we really need this '#ifdef' here?
> 
> No we don't, I was under the assumption the __appended_dtb is
> only available when appended dtb support is enabled, for for
> the decompressor it is always defined. At least gcc doesn't
> seem to complain about it being unused in a quick test
> compile. Fixed locally.

Now the __appended_dtb variable is always available.
You can make the next step and try to transform your

  +#ifdef CONFIG_MIPS_RAW_APPENDED_DTB
  +	if (fdt_magic((void *)&__appended_dtb) == FDT_MAGIC) {
  +		unsigned int image_size, dtb_size;

into something like this

  +     if (IS_ENABLED(CONFIG_MIPS_RAW_APPENDED_DTB) &&
  +	    fdt_magic((void *)&__appended_dtb) == FDT_MAGIC) {
  +		unsigned int image_size, dtb_size;


Using IS_ENABLED instead of #if/#ifdef the compiler can check
all the code.

-- 
Best regards,
  Antony Pavlov
