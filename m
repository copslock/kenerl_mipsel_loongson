Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2016 19:25:13 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34394 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025312AbcC1RZLTe024 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Mar 2016 19:25:11 +0200
Received: by mail-pa0-f68.google.com with SMTP id hj7so16066471pac.1;
        Mon, 28 Mar 2016 10:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=YaCi73dDtUsHh2EqkfSizYc6z3dy/uJ+keqCS1diyGg=;
        b=T8LWIIuRqMT61OD+CaNklW0G9ttu6xSJfpkXYTqMFTBAa8V9lOqn1222Q6hxGi+n8s
         px3XVMLkL5xnX0wlC9E8ejbS1YkpGaHTfJnD7s/Ox9b4zowllxgy80x4KYrBEmXSIaWW
         Matx3ML/DClZOtJ3c/+oWo/1XAC4TCavyIy6OZH+VciaVVD9VgCJ9W/wqwyq8DyPSdZ5
         1OuskqNAuzYlDZePCv8pwiFTdJR2y7oQUiPEHenhYmCfDINUwO5S3a5ZBdjJOO5AitVh
         UXnG2oJ52Vrg5k6e9PiQp6IK0zYD5STDQXTW+s8bZUQz4PXLtUYYwliPj8L6A8g/PxTH
         UvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=YaCi73dDtUsHh2EqkfSizYc6z3dy/uJ+keqCS1diyGg=;
        b=IJXcV4sn9Oi3fMM9DKGImUIA8/YELZdgckc5FEsU+/XnurOYofC7S4gpIqjqMKXrzI
         kWjqhgALgYg1285kFUyuSqkkcQ520IOs2gUGmfxscobBndwD0EsQe7sefq4iwX32cewB
         oRMYOpLJ7zQIZooiOaaxxihpCCPfqMgFjoMAb24IieLWKvWMI8WQpo2RACvDPyqsE1eJ
         2Ei0Nm7Z65FybtRT6ST67jLSJ1CUyQD06QkLwBer1zgT/6twR10QXqaQC14PsgQHUXMZ
         t/BLd6gIsqlSX/Nr5tgxlFg56ZdIs5nQdcx0RLT8QIODN2hDm+zeK52ArNVzOiRpY40O
         cIrw==
X-Gm-Message-State: AD7BkJIa8LzEOvRk2c2VsLiE7zfEIv/OHUVRseV9bGbzF/OfgG9FFeBXQP9Z8nwVnu1udQ==
X-Received: by 10.66.61.236 with SMTP id t12mr33303799par.83.1459185905167;
        Mon, 28 Mar 2016 10:25:05 -0700 (PDT)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id 9sm37125513pfm.10.2016.03.28.10.25.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2016 10:25:03 -0700 (PDT)
Message-ID: <56F968EE.1000307@gmail.com>
Date:   Mon, 28 Mar 2016 10:25:02 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 07/31] Add mips-specific parity functions
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com> <56F7785F.1090101@gmail.com>
In-Reply-To: <56F7785F.1090101@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52713
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

On 03/26/2016 11:06 PM, zhaoxiu.zeng wrote:
> From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
>

There is nothing MIPS specific here.  Why not put it in asm-generic or 
some similar place where it can be shared by all architectures?

Also, are you sure __builtin_popcount() is available on all GCC versions 
that are supported for building the kernel?

David Daney


> Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
> ---
>   arch/mips/include/asm/arch_parity.h | 44 +++++++++++++++++++++++++++++++++++++
>   arch/mips/include/asm/bitops.h      |  3 +++
>   2 files changed, 47 insertions(+)
>   create mode 100644 arch/mips/include/asm/arch_parity.h
>
> diff --git a/arch/mips/include/asm/arch_parity.h b/arch/mips/include/asm/arch_parity.h
> new file mode 100644
> index 0000000..23b3c23
> --- /dev/null
> +++ b/arch/mips/include/asm/arch_parity.h
> @@ -0,0 +1,44 @@
> +/*
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + */
> +#ifndef _ASM_ARCH_PARITY_H
> +#define _ASM_ARCH_PARITY_H
> +
> +#ifdef ARCH_HAS_USABLE_BUILTIN_POPCOUNT
> +
> +#include <asm/types.h>
> +
> +static inline unsigned int __arch_parity32(unsigned int w)
> +{
> +	return __builtin_popcount(w) & 1;
> +}
> +
> +static inline unsigned int __arch_parity16(unsigned int w)
> +{
> +	return __arch_parity32(w & 0xffff);
> +}
> +
> +static inline unsigned int __arch_parity8(unsigned int w)
> +{
> +	return __arch_parity32(w & 0xff);
> +}
> +
> +static inline unsigned int __arch_parity4(unsigned int w)
> +{
> +	return __arch_parity32(w & 0xf);
> +}
> +
> +static inline unsigned int __arch_parity64(__u64 w)
> +{
> +	return (unsigned int)__builtin_popcountll(w) & 1;
> +}
> +
> +#else
> +#include <asm-generic/bitops/arch_hweight.h>
> +#include <asm-generic/bitops/arch_parity.h>
> +#endif
> +
> +#endif /* _ASM_ARCH_PARITY_H */
> diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
> index ce9666c..0b87734 100644
> --- a/arch/mips/include/asm/bitops.h
> +++ b/arch/mips/include/asm/bitops.h
> @@ -626,6 +626,9 @@ static inline int ffs(int word)
>   #include <asm/arch_hweight.h>
>   #include <asm-generic/bitops/const_hweight.h>
>
> +#include <asm/arch_parity.h>
> +#include <asm-generic/bitops/const_parity.h>
> +
>   #include <asm-generic/bitops/le.h>
>   #include <asm-generic/bitops/ext2-atomic.h>
>
>
