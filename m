Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:41:07 +0200 (CEST)
Received: from userp2130.oracle.com ([156.151.31.86]:38004 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990409AbeENGk7ktmfc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 May 2018 08:40:59 +0200
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w49E1lDg116742;
        Wed, 9 May 2018 14:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=ENy3aB6ke7maKFUKcd+EiGeFThI7TgqOlReo4HAWelQ=;
 b=o6cvJVvXdHO7xrByj/lozWkUqwkZV1JODcI9EbBULezyQc96XaqgCaEskbw+Pc73lDZD
 9Uqmjcpywm1WO8MUBuCViH9c0MwS7I0MpU8leTXhjXC8tBLTbaDjXO8siNas+VX2XkGv
 +BBGlWS0/2L+HF852rqZVMaCMvYRjPBF1yJzrSfYMpNtGros2vTFt12hk7xu0ln8W3n+
 fcbs9Z06+8uThr1PLRAZDGHyUEHFijXSE8u5NHZtCzgk3Q3Y/EHR+LmvPezbXOkkxJuo
 DpK0gOmZmatCXBMy6CPOt6MXYhYRbMAbzGmQSLD1QI4M50Z/KGbU6AyaXbiDQccN0PFa Bg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2hs426nv25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 May 2018 14:01:48 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w49E1jGC030468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 May 2018 14:01:45 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w49E1i3S003791;
        Wed, 9 May 2018 14:01:44 GMT
Received: from mwanda (/197.254.35.146)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 May 2018 07:01:43 -0700
Date:   Wed, 9 May 2018 17:01:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: boston: fix memory leak of 'onecell' on error
 return paths
Message-ID: <20180509140135.4dndt3baomtxups5@mwanda>
References: <20180509134031.11611-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509134031.11611-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8887 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805090133
Return-Path: <dan.carpenter@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan.carpenter@oracle.com
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

On Wed, May 09, 2018 at 02:40:31PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are several error return paths that don't free up onecell
> and hence we have some memory leaks. Add an error exit path that
> kfree's onecell to fix the leaks.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/clk/imgtec/clk-boston.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
> index 15af423cc0c9..d6bc468ff551 100644
> --- a/drivers/clk/imgtec/clk-boston.c
> +++ b/drivers/clk/imgtec/clk-boston.c
> @@ -73,27 +73,34 @@ static void __init clk_boston_setup(struct device_node *np)
>  	hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
>  	if (IS_ERR(hw)) {
>  		pr_err("failed to register input clock: %ld\n", PTR_ERR(hw));
> -		return;
> +		goto error;

I hate vague label names like "error" and "out"...

There are a bunch of other resources that we should free if we decide
it's worth freeing things.  Can this even boot without the clk?  When
the label names says what is freed, then you mentally only have to keep
track of the most recently allocated resource.  So if

	hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);

succeeds then the next goto is going to "goto free_clk_input;".

regards,
dan carpenter
