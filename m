Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 22:52:34 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:54730 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993888AbeGKUw1SQwqT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jul 2018 22:52:27 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5F73ADEF;
        Wed, 11 Jul 2018 20:52:21 +0000 (UTC)
Date:   Wed, 11 Jul 2018 22:52:21 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mips/jazz: provide dma_mask/coherent_dma_mask for
 platform devices
Message-Id: <20180711225221.f25a7ce2eda3c1a1ffad6464@suse.de>
In-Reply-To: <20180711161556.gmxgfo7y46xbdw7z@pburton-laptop>
References: <20180711113852.2734-1-tbogendoerfer@suse.de>
        <20180711113852.2734-2-tbogendoerfer@suse.de>
        <20180711161556.gmxgfo7y46xbdw7z@pburton-laptop>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <tbogendoerfer@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64804
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

On Wed, 11 Jul 2018 09:15:56 -0700
Paul Burton <paul.burton@mips.com> wrote:

> On Wed, Jul 11, 2018 at 01:38:52PM +0200, Thomas Bogendoerfer wrote:
> > platform devices for sonic and esp didn't have dma_masks.
> 
> That's a very brief commit message :)

I thought it's obvious, that now every dma mapping operation triggers a WARN_ON, if
dma masks are missing. But no problem to respin with a more information added.

Thomas.
