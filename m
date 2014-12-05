Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2014 18:29:00 +0100 (CET)
Received: from mail-oi0-f52.google.com ([209.85.218.52]:54135 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008206AbaLER264TGej (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2014 18:28:58 +0100
Received: by mail-oi0-f52.google.com with SMTP id h136so746284oig.39
        for <multiple recipients>; Fri, 05 Dec 2014 09:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=a9CWL0hXeWgaal0GV71M7yYpoBYBRWYE+XLzWJ3NJA4=;
        b=P7GkhJi12YGsBWPoy1envqnsB5yjSdz8oMgHu3ySRtMZCHX2lNbcHZao2bAMVVc2K1
         wyxNizziDlNa1x+yDlnHejuFm+UOA3LB+5NHei16XJEAXqr7Fa5R3llCZYX0vLwSnzCZ
         pQTob/ssaKolAdp0SQZH6ynTTB0rNZjRddfsa6QFinehEuOWbnjzmBRTld8HPnJIze3/
         dI3BP2HM1ck31YEZYuy9lAYqtNZyAoIWTEmWRyWE3YWe222g5PlfjFlfnFvNc0JuHxV2
         4NH8xyaD4cMnnIuBvGGbiZaWYk3EI+XGAWQ8g+lAXnyBT7RWNwrWqyyTcGF7QgxtAM9q
         OdqA==
X-Received: by 10.60.98.36 with SMTP id ef4mr11299203oeb.51.1417800532905;
        Fri, 05 Dec 2014 09:28:52 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id ph6sm14160051oeb.5.2014.12.05.09.28.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 05 Dec 2014 09:28:52 -0800 (PST)
Message-ID: <5481EB52.6060706@gmail.com>
Date:   Fri, 05 Dec 2014 09:28:50 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     linux-mips@linux-mips.org, Zubair.Kakakhel@imgtec.com,
        geert+renesas@glider.be, david.daney@cavium.com,
        peterz@infradead.org, paul.gortmaker@windriver.com,
        davidlohr@hp.com, macro@linux-mips.org, chenhc@lemote.com,
        cl@linux.com, mingo@kernel.org, richard@nod.at, zajec5@gmail.com,
        james.hogan@imgtec.com, keescook@chromium.org, tj@kernel.org,
        alex@alex-smith.me.uk, pbonzini@redhat.com, blogic@openwrt.org,
        paul.burton@imgtec.com, qais.yousef@imgtec.com,
        linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        markos.chandras@imgtec.com, dengcheng.zhu@imgtec.com,
        manuel.lauss@gmail.com, lars.persson@axis.com
Subject: Re: [PATCH v3 3/3] MIPS: set stack/data protection as non-executable
References: <20141203015537.13886.50830.stgit@linux-yegoshin> <20141203015824.13886.74616.stgit@linux-yegoshin>
In-Reply-To: <20141203015824.13886.74616.stgit@linux-yegoshin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44585
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

On 12/02/2014 05:58 PM, Leonid Yegoshin wrote:
> This is a last step of 3 patches which shift FPU emulation out of
> stack into protected area. So, it disables a default executable stack.
>
> Additionally, it sets a default data area non-executable protection.
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

NAK!

Some programs require an executable stack, this patch will break them.

You can only select a non-executable stack in response to PT_GNU_STACK 
program headers in the ELF file of the executable program.

David Daney


> ---
>   arch/mips/include/asm/page.h |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index 3be81803595d..d49ba81cb4ed 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -230,7 +230,7 @@ extern int __virt_addr_valid(const volatile void *kaddr);
>   #define virt_addr_valid(kaddr)						\
>   	__virt_addr_valid((const volatile void *) (kaddr))
>
> -#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
> +#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | \
>   				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>
>   #define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + UNCAC_BASE)
>
>
>
>
