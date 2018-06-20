Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2018 04:47:48 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:52569 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990395AbeFTCrkJHLVB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2018 04:47:40 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1413.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 20 Jun 2018 02:47:34 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 19
 Jun 2018 19:47:33 -0700
Received: from localhost (10.20.78.225) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Tue, 19 Jun
 2018 19:47:33 -0700
Date:   Tue, 19 Jun 2018 19:47:34 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <r@hev.cc>
CC:     <linux-mips@linux-mips.org>, <jhogan@kernel.org>,
        <ralf@linux-mips.org>
Subject: Re: [PATCH v5] MIPS: Fix ejtag handler on SMP
Message-ID: <20180620024734.eeuqrm7tg2y2i5mw@pburton-laptop>
References: <20180611090110.27978-1-r@hev.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180611090110.27978-1-r@hev.cc>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529462854-531715-22543-24643-1
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194212
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: r@hev.cc,linux-mips@linux-mips.org,jhogan@kernel.org,ralf@linux-mips.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64392
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

Hi Heiher,

On Mon, Jun 11, 2018 at 05:01:10PM +0800, r@hev.cc wrote:
> From: Heiher <r@hev.cc>
> 
> On SMP systems, the shared ejtag debug buffer may be overwritten by
> other cores, because every cores can generate ejtag exception at
> same time.
> 
> Unfortunately, in that context, it's difficult to relax more registers
> to access per cpu buffers. so use ll/sc to serialize the access.
> 
> Signed-off-by: Heiher <r@hev.cc>
> ---
>  arch/mips/kernel/genex.S | 46 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

Thanks, applied to mips-next for 4.19.

Paul
