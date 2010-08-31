Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Aug 2010 17:11:33 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:51569 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491171Ab0HaPL0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Aug 2010 17:11:26 +0200
Received: by ywi4 with SMTP id 4so2975742ywi.36
        for <multiple recipients>; Tue, 31 Aug 2010 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0nPhYjJRLAVO7pPIlCp5BWGIxd0BwPplVTEruZo+m5Q=;
        b=B4MMrPJCErNJBzeOD3Dze4nbYh19TyG49s1ouSPP3UF7W3WIRStbXGUpsXrqrXWa3v
         kSI9Uct1VcAyIGdDDCyWc1OQ57yLHF1KJZmamjZvpnVtAg5vt8jjriC8qY4xsFSETFPN
         v7r6PGZv3SwLiE+9cZlvXnxrgpJoYa+XnI3eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OV/TGAUTAvknALwJ5YrXxdxgmb/+6VLGhDgHe1W3u14PgNXasyw8smDZp0Y/bRwvPL
         UNoO91bePTVAkGODJZ2h4QsELqBbW5MMEE8LGt7Q0BYVPTjwPUIoMlcGqMdx2JVCAzbH
         ZbQh6OijHV+FCvnd50gaVjzkhFndg0VPM418k=
MIME-Version: 1.0
Received: by 10.102.247.11 with SMTP id u11mr511242muh.72.1283267476840; Tue,
 31 Aug 2010 08:11:16 -0700 (PDT)
Received: by 10.220.126.199 with HTTP; Tue, 31 Aug 2010 08:11:16 -0700 (PDT)
In-Reply-To: <4c7cd856.cb71df0a.1986.ffffad0f@mx.google.com>
References: <4c7cd856.cb71df0a.1986.ffffad0f@mx.google.com>
Date:   Tue, 31 Aug 2010 23:11:16 +0800
Message-ID: <AANLkTi=k_NdUjFHPD8=s1TaY6YW_EEZKo9ZOyYW1nCKK@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Calculate VMLINUZ_LOAD_ADDRESS based on the length
 of vmlinux.bin
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Shmulik Ladkani <shmulik.ladkani@gmail.com>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org, alex@digriz.org.uk,
        manuel.lauss@googlemail.com, sam@ravnborg.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

This is a very good fix:

$ ls -sh arch/mips/boot/compressed/vmlinux.bin vmlinux
5.4M arch/mips/boot/compressed/vmlinux.bin  6.9M vmlinux

Thanks very much.

Acked-by: Wu Zhangjin <wuzhangjin@gmail.com>

Regards,
Wu Zhangjin

On 8/31/10, Shmulik Ladkani <shmulik.ladkani@gmail.com> wrote:
> Fix VMLINUZ_LOAD_ADDRESS calculation to be based on the length of
> vmlinux.bin,
> the actual uncompressed kernel binary.
>
> Previously it was based on the length of KBUILD_IMAGE (the unstripped ELF
> vmlinux), which is bigger than vmlinux.bin.
> As a result, vmlinuz was loaded into a memory address higher then actually
> needed - a problem for small memory platforms.
>
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> ---
> diff --git a/arch/mips/boot/compressed/Makefile
> b/arch/mips/boot/compressed/Makefile
> index ed9bb70..5fd7f7a 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -59,7 +59,7 @@ $(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.bin.z FORCE
>  hostprogs-y := calc_vmlinuz_load_addr
>
>  VMLINUZ_LOAD_ADDRESS = $(shell $(obj)/calc_vmlinuz_load_addr \
> -		$(objtree)/$(KBUILD_IMAGE) $(VMLINUX_LOAD_ADDRESS))
> +		$(obj)/vmlinux.bin $(VMLINUX_LOAD_ADDRESS))
>
>  vmlinuzobjs-y += $(obj)/piggy.o
>
> --
> Shmulik Ladkani
>
