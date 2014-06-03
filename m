Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 13:03:38 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44474 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854774AbaFCLDfgDhEw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jun 2014 13:03:35 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s53B3NAQ028488;
        Tue, 3 Jun 2014 13:03:23 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s53B3L9W028487;
        Tue, 3 Jun 2014 13:03:21 +0200
Date:   Tue, 3 Jun 2014 13:03:21 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     chenj <chenj@lemote.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
Message-ID: <20140603110321.GR17197@linux-mips.org>
References: <1400137743-8806-1-git-send-email-chenj@lemote.com>
 <1400137743-8806-2-git-send-email-chenj@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1400137743-8806-2-git-send-email-chenj@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40415
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

On Thu, May 15, 2014 at 03:09:03PM +0800, chenj wrote:

> wsbh & movn are available on loongson3 CPU.
> ---
>  arch/mips/lib/csum_partial.S | 10 ++++++++--

Does Loongson 3 also have both the DSBH and DSHD instructions?

  Ralf
