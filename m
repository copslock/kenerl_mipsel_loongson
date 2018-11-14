Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2018 16:38:13 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:52762 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992778AbeKNPhdYvFNP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Nov 2018 16:37:33 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 48A0A68CED; Wed, 14 Nov 2018 16:37:30 +0100 (CET)
Date:   Wed, 14 Nov 2018 16:37:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] MIPS: SiByte: Enable ZONE_DMA32 for LittleSur
Message-ID: <20181114153730.GB28823@lst.de>
References: <alpine.LFD.2.21.1811131653160.9637@eddie.linux-mips.org> <alpine.LFD.2.21.1811132145480.9637@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1811132145480.9637@eddie.linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67291
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

On Tue, Nov 13, 2018 at 10:42:37PM +0000, Maciej W. Rozycki wrote:
> The LittleSur board is marked for high memory support and therefore 
> clearly must provide a way to have enough memory installed for some to 
> be present outside the low 4GiB physical address range.  With the memory 
> map of the BCM1250 SOC it has been built around it means over 1GiB of 
> actual DRAM, as only the first 1GiB is mapped in the low 4GiB physical 
> address range[1].
> 
> Complement commit cce335ae47e2 ("[MIPS] 64-bit Sibyte kernels need 
> DMA32.") then and also enable ZONE_DMA32 for LittleSur.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
