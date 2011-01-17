Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 17:38:11 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:54353 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493515Ab1AQQiI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jan 2011 17:38:08 +0100
Received: by wyf22 with SMTP id 22so5192294wyf.36
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 08:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GS+Apv3UEUT6K1ck9kaoScuw9fQTV0SObzLiB6q8/yk=;
        b=Nimze1WhIJdlDGMORqfHiOQ0+0OD0rFIIEJZXWnEGbzO2C8GNw2691Urca2NHCwPCF
         HYqn5FK/cF8+Cbqf75GpsPxrmw+rtCdhJcPNZkn87hinfd+X1qArBIxEXvxA60/CMzDi
         PVQAOwjTV3JnM9mg8ArwdBwJKwj0qvNCJAdJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gQgT8xBTqvbVXeXAuPSf1cA7sw34pay/8/Hhf6078HC6yGvYACA3maHszGGJ/1NI1C
         YY2Q4ummSpinfn1DnrjAlq/j1qx3lTG8BmD2DVViz0zvUXjVMvmN8y1A53lYGn8D0GuL
         oGHF7H4ELBV3XVTh3chwKK0Rt9wzl4Z6hepow=
MIME-Version: 1.0
Received: by 10.216.180.76 with SMTP id i54mr74975wem.33.1295282055074; Mon,
 17 Jan 2011 08:34:15 -0800 (PST)
Received: by 10.216.93.137 with HTTP; Mon, 17 Jan 2011 08:34:14 -0800 (PST)
In-Reply-To: <1295255224-19408-1-git-send-email-xiangfu@sharism.cc>
References: <1295255224-19408-1-git-send-email-xiangfu@sharism.cc>
Date:   Tue, 18 Jan 2011 00:34:14 +0800
Message-ID: <AANLkTimrKjk4FPSOhKBXZocG-ezH6eYR2mFzMUfiSVTS@mail.gmail.com>
Subject: Re: [PATCH] MIPS: add U-boot uImage build target to arch Makefile
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Xiangfu Liu <xiangfu@sharism.cc>
Cc:     linux-mips@linux-mips.org, ravenexp@gmail.com, lars@metafoo.de
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

More comments below:

On Mon, Jan 17, 2011 at 5:07 PM, Xiangfu Liu <xiangfu@sharism.cc> wrote:
[...]
>
> +# u-boot
> +uImage: vmlinux.bin FORCE
> +       $(Q)$(MAKE) $(build)=arch/mips/boot/u-boot \
> +         VMLINUX=$(vmlinux-32) VMLINUXBIN=arch/mips/boot/vmlinux.bin \
> +         VMLINUX_LOAD_ADDRESS=$(load-y) arch/mips/boot/u-boot/$@
>

As the comments in my previous reply, we may be possible to add the
uImage target to the line for vmlinuz, then, only one line need to be
changed.

>  CLEAN_FILES += vmlinux.32 vmlinux.64
>
> @@ -313,6 +318,7 @@ define archhelp
>        echo '  vmlinuz.ecoff        - ECOFF zboot image'
>        echo '  vmlinuz.bin          - Raw binary zboot image'
>        echo '  vmlinuz.srec         - SREC zboot image'
> +       echo '  uImage               - U-boot image (gzip)'

If more compression algos added, then, above "(gzip)" can be removed.
and seems we forgot adding uImage to the "install:" and "archclean:"
target ;-)

arch/mips/Makefile:

install:
        here....

archclean:
        and here ....

If we move arch/mips/boot/u-boot/Makefile to
arch/mips/boot/compressed/Makefile, then, we can simply and uImage to
the last line of that Makefile:

clean-files := .... uImage

>        echo
>        echo '  These will be default as apropriate for a configured platform.'
>  endef
> diff --git a/arch/mips/boot/u-boot/.gitignore b/arch/mips/boot/u-boot/.gitignore
> new file mode 100644
> index 0000000..1080c94
> --- /dev/null
> +++ b/arch/mips/boot/u-boot/.gitignore
> @@ -0,0 +1,2 @@
> +vmlinux.bin.gz
> +uImage

If we move the uImage target to arch/mips/boot/compressed/Makefile,
the uImage ignore can be added to arch/mips/boot/.gitignore

> diff --git a/arch/mips/boot/u-boot/Makefile b/arch/mips/boot/u-boot/Makefile
> new file mode 100644
> index 0000000..318dc50
> --- /dev/null
> +++ b/arch/mips/boot/u-boot/Makefile
> @@ -0,0 +1,15 @@
> +targets += vmlinux.bin.gz
> +quiet_cmd_gzip = GZIP $@
> +cmd_gzip = gzip -c9 $(VMLINUXBIN) $(obj)/vmlinux.bin.gz
> +$(obj)/vmlinux.bin.gz: $(obj)/../vmlinux.bin FORCE
> +       $(call if_changed,gzip)

If we share the vmlinux.bin.z with vmlinuz, then, the above can be removed.

> +
> +MKIMAGE = mkimage

As your previous reply, the above line can be replaced with
$(srctree)/scripts/mkuboot.sh

> +
> +targets += uImage
> +quiet_cmd_uImage = MKIMAGE $@
> +cmd_uImage = $(MKIMAGE) -A mips -O linux -T kernel -C gzip -a $(VMLINUX_LOAD_ADDRESS) \

We can align it with quiet_cmd_uImage above ;-)

quiet_cmd_uImage =  ...
         cmd_uImage = ...

And we can substitute "$(tool_y)" for the 'hardcoded' gzip above.

> +-e 0x$(shell $(NM) $(VMLINUX) | grep ' kernel_entry' | cut -f1 -d ' ') \

Seems this duplicates the KERNEL_ENTRY calculation of kernel_entry
address, perhaps we can make a common one and share them, here is a
minimal change of the old Makefile:

-KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) \
-       -DKERNEL_ENTRY=0x$(shell $(NM) $(objtree)/$(KBUILD_IMAGE)
2>/dev/null | grep " kernel_entry" | cut -f1 -d \ )
+KERNEL_ENTRY=0x$(shell $(NM) $(objtree)/$(KBUILD_IMAGE) 2>/dev/null |
grep " kernel_entry" | cut -f1 -d ' ')
+
+KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS)
-DKERNEL_ENTRY=$(KERNEL_ENTRY)

Then, we can use $(KERNEL_ENTRY) directly.

> +-n MIPS -d $(obj)/vmlinux.bin.gz $(obj)/uImage

Here, $(obj)/vmlinux.bin.z can be replaced with $(obj)/vmlinux.bin.z,
or we can simply use $< to simplify it.

> +$(obj)/uImage: $(obj)/vmlinux.bin.gz FORCE

$(obj)/vmlinux.bin.gz -> $(obj)/vmlinux.bin.z, and perhaps we can use
uImage instead of $(obj)/uImage too ;-)

> +       $(call if_changed,uImage)

Regards,
Wu Zhangjin
