Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2017 00:01:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44616 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994852AbdGRWB2EAFGF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jul 2017 00:01:28 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v6IM1QXd024651;
        Wed, 19 Jul 2017 00:01:26 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v6IM1QrF024649;
        Wed, 19 Jul 2017 00:01:26 +0200
Date:   Wed, 19 Jul 2017 00:01:26 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     "#4 . 11+" <stable@vger.kernel.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: ralink: Fix build error due to missing header
Message-ID: <20170718220126.GA22091@linux-mips.org>
References: <1500384346-10527-1-git-send-email-harvey.hunt@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1500384346-10527-1-git-send-email-harvey.hunt@imgtec.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59140
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

On Tue, Jul 18, 2017 at 02:25:45PM +0100, Harvey Hunt wrote:

> Previously, <linux/module.h> was included before ralink_regs.h in all
> ralink files - leading to <linux/io.h> being implicitly included.
> 
> After commit 26dd3e4ff9ac ("MIPS: Audit and remove any unnecessary
> uses of module.h") removed the inclusion of module.h from multiple
> places, some ralink platforms failed to build with the following error:
> 
> In file included from arch/mips/ralink/mt7620.c:17:0:
> ./arch/mips/include/asm/mach-ralink/ralink_regs.h: In function ‘rt_sysc_w32’:
> ./arch/mips/include/asm/mach-ralink/ralink_regs.h:38:2: error: implicit declaration of function ‘__raw_writel’ [-Werror=implicit-function-declaration]
>   __raw_writel(val, rt_sysc_membase + reg);
>   ^
> ./arch/mips/include/asm/mach-ralink/ralink_regs.h: In function ‘rt_sysc_r32’:
> ./arch/mips/include/asm/mach-ralink/ralink_regs.h:43:2: error: implicit declaration of function ‘__raw_readl’ [-Werror=implicit-function-declaration]
>   return __raw_readl(rt_sysc_membase + reg);
> 
> Fix this by including <linux/io.h>.

Looks sensible, applied.  But I'm wondering why I don't see this in my
test builds.

  Ralf
