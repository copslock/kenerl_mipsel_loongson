Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2014 11:45:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:64399 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6835371AbaEGJprXFRSd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2014 11:45:47 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 152C05CCD73A2;
        Wed,  7 May 2014 10:45:38 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 7 May
 2014 10:45:40 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 7 May 2014 10:45:39 +0100
Received: from [192.168.154.35] (192.168.154.35) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 7 May
 2014 10:45:39 +0100
Message-ID: <536A00C3.9020701@imgtec.com>
Date:   Wed, 7 May 2014 10:45:39 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Himangi Saraogi <himangi774@gmail.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
CC:     <julia.lawall@lip6.fr>
Subject: Re: [PATCH] MIPS: Introduce the use of the managed version of kzalloc
References: <20140507044211.GA3158@himangi-Dell>
In-Reply-To: <20140507044211.GA3158@himangi-Dell>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.35]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

Hi,

On 05/07/2014 05:43 AM, Himangi Saraogi wrote:
> This patch moves data allocated using kzalloc to managed data allocated
> using devm_kzalloc and cleans now unnecessary kfrees in probe and remove
> functions.The labels out and out_mem are also removed as they are no
> longer required.
> 
> The following Coccinelle semantic patch was used for making the change:
> [..]
> 
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> ---
>  arch/mips/mti-sead3/sead3-i2c-drv.c | 37 ++++++++++++++-----------------------
>  1 file changed, 14 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/mips/mti-sead3/sead3-i2c-drv.c b/arch/mips/mti-sead3/sead3-i2c-drv.c
> index 1f787a6..4d72e0e 100644
> --- a/arch/mips/mti-sead3/sead3-i2c-drv.c
> +++ b/arch/mips/mti-sead3/sead3-i2c-drv.c
> @@ -304,22 +304,18 @@ static int sead3_i2c_platform_probe(struct platform_device *pdev)
>  	int ret;
>[...]
> -	return ret;
> +	if (ret)
> +		return ret;
> +	
     ^^^^ trailing whitespace

Apart from that, the patch seems to be ok. Thanks!

Tested-by: Markos Chandras <markos.chandras@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>

-- 
markos
