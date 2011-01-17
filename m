Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 15:17:52 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:33597 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493465Ab1AQORt convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jan 2011 15:17:49 +0100
Received: by wyf22 with SMTP id 22so5056907wyf.36
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 06:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CRV70rdFD07wREorqeVlgcbsRtY1GivK3uhhLU1lopM=;
        b=AsHS+icINlMZ+rr6rdtPDB8Z8T5kgCnxuyydNmbMtyg7KMLuAjugr4gD39xtDZUeDk
         3o6F7nz/SuMV4OB5N42JwI96WeUf40bUQ20/lCfQozQoL6KnENfOAN6iVqxaUhGNDbAo
         bhzcp5eNqT246W0LeVsADHwfOLjqvtoKXAyik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=k89UlQ3bfCSIZcy1jcAT7pkUQsZ7833HKRF9mvyNLi0MOybljzitfYCJ7hqqkIGl8l
         CFR9NgNarPGDKKC1/qrwM86f4kCB3NcnDwerbJ/iHrVrLSUEyFeXEdcflW3t9cIWdLNo
         HHvjQgjuhNCAmrjpSnD6t4iw2iogQaeHAldZ8=
MIME-Version: 1.0
Received: by 10.216.186.142 with SMTP id w14mr3867029wem.18.1295273769482;
 Mon, 17 Jan 2011 06:16:09 -0800 (PST)
Received: by 10.216.93.137 with HTTP; Mon, 17 Jan 2011 06:16:09 -0800 (PST)
In-Reply-To: <1295255224-19408-1-git-send-email-xiangfu@sharism.cc>
References: <1295255224-19408-1-git-send-email-xiangfu@sharism.cc>
Date:   Mon, 17 Jan 2011 22:16:09 +0800
Message-ID: <AANLkTimN4mTxSJiBD2cNs-pOTQBTHysFQYyYiU5ZSBsQ@mail.gmail.com>
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
X-archive-position: 28941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Xiangfu

On Mon, Jan 17, 2011 at 5:07 PM, Xiangfu Liu <xiangfu@sharism.cc> wrote:
> Requires mkimage tool from u-boot-tools.

This patch is cool, seems more and more MIPS boards are using the
popular U-boot ;-)

> Uses gzip compression by default.

Perhaps add more compression algos support and make them configurable
will be better. lzma/xz has higher compression rate, lzo has faster
decompression speed. and bzip2 is between lzo and gzip.

Regards,
Wu Zhangjin

>
> Signed-off-by: Xiangfu Liu <xiangfu@sharism.cc>
> Acked-by: Sergey Kvachonok <ravenexp@gmail.com>
> ---
>  arch/mips/Makefile               |    6 ++++++
>  arch/mips/boot/u-boot/.gitignore |    2 ++
>  arch/mips/boot/u-boot/Makefile   |   15 +++++++++++++++
>  3 files changed, 23 insertions(+), 0 deletions(-)
>  create mode 100644 arch/mips/boot/u-boot/.gitignore
>  create mode 100644 arch/mips/boot/u-boot/Makefile
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 7c1102e..8d1f9fc 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -280,6 +280,11 @@ vmlinuz vmlinuz.bin vmlinuz.ecoff vmlinuz.srec: $(vmlinux-32) FORCE
>        $(Q)$(MAKE) $(build)=arch/mips/boot/compressed \
>           VMLINUX_LOAD_ADDRESS=$(load-y) 32bit-bfd=$(32bit-bfd) $@
>
> +# u-boot
> +uImage: vmlinux.bin FORCE
> +       $(Q)$(MAKE) $(build)=arch/mips/boot/u-boot \
> +         VMLINUX=$(vmlinux-32) VMLINUXBIN=arch/mips/boot/vmlinux.bin \
> +         VMLINUX_LOAD_ADDRESS=$(load-y) arch/mips/boot/u-boot/$@
>
>  CLEAN_FILES += vmlinux.32 vmlinux.64
>
> @@ -313,6 +318,7 @@ define archhelp
>        echo '  vmlinuz.ecoff        - ECOFF zboot image'
>        echo '  vmlinuz.bin          - Raw binary zboot image'
>        echo '  vmlinuz.srec         - SREC zboot image'
> +       echo '  uImage               - U-boot image (gzip)'
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
> +
> +MKIMAGE = mkimage
> +
> +targets += uImage
> +quiet_cmd_uImage = MKIMAGE $@
> +cmd_uImage = $(MKIMAGE) -A mips -O linux -T kernel -C gzip -a $(VMLINUX_LOAD_ADDRESS) \
> +-e 0x$(shell $(NM) $(VMLINUX) | grep ' kernel_entry' | cut -f1 -d ' ') \
> +-n MIPS -d $(obj)/vmlinux.bin.gz $(obj)/uImage
> +$(obj)/uImage: $(obj)/vmlinux.bin.gz FORCE
> +       $(call if_changed,uImage)
> --
> 1.7.0.4
>
>
>
