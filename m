Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 18:25:36 +0100 (CET)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34365 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006879AbaKXRZeuEC0b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 18:25:34 +0100
Received: by mail-ig0-f176.google.com with SMTP id l13so3736583iga.15
        for <multiple recipients>; Mon, 24 Nov 2014 09:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4fI/e02PE3t89o4ZB6C3rzS7nxjCa3qxDd2iJUkwUHc=;
        b=s5g9IMDlrsduGQnQ+gGRLXrcmNF9ftbygUl6NQYdIXirDcA0W6yLZ/LARnSGFBDxQS
         uzqTPJRiEYUEb4gb/BBsItILXTwNgwCmXE/UgxagO7j7p/bT/oaE8hUZTCI9E8Elk0Z7
         nGjLZ1j8AVFVRFEHp44Ry541WR4Zc7p0J0xrbRjTegpTPm5BQEMIqT9f6n2daY9kVPju
         HzofEPAtE0l4d8FGwdayvp5mYPF0N+3S8EbIxbxR6fwohHfKCOP1hkCYxjX2GNBO7hi6
         aKm5dVdiHgwIbZlukCNuvYzPMuArH85yucLJIBjS0w/fyO9qrTxF0r1xQGkZSmS81f6r
         MiNg==
X-Received: by 10.50.114.199 with SMTP id ji7mr12160442igb.49.1416849928615;
        Mon, 24 Nov 2014 09:25:28 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id kb7sm4770322igb.16.2014.11.24.09.25.27
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 09:25:28 -0800 (PST)
Message-ID: <54736A06.9070206@gmail.com>
Date:   Mon, 24 Nov 2014 09:25:26 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     James Cowgill <James.Cowgill@imgtec.com>,
        "Herrmann, Andreas" <Andreas.Herrmann@caviumnetworks.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        David Daney <david.daney@cavium.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH] MIPS: octeon: Add support for the UBNT E200 board
References: <1416837096-52243-1-git-send-email-James.Cowgill@imgtec.com>
In-Reply-To: <1416837096-52243-1-git-send-email-James.Cowgill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44383
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

On 11/24/2014 05:51 AM, James Cowgill wrote:
> From: Markos Chandras <markos.chandras@imgtec.com>
>
> Add support for the UBNT E200 board (EdgeRouter/EdgeRouter Pro 8 port).
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>

NACK.

As far as I know, these boards have a boot loader that supplies a 
correct device tree, there should be no need to hack up the kernel like 
this.

As far as I know, Andreas is running a kernel.org kernel on these boards 
without anything like this.

Andreas, can you confirm this?

Thanks,
David Daney

> ---
>   arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 3 +++
>   arch/mips/include/asm/octeon/cvmx-bootinfo.h          | 2 ++
>   2 files changed, 5 insertions(+)
>
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> index 5dfef84..69ba6fb 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> @@ -186,6 +186,8 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
>   			return 7 - ipd_port;
>   		else
>   			return -1;
> +	case CVMX_BOARD_TYPE_UBNT_E200:
> +		return -1;
>   	case CVMX_BOARD_TYPE_CUST_DSR1000N:
>   		/*
>   		 * Port 2 connects to Broadcom PHY (B5081). Other ports (0-1)
> @@ -759,6 +761,7 @@ enum cvmx_helper_board_usb_clock_types __cvmx_helper_board_usb_get_clock_type(vo
>   	case CVMX_BOARD_TYPE_LANAI2_G:
>   	case CVMX_BOARD_TYPE_NIC10E_66:
>   	case CVMX_BOARD_TYPE_UBNT_E100:
> +	case CVMX_BOARD_TYPE_UBNT_E200:
>   	case CVMX_BOARD_TYPE_CUST_DSR1000N:
>   		return USB_CLOCK_TYPE_CRYSTAL_12;
>   	case CVMX_BOARD_TYPE_NIC10E:
> diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> index 2298199..0567847 100644
> --- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> +++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> @@ -228,6 +228,7 @@ enum cvmx_board_types_enum {
>   	 */
>   	CVMX_BOARD_TYPE_CUST_PRIVATE_MIN = 20001,
>   	CVMX_BOARD_TYPE_UBNT_E100 = 20002,
> +	CVMX_BOARD_TYPE_UBNT_E200 = 20003,
>   	CVMX_BOARD_TYPE_CUST_DSR1000N = 20006,
>   	CVMX_BOARD_TYPE_CUST_PRIVATE_MAX = 30000,
>
> @@ -328,6 +329,7 @@ static inline const char *cvmx_board_type_to_string(enum
>   		    /* Customer private range */
>   		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MIN)
>   		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E100)
> +		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_UBNT_E200)
>   		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_DSR1000N)
>   		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CUST_PRIVATE_MAX)
>   	}
>
