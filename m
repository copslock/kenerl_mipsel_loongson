Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 07:28:11 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:58026 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990471AbeKFG1ZQunGt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Nov 2018 07:27:25 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E330468C1D; Tue,  6 Nov 2018 07:27:24 +0100 (CET)
Date:   Tue, 6 Nov 2018 07:27:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] OCTEON MMC driver failure with v4.19
Message-ID: <20181106062724.GA12413@lst.de>
References: <20181026205423.GD3792@darkstar.musicnaut.iki.fi> <20181105220632.GA5083@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105220632.GA5083@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67097
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

On Tue, Nov 06, 2018 at 12:06:32AM +0200, Aaro Koskinen wrote:
> With the below change, the MMC card probe seems to with v4.19. But it
> feels a bit hackish, don't you think... Is there some obvious simple
> fix that I'm missing? Any comments?

Please just use dma_coerce_mask_and_coherent in the platform drivers
instead.
