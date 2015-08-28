Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Aug 2015 09:40:40 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59634 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006555AbbH1HkjCN6fp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Aug 2015 09:40:39 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t7S7eb0e022667;
        Fri, 28 Aug 2015 09:40:37 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t7S7eZVE022666;
        Fri, 28 Aug 2015 09:40:35 +0200
Date:   Fri, 28 Aug 2015 09:40:34 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [RFC PATCH 4/9] mips: allocate sys_membarrier system call number
Message-ID: <20150828074034.GA22604@linux-mips.org>
References: <1440698215-8355-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1440698215-8355-5-git-send-email-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440698215-8355-5-git-send-email-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49061
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

On Thu, Aug 27, 2015 at 01:56:50PM -0400, Mathieu Desnoyers wrote:

> [ Untested on this architecture. To try it out: fetch linux-next/akpm,
>   apply this patch, build/run a membarrier-enabled kernel, and do make
>   kselftest. ]
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: linux-api@vger.kernel.org
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: linux-mips@linux-mips.org
> ---
>  arch/mips/include/uapi/asm/unistd.h | 15 +++++++++------
>  arch/mips/kernel/scall32-o32.S      |  1 +
>  arch/mips/kernel/scall64-64.S       |  1 +
>  arch/mips/kernel/scall64-n32.S      |  1 +
>  arch/mips/kernel/scall64-o32.S      |  1 +
>  5 files changed, 13 insertions(+), 6 deletions(-)

Looking good assuming there is no compat syscall required.

  Ralf
