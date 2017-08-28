Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2017 15:53:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44530 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993302AbdH1NxGGKxFJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Aug 2017 15:53:06 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v7SDr5sM021167;
        Mon, 28 Aug 2017 15:53:05 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v7SDr5dO021166;
        Mon, 28 Aug 2017 15:53:05 +0200
Date:   Mon, 28 Aug 2017 15:53:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Fredrik Noring <noring@nocrew.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add basic R5900 support
Message-ID: <20170828135305.GA20466@linux-mips.org>
References: <20170827132309.GA32166@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170827132309.GA32166@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59835
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

On Sun, Aug 27, 2017 at 03:23:10PM +0200, Fredrik Noring wrote:

> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> ---
>  arch/mips/Kconfig                | 13 +++++++++++++
>  arch/mips/include/asm/cpu-type.h |  4 ++++
>  arch/mips/include/asm/cpu.h      |  6 ++++++
>  arch/mips/include/asm/module.h   |  2 ++
>  arch/mips/kernel/cpu-probe.c     | 10 ++++++++++
>  5 files changed, 35 insertions(+)

Patch is looking perfect at a glance but without support for an R5900
system that is the PS2 it kinda pointless so I'd like to wait and
review and apply everything at once.

  Ralf
