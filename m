Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jul 2018 23:25:55 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:57028 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993104AbeGSVZwN2hAu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Jul 2018 23:25:52 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1402.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 19 Jul 2018 21:25:13 +0000
Received: from [10.20.78.160] (10.20.78.160) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 19
 Jul 2018 14:25:23 -0700
Date:   Thu, 19 Jul 2018 22:25:04 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Paul Burton <paul.burton@mips.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] MIPS: DSP ASE regset support
In-Reply-To: <20180719205630.osfdzk7gqv4djvqc@pburton-laptop>
Message-ID: <alpine.DEB.2.00.1807192214500.30992@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk> <20180719205630.osfdzk7gqv4djvqc@pburton-laptop>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.160]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1532035513-321458-1221-22561-1
X-BESS-VER: 2018.9-r1807111811
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: maciej.rozycki@uk.mips.com
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.196061
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender Domain Matches Recipient Domain 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH
X-BESS-Orig-Rcpt: viro@zeniv.linux.org.uk,jhogan@kernel.org,ralf@linux-mips.org,linux-fsdevel@vger.kernel.org,linux-mips@linux-mips.org,linux-kernel@vger.kernel.org
X-BESS-BRTS-Status: 1
Return-Path: <maciej.rozycki@uk.mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64951
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

Hi Paul,

> Thanks - applied to mips-next for 4.19, though I removed the stable tags
> on patches 1/3 & 3/3 & it's worth noting that the ELF note numbers are
> changed to from 0x70X to 0x80X, since 0x700 has been used already.

 Great, thanks!  No code has used the note numbers yet as I ran out of 
time for doing the GDB side, so the change is not going to affect 
anything.

> If you really care about a stable backport for 3/3 let's talk, but I'm
> doubtful as to its use when we've been missing this for so long.

 I guess it can be backported if a need arises.  There's been clearly some 
move on the 64-bit DSP side as indicated by this GDB bug report (mentioned 
previously): <https://sourceware.org/bugzilla/show_bug.cgi?id=22286>, 
which ultimately prompted me to write this patch series, however given 
that GDB has also been broken for years it looks like just the beginning.
So maybe people will cope with the requirement to upgrade.  They need to 
notice the missing GDB part first anyway. ;)

  Maciej
