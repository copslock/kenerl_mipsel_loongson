Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 23:48:05 +0200 (CEST)
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35849 "EHLO
        mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013241AbbEMVsDIGKxJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 23:48:03 +0200
Received: by igbpi8 with SMTP id pi8so151502722igb.1;
        Wed, 13 May 2015 14:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pKKlNXrqkxmLOEWSckx78rsOizk3rhpQgfHgOkC0LJI=;
        b=xGVaNDCukjvL4Ya/6aVwY12FBaR+8laAWqdm6FzSH+SaR/w/5qnpZ4vFaZbwvFUR3q
         19OmuyCXpd104YJ0pm1zSXIZ95VXoEDpuhERJtP2lJvFzOAaGomYvUesQaY/IGUaKBks
         X32FnnHE2U8QYjuYAHtYYf4kpVMTXApXuB+OqD9jesAbJNGJlGhx87FKtL4FC+6Yhb3X
         H3r3CtgSWpu6eSDidhBNj7PpczmsqxgqWSSrxFAF5ZLZ90IFiRPL0hoYZNXhrfy5+tRJ
         K6YtyqZdyfeLFbrV/e8U3rqlJABoAz0inAJc1m3DwqIOBKIh2XFA5rF4pt61P9UYjh/k
         n9Mw==
X-Received: by 10.107.47.163 with SMTP id v35mr1264669iov.86.1431553679366;
        Wed, 13 May 2015 14:47:59 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id pg7sm4491335igb.6.2015.05.13.14.47.57
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 14:47:58 -0700 (PDT)
Message-ID: <5553C68C.6000000@gmail.com>
Date:   Wed, 13 May 2015 14:47:56 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Subject: Re: [PATCH] MIPS64: 48 bit physaddr support in memory maps
References: <20150513185519.27601.4253.stgit@ubuntu-yegoshin>
In-Reply-To: <20150513185519.27601.4253.stgit@ubuntu-yegoshin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/13/2015 11:55 AM, Leonid Yegoshin wrote:
> Originally, it was set to 40bits only but I6400 has 48bits of physaddr.
>

Why not go to the architectural limit of 59 bits?


> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
>   arch/mips/include/asm/addrspace.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
> index ba0925c84b75..d54137602ac5 100644
> --- a/arch/mips/include/asm/addrspace.h
> +++ b/arch/mips/include/asm/addrspace.h
> @@ -53,7 +53,7 @@
>    */
>   #define CPHYSADDR(a)		((_ACAST32_(a)) & 0x1fffffff)
>   #define XPHYSADDR(a)		((_ACAST64_(a)) &			\
> -				 _CONST64_(0x000000ffffffffff))
> +				 _CONST64_(0x0000ffffffffffff))
>
>   #ifdef CONFIG_64BIT
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
