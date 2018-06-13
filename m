Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2018 18:56:27 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:49686 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993852AbeFMQ4RiEkf5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2018 18:56:17 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1404.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 13 Jun 2018 16:55:54 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Wed, 13
 Jun 2018 09:56:05 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Wed, 13 Jun
 2018 09:56:05 -0700
Date:   Wed, 13 Jun 2018 09:55:54 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH Resend 2/2] MIPS: mcs lock: implement
 arch_mcs_spin_lock_contended() for Loongson-3
Message-ID: <20180613165554.75s5qe2zjbwm6inn@pburton-laptop>
References: <1528797283-16577-1-git-send-email-chenhc@lemote.com>
 <1528797283-16577-2-git-send-email-chenhc@lemote.com>
 <20180612184053.odi5gvvwbqovgvc6@pburton-laptop>
 <CAAhV-H4cyBHscWFzs47Ru9ChrJ-8CCc6pzqAmsqzzDNv1oUB6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAAhV-H4cyBHscWFzs47Ru9ChrJ-8CCc6pzqAmsqzzDNv1oUB6w@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1528908954-382908-14902-111542-1
X-BESS-VER: 2018.7-r1806112253
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194031
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: chenhc@lemote.com,ralf@linux-mips.org,linux-mips@linux-mips.org,zhangfx@lemote.com,wuzhangjin@gmail.com
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64257
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

On Wed, Jun 13, 2018 at 01:55:17PM +0800, Huacai Chen wrote:
> > Additionally you have "Resend" in the subject of this email, but I don't
> > see any previous submissions of this patch - given that commit
> > 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire() in MCS spin
> > loop") is very recent I doubt there were any. Please try to be factual,
> > and if you have 2 patches that are unrelated please send them separately
> > rather than as a series.
> I send another patch in this series because it is so simple and should
> be merged in the previous release, but it is ignored again and again.
> In practise, my
> single patch in linux-mips usually be ignored (even they are very
> simple and well described)....
> For example:
> https://patchwork.linux-mips.org/patch/17723/
> https://patchwork.linux-mips.org/patch/18587/
> https://patchwork.linux-mips.org/patch/19184/
> 
> Some of them are promised by James to review, but still ignored until now.

Both James & Ralf have been busy with things outside of kernel
development recently, so I'm sure it's just the case that they've not
had as much time to spend on maintenance as would have been ideal. I
know that has been frustrating, but the reasons for that haven't always
been controllable & I feel confident saying that it was nobody's intent
to ignore you or your contributions.

Going forwards I'm now listed in MAINTAINERS & after v4.18-rc1 is
released I intend to start merging patches ready for v4.19. I've started
looking though pending patches but haven't gotten as far as the ones you
linked yet.

A couple of those look like they could be candidates for a fixes pull in
the 4.18 cycle so I'll try to take a closer look at those sooner.

I'm still getting up to speed & there is a backlog of patches to review,
but please be assured that if your patch is still listed as "New" or
"Under Review" in patchwork then I intend to look at it, and there's no
need to resend it.

Thanks,
    Paul
