Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 00:49:03 +0100 (CET)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40203 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008133AbbCEXtAnjpMR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 00:49:00 +0100
Received: by iecrp18 with SMTP id rp18so13449803iec.7;
        Thu, 05 Mar 2015 15:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=EDhJWDocA03GJ/IGyLOz+5mmIbeW3P0r1bmt43JwU14=;
        b=bAUnOg/dV5x5qPUjS3YqWarLi0FfWkboq8D0jlsK2+F+aC0SxkIbMkcbnh5z6Dl5pQ
         /tVUHX6Kq0YHq2Zp2KKOSir0d+WQnl356FBSz0QE4A6F4QrfR76pry83pXmNXNXdpAzn
         q5DY+R4WN3XQlBinikhMS2TldUCC4sv1fkmozQ+HGHLCO0i2ZBp0HJP/n+hwOXHsj0l8
         nYyeQkkZjZxl4+ooQ1ytTwsTR4Q9K902R6s085W0X1YoYWtstJ+TEskNJtiq/+9sMeLh
         jIDBzwYePKBCOGB8JVLvhophqoYzNLjXgN8W7EvKRQBZUn8IPxxzI/Fs7Zewf5a4E/Ik
         5WxA==
X-Received: by 10.50.20.228 with SMTP id q4mr4126196ige.1.1425599334299;
        Thu, 05 Mar 2015 15:48:54 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id e3sm13809346igg.16.2015.03.05.15.48.52
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Mar 2015 15:48:53 -0800 (PST)
Message-ID: <54F8EB64.403@gmail.com>
Date:   Thu, 05 Mar 2015 15:48:52 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aleksey Makarov <aleksey.makarov@auriga.com>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: OCTEON: Use correct CSR to soft reset
References: <1425567974-31912-1-git-send-email-aleksey.makarov@auriga.com>
In-Reply-To: <1425567974-31912-1-git-send-email-aleksey.makarov@auriga.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46216
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

On 03/05/2015 07:06 AM, Aleksey Makarov wrote:
> From: Chandrakala Chavva <cchavva@caviumnetworks.com>
>
> This fixes reboot for Octeon III boards
>
> Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>

Let's make a change to this patch...

> ---
>   arch/mips/cavium-octeon/setup.c     | 5 ++++-
>   arch/mips/include/asm/octeon/cvmx.h | 6 +++++-
>   2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index 01130e9..73348af 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -416,7 +416,10 @@ static void octeon_restart(char *command)
>
>   	mb();
>   	while (1)
> -		cvmx_write_csr(CVMX_CIU_SOFT_RST, 1);
> +		if (OCTEON_IS_OCTEON3())
> +			cvmx_write_csr(CVMX_RST_SOFT_RST, 1);
> +		else
> +			cvmx_write_csr(CVMX_CIU_SOFT_RST, 1);
>   }
>
>
> diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
> index 33db1c8..fb575d7 100644
> --- a/arch/mips/include/asm/octeon/cvmx.h
> +++ b/arch/mips/include/asm/octeon/cvmx.h
> @@ -66,6 +66,7 @@ enum cvmx_mips_space {
>   #include <asm/octeon/cvmx-led-defs.h>
>   #include <asm/octeon/cvmx-mio-defs.h>
>   #include <asm/octeon/cvmx-pow-defs.h>
> +#include <asm/octeon/cvmx-rst-defs.h>
>
>   #include <asm/octeon/cvmx-bootinfo.h>
>   #include <asm/octeon/cvmx-bootmem.h>
> @@ -441,7 +442,10 @@ static inline void cvmx_reset_octeon(void)
>   	union cvmx_ciu_soft_rst ciu_soft_rst;
>   	ciu_soft_rst.u64 = 0;
>   	ciu_soft_rst.s.soft_rst = 1;
> -	cvmx_write_csr(CVMX_CIU_SOFT_RST, ciu_soft_rst.u64);
> +	if (OCTEON_IS_OCTEON3())
> +		cvmx_write_csr(CVMX_RST_SOFT_RST, ciu_soft_rst.u64);
> +	else
> +		cvmx_write_csr(CVMX_CIU_SOFT_RST, ciu_soft_rst.u64);
>   }


cvmx_reset_octeon() is unused in the kernel.  So instead of patching it 
up, remove it altogether, thus removing a little bit of ugliness from 
the world.

David Daney
