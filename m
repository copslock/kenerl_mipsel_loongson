Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jan 2018 09:56:45 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:54737 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990409AbeAHI4iH9U0I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Jan 2018 09:56:38 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 08 Jan 2018 08:56:14 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 8 Jan 2018
 00:55:50 -0800
Subject: Re: [PATCH] MAINTAINERS: Add James as MIPS co-maintainer
To:     James Hogan <jhogan@kernel.org>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@mips.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <john@phrozen.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20180105213647.28850-1-jhogan@kernel.org>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <5f7e9f47-c077-662e-eb6b-f9c8a2cdd339@mips.com>
Date:   Mon, 8 Jan 2018 08:55:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20180105213647.28850-1-jhogan@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1515401774-298554-7132-131400-2
X-BESS-VER: 2017.16-r1712230000
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188758
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Hi James

On 05/01/18 21:36, James Hogan wrote:
> I've been taking on some co-maintainer duties already, so lets make it
> official in the MAINTAINERS file.
> 
> Link: https://lkml.kernel.org/r/33db77a2-32e4-6b2c-d463-9d116ba55623@imgtec.com
> Link: https://lkml.kernel.org/r/20171207110549.GM27409@jhogan-linux.mipstec.com
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: David Daney <david.daney@cavium.com>
> Cc: John Crispin <john@phrozen.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Matt Redfearn <matt.redfearn@mips.com>
> Cc: linux-mips@linux-mips.org

Yes please! I think with you and Ralf on the case we should be able to 
get patches merged much quicker! This would be great!

Acked-by: Matt Redfearn <matt.redfearn@mips.com>

Matt

> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d3d750b19c0..61bccbd3715f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8983,6 +8983,7 @@ F:	drivers/usb/image/microtek.*
>   
>   MIPS
>   M:	Ralf Baechle <ralf@linux-mips.org>
> +M:	James Hogan <jhogan@kernel.org>
>   L:	linux-mips@linux-mips.org
>   W:	http://www.linux-mips.org/
>   T:	git git://git.linux-mips.org/pub/scm/ralf/linux.git
> 
