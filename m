Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 18:50:51 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:55180 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990511AbdKQRuohDgFR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 18:50:44 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 17 Nov 2017 17:50:32 +0000
Received: from [10.20.78.89] (10.20.78.89) by mips01.mipstec.com (10.20.43.31)
 with Microsoft SMTP Server id 14.3.361.1; Fri, 17 Nov 2017 09:50:26 -0800
Date:   Fri, 17 Nov 2017 17:50:14 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] MIPS: Cleanup R10000_LLSC_WAR logic in atomic.h
In-Reply-To: <99b32188-75eb-35fc-6ce4-f028bfefd6ed@gentoo.org>
Message-ID: <alpine.DEB.2.00.1711171747120.3888@tp.orcam.me.uk>
References: <5baf0f58-862b-2488-8685-bf7383b19c20@gentoo.org> <alpine.LFD.2.21.1711041423530.23561@eddie.linux-mips.org> <9eea04e2-169d-e8d7-8f93-26e33e3d1145@gentoo.org> <alpine.DEB.2.00.1711141734540.3893@tp.orcam.me.uk> <39133ddb-6b10-4a7b-6739-6f52fe8aa6a6@gentoo.org>
 <alpine.DEB.2.00.1711162329430.3888@tp.orcam.me.uk> <99b32188-75eb-35fc-6ce4-f028bfefd6ed@gentoo.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1510941032-637138-21349-155744-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187050
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60998
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

On Fri, 17 Nov 2017, Joshua Kinard wrote:

> Ah!  I thought that when writing inline assembler, it was taken as-is by the
> compiler and not messed with.  I didn't think that gas would still move things
> around w/o the 'noreorder' directive being set.  Thank you for the explanation.

 GCC always sets the `reorder' mode for inline assembly pieces even if it 
has chosen to use the `noreorder' mode outside.  This is required for 
compatibility with code written before GCC started using the `noreorder' 
mode if nothing else.

  Maciej
