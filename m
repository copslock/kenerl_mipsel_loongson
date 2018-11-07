Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 12:14:05 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990946AbeKGLOA1mr0E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 12:14:00 +0100
Date:   Wed, 7 Nov 2018 11:14:00 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: SiByte: Enable swiotlb for SWARM and BigSur
In-Reply-To: <20181107075923.GD24381@lst.de>
Message-ID: <alpine.LFD.2.21.1811071108150.20378@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1811050501010.20378@eddie.linux-mips.org> <20181107075923.GD24381@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 7 Nov 2018, Christoph Hellwig wrote:

> Do we really need a new source file just to call swiotlb_init?

 I think it being a separate file is actually good, as it saves a little 
bit of code space at run time if this is not used without the need to 
wrap the entire function into #ifdef.

>  And
> if we do that file should have a SPDX header these days.

 It does or I have missed something.

 Thanks for your review.

  Maciej
