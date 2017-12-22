Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Dec 2017 08:59:38 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58468 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990502AbdLVH7bOG3Jt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Dec 2017 08:59:31 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vBM7xNce026495;
        Fri, 22 Dec 2017 08:59:23 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vBM7xLJh026494;
        Fri, 22 Dec 2017 08:59:21 +0100
Date:   Fri, 22 Dec 2017 08:59:21 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     James Hogan <james.hogan@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] lib/mpi: Fix umul_ppmm() for MIPS64r6
Message-ID: <20171222075921.GJ28538@linux-mips.org>
References: <20171205233135.1763-1-james.hogan@mips.com>
 <20171222070808.GB27149@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171222070808.GB27149@gondor.apana.org.au>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Dec 22, 2017 at 06:08:08PM +1100, Herbert Xu wrote:

> I can take this but I'd like to see an ack from someone on the
> MIPS side.

Sure:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
