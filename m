Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 22:50:40 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:54564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993888AbeGKUucSjpgT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jul 2018 22:50:32 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DBFAADEF;
        Wed, 11 Jul 2018 20:50:26 +0000 (UTC)
Date:   Wed, 11 Jul 2018 22:50:25 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mips: Fix mips_dma_map_sg by using correct dma
 mapping function
Message-Id: <20180711225025.9c8da709d9c513fbbdce020b@suse.de>
In-Reply-To: <20180711160342.ddvlqvjp3smwyido@pburton-laptop>
References: <20180711113852.2734-1-tbogendoerfer@suse.de>
        <20180711160342.ddvlqvjp3smwyido@pburton-laptop>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <tbogendoerfer@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbogendoerfer@suse.de
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

On Wed, 11 Jul 2018 09:03:42 -0700
Paul Burton <paul.burton@mips.com> wrote:

> This doesn't apply after Christoph's massive MIPS DMA cleanup which can
> be found in mips-next (or linux-next). After this work we end up using
> the generic dma_direct_map_sg() on most systems, and the code above has
> been removed.

Christoph's cleanup also fixes the issue. I thought sending it as a fix for
4.17 would be appropriate, but no problem with dropping it.

Thomas.
