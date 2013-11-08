Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2013 22:46:24 +0100 (CET)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:40682 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815753Ab3KHVqWr2DPX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Nov 2013 22:46:22 +0100
Received: by mail-ie0-f169.google.com with SMTP id ar20so4368825iec.28
        for <multiple recipients>; Fri, 08 Nov 2013 13:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=X51N5pxR8VdEoAVORhcR/FuPoKLJa/HmHyk4Bz5bhKQ=;
        b=ftxqI1Lrs6Yzf+AqUTqW34wDNkvi4A2IeJHSg93IAOK4KCRFL/lnnXpTr/eUPicJlF
         w44qmZ9DMdNzHjmpH7gzcfv0lD19MyCOPepnLCgg3FF/lMN0a+SHowXZsNGRain9yZJg
         v2vj4DbfhmksNP0+Xu5LylRVfEyYvAAdF8zJrdsF1CwNKxaRyATK+ZdSOL8DZdPxtN2d
         /h+I3i6tfWETPDMyo2dXWOnWlI1kKOMn6m4J/jEhkOZvxyZkdbl7rxX4ZjRYqOb620et
         +X7olv4zjdPm+ZXzGtRWFKRiudLaQYA8IRHkOec5D4jx9nj9pMLIwlJgfgF/ayouqAUM
         XK/g==
X-Received: by 10.50.129.39 with SMTP id nt7mr4051799igb.13.1383947176608;
        Fri, 08 Nov 2013 13:46:16 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id y10sm5157881igl.4.2013.11.08.13.46.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 08 Nov 2013 13:46:16 -0800 (PST)
Message-ID: <527D5BA6.3070300@gmail.com>
Date:   Fri, 08 Nov 2013 13:46:14 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@nsn.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v2 2/2] MIPS: cavium-octeon: fix early boot hang on EBH5600
 board
References: <1383318364-30312-1-git-send-email-aaro.koskinen@nsn.com> <1383318364-30312-2-git-send-email-aaro.koskinen@nsn.com>
In-Reply-To: <1383318364-30312-2-git-send-email-aaro.koskinen@nsn.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38493
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

On 11/01/2013 08:06 AM, Aaro Koskinen wrote:
> The boot hangs early on EBH5600 board when octeon_fdt_pip_iface() is
> trying enumerate a non-existant interface. The actual hang happens in
> cvmx_helper_interface_get_mode():
>
> 	mode.u64 = cvmx_read_csr(CVMX_GMXX_INF_MODE(interface));
>
> when interface == 4. We can avoid this situation by first checking that
> the interface exists in the DTB.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>

Thanks for finding this,  tested and ...

Acked-by: David Daney <david.daney@cavium.com>


Ralf:  Please apply.

Aaro: Suggest stable branches that this is a candidate for.


> ---
>
> 	v2: Provide more detailed problem description.
>
>   arch/mips/cavium-octeon/octeon-platform.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index 1830874..f68c75a 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -336,14 +336,14 @@ static void __init octeon_fdt_pip_iface(int pip, int idx, u64 *pmac)
>   	int p;
>   	int count = 0;
>
> -	if (cvmx_helper_interface_enumerate(idx) == 0)
> -		count = cvmx_helper_ports_on_interface(idx);
> -
>   	snprintf(name_buffer, sizeof(name_buffer), "interface@%d", idx);
>   	iface = fdt_subnode_offset(initial_boot_params, pip, name_buffer);
>   	if (iface < 0)
>   		return;
>
> +	if (cvmx_helper_interface_enumerate(idx) == 0)
> +		count = cvmx_helper_ports_on_interface(idx);
> +
>   	for (p = 0; p < 16; p++)
>   		octeon_fdt_pip_port(iface, idx, p, count - 1, pmac);
>   }
>
