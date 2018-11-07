Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 08:59:27 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:36308 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992820AbeKGH7YK-ffZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Nov 2018 08:59:24 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DC74068C44; Wed,  7 Nov 2018 08:59:23 +0100 (CET)
Date:   Wed, 7 Nov 2018 08:59:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: SiByte: Enable swiotlb for SWARM and BigSur
Message-ID: <20181107075923.GD24381@lst.de>
References: <alpine.LFD.2.21.1811050501010.20378@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1811050501010.20378@eddie.linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

Do we really need a new source file just to call swiotlb_init?  And
if we do that file should have a SPDX header these days.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
