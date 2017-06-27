Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2017 23:40:30 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52836 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993945AbdF0VkXds1bv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Jun 2017 23:40:23 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v5RLeJGf029249;
        Tue, 27 Jun 2017 23:40:19 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v5RLeIFI029247;
        Tue, 27 Jun 2017 23:40:18 +0200
Date:   Tue, 27 Jun 2017 23:40:18 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Karl Beldan <karl.beldan@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Karl Beldan <karl.beldan+oss@gmail.com>,
        stable@vger.kernel.org, Jonas Gorski <jogo@openwrt.org>
Subject: Re: [RESEND PATCH] MIPS: head: Reorder instructions missing a delay
 slot
Message-ID: <20170627214018.GD10090@linux-mips.org>
References: <20170627192216.29364-1-karl.beldan+oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170627192216.29364-1-karl.beldan+oss@gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58835
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

On Tue, Jun 27, 2017 at 07:22:16PM +0000, Karl Beldan wrote:

> In this sequence the 'move' is assumed in the delay slot of the 'beq',
> but head.S is in reorder mode and the former gets pushed one 'nop'
> farther by the assembler.
> 
> The corrected behavior made booting with an UHI supplied dtb erratic.

Excellent catch, patch applied!

Thanks Karl,

  Ralf
