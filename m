Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 22:56:39 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:40131 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992615AbeAEV4YrVs-g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 22:56:24 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 05 Jan 2018 21:55:49 +0000
Received: from localhost (10.20.1.18) by mips01.mipstec.com (10.20.43.31) with
 Microsoft SMTP Server id 14.3.361.1; Fri, 5 Jan 2018 13:55:46 -0800
Date:   Fri, 5 Jan 2018 13:56:54 -0800
From:   Paul Burton <paul.burton@mips.com>
To:     James Hogan <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "David Daney" <david.daney@cavium.com>,
        John Crispin <john@phrozen.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: Re: [PATCH] MAINTAINERS: Add James as MIPS co-maintainer
Message-ID: <20180105215654.bm2dasgyqy5pj6wr@pburton-laptop>
References: <20180105213647.28850-1-jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180105213647.28850-1-jhogan@kernel.org>
User-Agent: NeoMutt/20171215
X-BESS-ID: 1515189349-452060-10411-24855-1
X-BESS-VER: 2017.17.1-r1712222329
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188692
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61940
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

Hi James,

On Fri, Jan 05, 2018 at 09:36:47PM +0000, James Hogan wrote:
> I've been taking on some co-maintainer duties already, so lets make it
> official in the MAINTAINERS file.

Yes please! Especially if this means more consistent & responsive
maintainership in between merge windows I'm all for it.

I'm not sure which is more appropriate here, but please consider either
of these valid:

  Acked-by: Paul Burton <paul.burton@mips.com>
  Reviewed-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

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
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d3d750b19c0..61bccbd3715f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8983,6 +8983,7 @@ F:	drivers/usb/image/microtek.*
>  
>  MIPS
>  M:	Ralf Baechle <ralf@linux-mips.org>
> +M:	James Hogan <jhogan@kernel.org>
>  L:	linux-mips@linux-mips.org
>  W:	http://www.linux-mips.org/
>  T:	git git://git.linux-mips.org/pub/scm/ralf/linux.git
> -- 
> 2.13.6
> 
