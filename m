Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2015 22:07:09 +0200 (CEST)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34990 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012670AbbHKUHIAmzRF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2015 22:07:08 +0200
Received: by igbjg10 with SMTP id jg10so29628850igb.0;
        Tue, 11 Aug 2015 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8iJS4OACytb8jWUlrPLmrsICq4MvCg+HlhRG8uL2Lrc=;
        b=XzB3BGEeXYWBkDK8oJ/FCuiOKoG762nUVO1BOabOpMlqwTQNeKvpY/dPMzhs1frN1J
         IIACU6al1VafcI1vgOf4mDcNax9M/Kgm1V4m4XEtuY3Lxw7XpjC6ePWaztMmgKTGpFj0
         J+6tvQwYaSiodyz/OTn+IYV9IyxnzuonAsruVIPVuyZaxA5W3WTmKUHCmc41xRexK+ov
         5wMmLUcISMLaaAaRPoVwsL9kPaHpS8J5iGKJCwzp6lv+ulKrLx8pZu2qxVzWnyrcfdBZ
         4cf7KE7aAxgOQymF5jBUqEZEP5SfLn45yOHogxHQOnyuGn8hwRwaGgluazLjdBpj2YnJ
         BuBQ==
X-Received: by 10.50.110.6 with SMTP id hw6mr11311293igb.76.1439323622221;
        Tue, 11 Aug 2015 13:07:02 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id 65sm2245673iod.22.2015.08.11.13.07.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 13:07:01 -0700 (PDT)
Message-ID: <55CA55E3.70202@gmail.com>
Date:   Tue, 11 Aug 2015 13:06:59 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@nokia.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: OCTEON: fix management port MII address on Kontron
 S1901
References: <1439279788-2050-1-git-send-email-aaro.koskinen@nokia.com>
In-Reply-To: <1439279788-2050-1-git-send-email-aaro.koskinen@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48772
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

On 08/11/2015 12:56 AM, Aaro Koskinen wrote:
> Management port MII address is incorrect on Kontron S1901 resulting
> in broken networking. Fix by providing definitions for the in-tree DT
> pruning code.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

This seems reasonable, I cannot test it, but ...

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 6 ++++++
>   arch/mips/include/asm/octeon/cvmx-bootinfo.h          | 2 ++
>   2 files changed, 8 insertions(+)
>
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> index 9eb0fee..36e30d6 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> @@ -195,6 +195,12 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
>   			return 8;
>   		else
>   			return -1;
> +	case CVMX_BOARD_TYPE_KONTRON_S1901:
> +		if (ipd_port == CVMX_HELPER_BOARD_MGMT_IPD_PORT)
> +			return 1;
> +		else
> +			return -1;
> +
>   	}
>
>   	/* Some unknown board. Somebody forgot to update this function... */
> diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> index c373d95..d92cf59 100644
> --- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> +++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> @@ -284,6 +284,7 @@ enum cvmx_board_types_enum {
>   	CVMX_BOARD_TYPE_CUST_PRIVATE_MIN = 20001,
>   	CVMX_BOARD_TYPE_UBNT_E100 = 20002,
>   	CVMX_BOARD_TYPE_CUST_DSR1000N = 20006,
> +	CVMX_BOARD_TYPE_KONTRON_S1901 = 21901,
>   	CVMX_BOARD_TYPE_CUST_PRIVATE_MAX = 30000,
>
>   	/* The remaining range is reserved for future use. */
> @@ -384,6 +385,7 @@ static inline const char *cvmx_board_type_to_string(enum
>   		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MIN)
>   		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E100)
>   		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_DSR1000N)
> +		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_KONTRON_S1901)
>   		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
>   	}
>   	return "Unsupported Board";
>
