Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2012 00:30:14 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:34131 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903600Ab2C2WaH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2012 00:30:07 +0200
Received: by bkcjk13 with SMTP id jk13so24708bkc.36
        for <linux-mips@linux-mips.org>; Thu, 29 Mar 2012 15:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=oNPAOjGYD0AqqZHcA+AYIq0ZdYFfGGfK7Ej4OjiPGyo=;
        b=T2wwGaqdlwKn24Ct27qhGGDkT6JzXV/OtqKmIks/wBdckv1wyxncSR7b9zEAPWY2lI
         BxDhTwSL41IZ0JVJe/tKRPdQBwrRFyjEnHRAS/8DxfooOLoJw2qHHv0fIo8WHk0cHc98
         rtmHmAGOECEoHLJMlfvbhzyVwy4m60Z5IRumsi9l0lmuZdgPDbIXhIKPlcAkWQ+8s0vJ
         G7Rw2jSN4IxKCEpbk8JosOK6U4t6UbvmBF7PyYtrd6skVIHuD//yV84S8wdDtMAVKSgA
         cgmFDoVhXOnNUPNdkHC4crUEPVg469LVdGzKaVFX35ejgsOX2tlHH//seWi5/fnPeHui
         3SMQ==
Received: by 10.205.137.15 with SMTP id im15mr14664255bkc.54.1333060200604;
        Thu, 29 Mar 2012 15:30:00 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-67-22.pppoe.mtu-net.ru. [91.79.67.22])
        by mx.google.com with ESMTPS id o22sm5719260bko.2.2012.03.29.15.29.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 15:29:59 -0700 (PDT)
Message-ID: <4F74E210.70707@mvista.com>
Date:   Fri, 30 Mar 2012 02:28:32 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To:     Maarten ter Huurne <maarten@treewalker.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?UTF-8?B?TGx1w61zIEJhdGxsZSBpIFJvc3NlbGw=?= <viric@viric.name>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] MIPS: Enable vmlinuz for JZ4740
References: <1333037360-18382-1-git-send-email-maarten@treewalker.org>
In-Reply-To: <1333037360-18382-1-git-send-email-maarten@treewalker.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Gm-Message-State: ALoCoQkxDrh4WOYeI/u6ZWF1dZ2dX+diS2tC+joEt2ZjjwJQvicdZ+BSOHt6fbP99zb0Y0uUYlWo
X-archive-position: 32822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 29-03-2012 20:09, Maarten ter Huurne wrote:

> From: Lluís Batlle i Rossell<viric@viric.name>

> This patch adds support for building a compressed kernel for the JZ4740
> architecture.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
> Signed-off-by: Maarten ter Huurne<maarten@treewalker.org>
[...]

> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 5042d51..71d89cb 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -58,8 +58,12 @@ $(obj)/piggy.o: $(obj)/dummy.o $(obj)/vmlinux.bin.z FORCE
>   # Calculate the load address of the compressed kernel image
>   hostprogs-y := calc_vmlinuz_load_addr
>
> +ifeq ($(CONFIG_MACH_JZ4740),y)
> +VMLINUZ_LOAD_ADDRESS:=0x80600000

    Spaces around :=, please. And why this should be out of order case?

> +else
>   VMLINUZ_LOAD_ADDRESS = $(shell $(obj)/calc_vmlinuz_load_addr \
>   		$(obj)/vmlinux.bin $(VMLINUX_LOAD_ADDRESS))
> +endif
>
>   vmlinuzobjs-y += $(obj)/piggy.o

WBR, Sergei
