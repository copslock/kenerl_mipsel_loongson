Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2017 22:28:30 +0100 (CET)
Received: from vmicros1.altlinux.org ([194.107.17.57]:49030 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993201AbdBTV2U0tr04 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2017 22:28:20 +0100
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id BEBFA72CA6D;
        Tue, 21 Feb 2017 00:28:14 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 942C27CCAAE; Tue, 21 Feb 2017 00:28:14 +0300 (MSK)
Date:   Tue, 21 Feb 2017 00:28:14 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Lauro Ramos Venancio <lauro.venancio@openbossa.org>,
        Aloisio Almeida Jr <aloisio.almeida@openbossa.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-wireless@vger.kernel.org, x86@kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] uapi: fix definition of struct sockaddr_nfc_llcp on x32 and mips n32
Message-ID: <20170220212814.GA13795@altlinux.org>
References: <20170220181533.GA11185@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170220181533.GA11185@altlinux.org>
Return-Path: <ldv@altlinux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ldv@altlinux.org
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

On Mon, Feb 20, 2017 at 09:15:33PM +0300, Dmitry V. Levin wrote:
> Replace size_t with __kernel_size_t to fix definition of struct
> sockaddr_nfc_llcp on architectures like x32 and mips n32 where
> sizeof(size_t) < sizeof(__kernel_size_t).
> 
> This also fixes the following linux/nfc.h userspace compilation error:
> 
> /usr/include/linux/nfc.h:279:2: error: unknown type name 'size_t'
>   size_t service_name_len;
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  include/uapi/linux/nfc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/nfc.h b/include/uapi/linux/nfc.h
> index 399f39f..f8ccc12 100644
> --- a/include/uapi/linux/nfc.h
> +++ b/include/uapi/linux/nfc.h
> @@ -276,7 +276,7 @@ struct sockaddr_nfc_llcp {
>  	__u8 dsap; /* Destination SAP, if known */
>  	__u8 ssap; /* Source SAP to be bound to */
>  	char service_name[NFC_LLCP_MAX_SERVICE_NAME]; /* Service name URI */;
> -	size_t service_name_len;
> +	__kernel_size_t service_name_len;
>  };
>  
>  /* NFC socket protocols */

Unfortunately, this is not the right fix for the problem.

It was definitely a bad idea to use architecture dependent types
in the definition of struct sockaddr_nfc_llcp.  Somebody will have
to implement a compat layer to make it work properly with x86, x32,
and other compat personalities.


-- 
ldv
