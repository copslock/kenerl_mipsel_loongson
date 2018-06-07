Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2018 02:18:59 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:56810 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994719AbeFGAStkV1qU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2018 02:18:49 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 07 Jun 2018 00:18:40 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Wed, 6 Jun
 2018 17:18:48 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Wed, 6 Jun
 2018 17:18:48 -0700
Date:   Wed, 6 Jun 2018 17:18:39 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     "Steven J. Hill" <steven.hill@cavium.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v7 3/8] MIPS: Octeon: Properly use sysinfo header file.
Message-ID: <20180607001839.fzfwnzi2qbvlpydm@pburton-laptop>
References: <1528176297-21697-1-git-send-email-steven.hill@cavium.com>
 <1528176297-21697-4-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1528176297-21697-4-git-send-email-steven.hill@cavium.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1528330720-637137-27058-130036-1
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
X-archive-position: 64204
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

On Tue, Jun 05, 2018 at 12:24:52AM -0500, Steven J. Hill wrote:
> Clean up usage of 'cvmx-sysinfo.h' header file. Also sort the
> inclusing of header files and update copyrights.

Inclusion? Including?

What was wrong with the existing usage of cvmx-sysinfo.h?

Why are these 3 changes being made as one patch?

This commit message doesn't really say anything useful, and other
patches in the series have the same problem.

> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> index ab8362e..971c03e 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> @@ -4,7 +4,7 @@
>   * Contact: support@caviumnetworks.com
>   * This file is part of the OCTEON SDK
>   *
> - * Copyright (c) 2003-2008 Cavium Networks
> + * Copyright (C) 2003-2018 Cavium, Inc.

All these copyright changes:

  1) Make it more difficult to read the patch & see what the actual code
     changes are, and;

  2) Seem pretty unnecessary especially for something as trivial as
     moving around a bunch of header inclusions.

> diff --git a/arch/mips/include/asm/octeon/cvmx-sysinfo.h b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
> index c6c3ee3..f1a11a9 100644
> --- a/arch/mips/include/asm/octeon/cvmx-sysinfo.h
> +++ b/arch/mips/include/asm/octeon/cvmx-sysinfo.h
> @@ -4,7 +4,7 @@
>   * Contact: support@caviumnetworks.com
>   * This file is part of the OCTEON SDK
>   *
> - * Copyright (c) 2003-2016 Cavium, Inc.
> + * Copyright (C) 2003-2018 Cavium, Inc.
>   *
>   * This file is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License, Version 2, as
> @@ -32,7 +32,7 @@
>  #ifndef __CVMX_SYSINFO_H__
>  #define __CVMX_SYSINFO_H__
>  
> -#include "cvmx-coremask.h"
> +#include<asm/octeon/cvmx-bootinfo.h>

Space between #include & the '<' please.

Also why is this change being made at all? Both before and after this
series cvmx-sysinfo.h doesn't use anything from cvmx-bootinfo.h, but it
does use struct cvmx_coremask from cvmx-coremask.h. Therefore including
cvmx-coremask.h seems like the right thing to do, although it would look
better to do so using <asm/octeon/cvmx-coremask.h>.

Thanks,
    Paul
