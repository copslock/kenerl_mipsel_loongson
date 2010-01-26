Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 19:07:26 +0100 (CET)
Received: from gv-out-0910.google.com ([216.239.58.187]:63164 "EHLO
        gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493394Ab0AZSHX convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 Jan 2010 19:07:23 +0100
Received: by gv-out-0910.google.com with SMTP id r4so337188gve.2
        for <multiple recipients>; Tue, 26 Jan 2010 10:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AYib+AOxvzbdjGMTGcO5B7jrElONajwgOp2fDBUma5s=;
        b=Drv6yGAUElbzsRAL0A3Nkdupu/9iuWzz8VfvN+Q8X9uLhgpVqejdo0mA3MrpqGYWmt
         VczB0YDFYLwDOo4VzGBZrsac7JyGP4TnPlRYnW7yrNjRxKNcYwMTPvsa2EPY5MHwNC3K
         zMqr4KAkf46r5R7vjRxS3TcmebeVpFIulU6kM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ARQhBSybx19Mke20n17HLXPmAz98QwKNjK6tLjx48o0c8rKEn6RBEFAu3VyiskgHIs
         elAY3+uEf80zv3Cy4A3FaitOcBG445Jd4lqXVsoAoVCpFRl4oViLNbD7j/60qwWnqAyz
         auLYrHAQiAo1kNPyUd6jox0UJXUDhK4w3CIfU=
MIME-Version: 1.0
Received: by 10.103.205.11 with SMTP id h11mr474136muq.110.1264529242185; Tue, 
        26 Jan 2010 10:07:22 -0800 (PST)
In-Reply-To: <cf2781a56090637044a5ad3837caef468a674ee4.1264524254.git.wuzhangjin@gmail.com>
References: <cf2781a56090637044a5ad3837caef468a674ee4.1264524254.git.wuzhangjin@gmail.com>
Date:   Tue, 26 Jan 2010 19:07:22 +0100
Message-ID: <f861ec6f1001261007k4f71244fqcc92e2b6b1c9234c@mail.gmail.com>
Subject: Re: [PATCH -queue v3] MIPS: Cleanup the debugging of compressed 
        kernel support
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 25684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16843

Hi!

On Tue, Jan 26, 2010 at 6:01 PM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
>
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -32,7 +32,9 @@ KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
>
>  obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
>
> +ifdef DEBUG_ZBOOT

The above doesn't work in my testing, but this does:
ifeq ($(CONFIG_DEBUG_ZBOOT),y)

>  obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
> +endif


Manuel
