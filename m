Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Apr 2018 22:09:54 +0200 (CEST)
Received: from aserp2120.oracle.com ([141.146.126.78]:60788 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993488AbeDWUJrdWeEw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Apr 2018 22:09:47 +0200
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w3NK5m26139152;
        Mon, 23 Apr 2018 20:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=htCMpyP057FQjzTc/17kXiwl/89OsvhoSnSV6Sj5Kjc=;
 b=FSE6D3W/+65C/Iq08kqY8q55UKF/TudKxxivoRRMdfe1UIRJPJ9zdnIEwA+zQkzth9hL
 //T6q1RauxqHp5b23kImOIMvqsRRMAY6D/OGpsLlzPO5rvXhVBfs0FOV7YoqoNpWzj2D
 k1ctIpEWrhzrUWgnNEFSlZvbHCenNTQIgQRP8DN5HAgE/DcJbs5M2JS6RS0eMKDg15zi
 vKwyd3whf1YX+yBAAxNid+a91uXRTdkWq05vvhl6owKBw9dwmF/y04gyb1sg7ggQQoi7
 O8262rJMtQXWQN7Qny1I7632L6qxRl6hJaNXgqGWx7KKItK9JSJftUvILk3U8zK3WZkG WA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2hfw9a71ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Apr 2018 20:09:37 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w3NK9Ys6006127
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Apr 2018 20:09:35 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w3NK9W5l005945;
        Mon, 23 Apr 2018 20:09:34 GMT
Received: from char.us.oracle.com (/10.137.176.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Apr 2018 13:09:32 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 0823D6A0057; Mon, 23 Apr 2018 16:09:30 -0400 (EDT)
Date:   Mon, 23 Apr 2018 16:09:30 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>, sstabellini@kernel.org
Cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/12] arm: don't build swiotlb by default
Message-ID: <20180423200930.GB5215@char.us.oracle.com>
References: <20180423170419.20330-1-hch@lst.de>
 <20180423170419.20330-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423170419.20330-11-hch@lst.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=787
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804230200
Return-Path: <konrad.wilk@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad.wilk@oracle.com
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

On Mon, Apr 23, 2018 at 07:04:17PM +0200, Christoph Hellwig wrote:
> swiotlb is only used as a library of helper for xen-swiotlb if Xen support
> is enabled on arm, so don't build it by default.
> 

CCing Stefano
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index aa1c187d756d..90b81a3a28a7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1774,7 +1774,7 @@ config SECCOMP
>  	  defined by each seccomp mode.
>  
>  config SWIOTLB
> -	def_bool y
> +	bool
>  
>  config PARAVIRT
>  	bool "Enable paravirtualization code"
> @@ -1807,6 +1807,7 @@ config XEN
>  	depends on MMU
>  	select ARCH_DMA_ADDR_T_64BIT
>  	select ARM_PSCI
> +	select SWIOTLB
>  	select SWIOTLB_XEN
>  	select PARAVIRT
>  	help
> -- 
> 2.17.0
> 
