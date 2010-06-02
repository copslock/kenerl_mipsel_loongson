Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 04:31:20 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:65237 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491203Ab0FBCbL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Jun 2010 04:31:11 +0200
Received: by pvb32 with SMTP id 32so712751pvb.36
        for <multiple recipients>; Tue, 01 Jun 2010 19:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s1VSctApP4TXWvj/tQyoalced30bItNZJXOBLFeKle4=;
        b=ERYeHAjS7p3etAZPA9hoiTjYq8TIdQgW5bDD56DZK0K7/KaqHnWcqEPNT53zcZKDWS
         TF/0re8fBasArJkYLN8wToUzEcLjKsxw0G/VpVQVkg+JJtCGK1xnIGciKHbkLQsy9Tpj
         0QMl0hCgwDRulCW+MYWhlnlXgbst5VV8Y71js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i0sm7G8wyjYGjZLo8ia/boBZLyLBVIU0ydol+ZtbcdBQ20aoQT4DUiiFI/IV9m5jQJ
         zDcn6eiiN8GpcEE3YZBhnslf7y1ZdfZ/W5WL6J7HeS8aYwRH58soVmpif0igVdwmOhgr
         hLU5MRJsCmwGhqxHzWvbn4Ul6lcPLoaPC+FKk=
MIME-Version: 1.0
Received: by 10.141.90.18 with SMTP id s18mr5631177rvl.297.1275445862212; Tue, 
        01 Jun 2010 19:31:02 -0700 (PDT)
Received: by 10.142.179.7 with HTTP; Tue, 1 Jun 2010 19:31:02 -0700 (PDT)
In-Reply-To: <1275388144-5998-1-git-send-email-wuzhangjin@gmail.com>
References: <1275388144-5998-1-git-send-email-wuzhangjin@gmail.com>
Date:   Wed, 2 Jun 2010 10:31:02 +0800
Message-ID: <AANLkTimphf48ZsNVS29mUNwx4NHSd7FeicoFcHsdmd58@mail.gmail.com>
Subject: Re: [PATCH] MIPS: arch/mips/boot/compressed/Makefile: Unify the 
        suffix of compressed vmlinux.bin
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Cc:     Alexander Clouter <alex@digriz.org.uk>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 26980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 927

Hi,

I will use vmlinux.bin.z in the next revision of this patch.

Regards,


On Tue, Jun 1, 2010 at 6:29 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> The compressed vmlinux.{gz,bz2,lzo,lzma} are only temp files, we can use the
> same suffix for them to remove several lines and simpify the maintaining.
>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/boot/compressed/Makefile |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 74a52d7..7204dfc 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -48,23 +48,19 @@ OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
>  $(obj)/vmlinux.bin: $(KBUILD_IMAGE) FORCE
>        $(call if_changed,objcopy)
>
> -suffix_$(CONFIG_KERNEL_GZIP)  = gz
> -suffix_$(CONFIG_KERNEL_BZIP2) = bz2
> -suffix_$(CONFIG_KERNEL_LZMA)  = lzma
> -suffix_$(CONFIG_KERNEL_LZO)   = lzo
>  tool_$(CONFIG_KERNEL_GZIP)    = gzip
>  tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
>  tool_$(CONFIG_KERNEL_LZMA)    = lzma
>  tool_$(CONFIG_KERNEL_LZO)     = lzo
>
> -targets += vmlinux.gz vmlinux.bz2 vmlinux.lzma vmlinux.lzo
> -$(obj)/vmlinux.$(suffix_y): $(obj)/vmlinux.bin FORCE
> +targets += vmlinux.z
> +$(obj)/vmlinux.z: $(obj)/vmlinux.bin FORCE
>        $(call if_changed,$(tool_y))
>
>  targets += piggy.o
> -OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.$(suffix_y) \
> +OBJCOPYFLAGS_piggy.o := --add-section=.image=$(obj)/vmlinux.z \
>                         --set-section-flags=.image=contents,alloc,load,readonly,data
> -$(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.$(suffix_y) FORCE
> +$(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.z FORCE
>        $(call if_changed,objcopy)
>
>  LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
> --
> 1.6.5
>
>



-- 
Studying engineer. Wu Zhangjin
Lanzhou University      http://www.lzu.edu.cn
Distributed & Embedded System Lab      http://dslab.lzu.edu.cn
School of Information Science and Engeneering         http://xxxy.lzu.edu.cn
wuzhangjin@gmail.com         http://falcon.oss.lzu.edu.cn
Address:Tianshui South Road 222,Lanzhou,P.R.China    Zip Code:730000
Tel:+86-931-8912025
