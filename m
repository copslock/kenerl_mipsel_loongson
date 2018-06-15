Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2018 18:31:36 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:60318 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993008AbeFOQb2XhV1G convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Jun 2018 18:31:28 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Fri, 15 Jun 2018 16:31:18 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 15
 Jun 2018 09:31:30 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Fri, 15 Jun
 2018 09:31:30 -0700
Date:   Fri, 15 Jun 2018 09:31:18 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix arch_trigger_cpumask_backtrace()
Message-ID: <20180615163118.s522qanwyo7weliu@pburton-laptop>
References: <1517802167-20340-1-git-send-email-chenhc@lemote.com>
 <20180613212125.gxbqusrjgzb257sj@pburton-laptop>
 <tencent_593903C43C0807E06AB44674@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <tencent_593903C43C0807E06AB44674@qq.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529080278-298554-21967-32480-1
X-BESS-VER: 2018.7-r1806150109
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194088
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: chenhc@lemote.com,ralf@linux-mips.org,steven.hill@cavium.com,linux-mips@linux-mips.org,zhangfx@lemote.com,wuzhangjin@gmail.com,stable@vger.kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64309
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

Hi Huacai,

On Fri, Jun 15, 2018 at 12:30:35PM +0800, 陈华才 wrote:
> I can't test your branch...... Because now the mainline kernel lacks
> too many features needed by Loongson-3.

Interesting - so the mainline Loongson-3 code doesn't actually work? How
much is missing for it to be functional?

> By the way, Your approach is based on NMI but I don't think NMI is
> always available on each MIPS board.

It isn't using NMIs at all - the nmi_trigger_cpumask_backtrace()
function has NMI in its name, sure, but it just invokes a callback to
interrupt other CPUs & we can implement that using regular old IPIs.

This is the same way arch/arm does it, so it's not unprecedented &
allows us to share the common code.

It would be ideal to use NMIs where possible in future, but that can
come later for platforms where they're available.

Thanks,
    Paul
