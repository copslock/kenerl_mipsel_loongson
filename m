Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2018 00:21:34 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:47594 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994717AbeFFWV0iAiOl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2018 00:21:26 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 06 Jun 2018 22:21:21 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Wed, 6 Jun
 2018 15:21:29 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Wed, 6 Jun
 2018 15:21:29 -0700
Date:   Wed, 6 Jun 2018 15:21:20 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     "Steven J. Hill" <steven.hill@cavium.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v7 1/8] MIPS: Octeon: Remove unused CIU types and macros.
Message-ID: <20180606222120.horfktiqm7yeb7p4@pburton-laptop>
References: <1528176297-21697-1-git-send-email-steven.hill@cavium.com>
 <1528176297-21697-2-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1528176297-21697-2-git-send-email-steven.hill@cavium.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1528323680-298553-32184-13596-1
X-BESS-VER: 2018.7-r1805312038
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193800
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: steven.hill@cavium.com,linux-mips@linux-mips.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Steven,

On Tue, Jun 05, 2018 at 12:24:50AM -0500, Steven J. Hill wrote:
>  static inline uint64_t CVMX_CIU_PP_POKEX(unsigned long offset)
>  {
> -	switch (cvmx_get_octeon_family()) {
> -	case OCTEON_CN30XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN52XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CNF71XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN61XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN70XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN31XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN50XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN38XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN58XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN56XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN66XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN63XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
> -	case OCTEON_CN68XX & OCTEON_FAMILY_MASK:
> -		return CVMX_ADD_IO_SEG(0x0001070100100200ull) + (offset) * 8;
> -	case OCTEON_CNF75XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN73XX & OCTEON_FAMILY_MASK:
> -	case OCTEON_CN78XX & OCTEON_FAMILY_MASK:
> +	switch (cvmx_get_octeon_family() & OCTEON_FAMILY_MASK) {

cvmx_get_octeon_family() already returns a value which is ANDed with
OCTEON_FAMILY_MASK, so why add that here?

> +	case OCTEON_CNF75XX:
> +	case OCTEON_CN73XX:
> +	case OCTEON_CN78XX:

These OCTEON_* values on the other hand set bits outside of those set in
OCTEON_FAMILY_MASK, such as OM_IGNORE_REVISION, so why did you remove
the AND for each case?

This is just going to incorrectly cause the default case to always be
taken & presumably break the systems that use the non-default cases.

The same problems are repeated in the CVMX_CIU_MBOX_SETX() &
CVMX_CIU_WDOGX() functions.

I verified that this patch results in a kernel binary containing almost
4KB less code than before, primarily in the Octeon watchdog driver,
which isn't right for a patch that's meant to be removing only unused
code.

Thanks,
    Paul

>  		return CVMX_ADD_IO_SEG(0x0001010000030000ull) + (offset) * 8;
> +	case OCTEON_CN68XX:
> +		return CVMX_ADD_IO_SEG(0x0001070100100200ull) + (offset) * 8;
> +	default:
> +		return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
>  	}
> -	return CVMX_ADD_IO_SEG(0x0001070000000580ull) + (offset) * 8;
>  }
