Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Oct 2017 23:00:48 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.230]:45946 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991726AbdJaWAj50wzl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Oct 2017 23:00:39 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 31 Oct 2017 22:00:18 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 31 Oct
 2017 14:59:26 -0700
Date:   Tue, 31 Oct 2017 22:00:11 +0000
From:   James Hogan <james.hogan@mips.com>
To:     "Gustavo A. R. Silva" <garsilva@embeddedor.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, Julia Lawal <julia.lawall@lip6.fr>
Subject: Re: [PATCH] MIPS: microMIPS: Fix incorrect mask in insn_table_MM
Message-ID: <20171031220011.GC15260@jhogan-linux>
References: <20171031053503.GA5164@embeddedor.com>
 <20171031070804.GB15260@jhogan-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20171031070804.GB15260@jhogan-linux>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1509487214-321458-15337-27956-4
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186463
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

On Tue, Oct 31, 2017 at 07:08:04AM +0000, James Hogan wrote:
> On Tue, Oct 31, 2017 at 12:35:03AM -0500, Gustavo A. R. Silva wrote:
> > Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> 
> Reviewed-by: James Hogan <jhogan@@kernel.org>

That should of course be:

Reviewed-by: James Hogan <jhogan@kernel.org>
