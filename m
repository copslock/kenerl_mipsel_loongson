Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jun 2012 22:07:05 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:47267 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903540Ab2F3UG5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jun 2012 22:06:57 +0200
Received: by lbbgg6 with SMTP id gg6so6147372lbb.36
        for <linux-mips@linux-mips.org>; Sat, 30 Jun 2012 13:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=OWV4hlFooLXfnovwkdvsgH8QFVwSr8XAEhy93ctP7Vc=;
        b=Oe/7lgr8aarp0KF8CEOcZGzWEXSLF/y1K1A1d2VMX6QK5oSzaXSgKWlhEmVpZfIEgK
         QnqIsudKlldEW2ijaS3ZMuepOc+79VtwrGxK71Xr1NVfp+tDTuYmraYTbQepR6A/iiME
         jpEV2ad3bSphGIRFws4J+UXDts3IYSzxAUxaVYW36Q1bZqS8YP7Fyri1Ob4b9aQzd5gM
         C6NSqCjWXGfM0lepNSNisk/w08RYQ+Bqzdmzw3w/3i1ZdEOOha9dxE/2fpCDxiLhIDBq
         wS88GRIEcOxY4kTVfLZBfEP69U69oaa8Nnp9tYP1dvnjKSXOLgSf/aAQV2BT9a0CD7yo
         5prA==
Received: by 10.112.36.195 with SMTP id s3mr3411816lbj.42.1341086811095;
        Sat, 30 Jun 2012 13:06:51 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-87-54.pppoe.mtu-net.ru. [91.79.87.54])
        by mx.google.com with ESMTPS id fy10sm13036560lab.0.2012.06.30.13.06.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 30 Jun 2012 13:06:50 -0700 (PDT)
Message-ID: <4FEF5C29.50107@mvista.com>
Date:   Sun, 01 Jul 2012 00:06:01 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v4,04/10] Add the MIPS32R2 'ins' and 'ext' instructions
 for use by the kernel's micro-assembler.
References: <1340994924-3922-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1340994924-3922-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQknMtsYlrZA8SIQluJT/UcsYvFIYxj1Y6lJ/SDlA2rIpnFK3McCuz2JQ+3cJOiZgP2Tms3g
X-archive-position: 33872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 29-06-2012 22:35, Steven J. Hill wrote:

> From: "Steven J. Hill"<sjhill@mips.com>

> Signed-off-by: Steven J. Hill<sjhill@mips.com>
[...]

> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> index 5fa1851..663b6b1 100644
> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
[...]
> @@ -343,6 +345,13 @@ Ip_u2u1msbu3(op)					\
>   }							\
>   UASM_EXPORT_SYMBOL(uasm_i##op);
>
> +#define I_u2u1mmsbu3(op) 				\
> +Ip_u2u1msbu3(op)					\
> +{							\
> +	build_insn(buf, insn##op, b, a, d-1, c);	\
> +}							\
> +UASM_EXPORT_SYMBOL(uasm_i##op);
> +
>   #define I_u1u2(op)					\
>   Ip_u1u2(op)						\
>   {							\
> @@ -396,6 +405,8 @@ I_u2u1u3(_drotr)
>   I_u2u1u3(_drotr32)
>   I_u3u1u2(_dsubu)
>   I_0(_eret)
> +I_u2u1mmsbu3(_ext)
> +I_u2u1msbu3(_ins)

    Not I_u2u1mmsbu3()?

WBR, Sergei
