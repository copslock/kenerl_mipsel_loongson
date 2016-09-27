Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2016 14:04:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41322 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991940AbcI0MEr0upKN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Sep 2016 14:04:47 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u8RC4hnN006908;
        Tue, 27 Sep 2016 14:04:43 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u8RC4gwN006907;
        Tue, 27 Sep 2016 14:04:42 +0200
Date:   Tue, 27 Sep 2016 14:04:42 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     linux-mips@vger.kernel.org,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] MIPS: set NR_syscall_tables appropriately
Message-ID: <20160927120442.GF12981@linux-mips.org>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
 <1472463007-6469-2-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1472463007-6469-2-git-send-email-marcin.nowakowski@imgtec.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55269
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

On Mon, Aug 29, 2016 at 11:30:07AM +0200, Marcin Nowakowski wrote:

> Depending on the kernel configuration, up to 3 syscall tables can be
> used in parallel - so set the number properly to ensure syscall tracing
> is set up properly.
> 
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
> ---
>  arch/mips/include/asm/unistd.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
> index e558130..71162f3d 100644
> --- a/arch/mips/include/asm/unistd.h
> +++ b/arch/mips/include/asm/unistd.h
> @@ -22,6 +22,10 @@
>  #define NR_syscalls  (__NR_O32_Linux + __NR_O32_Linux_syscalls)
>  #endif
>  
> +#define NR_syscall_tables (1 + \
> +	IS_ENABLED(CONFIG_MIPS32_O32) + \
> +	IS_ENABLED(CONFIG_MIPS32_N32))
> +
>  #ifndef __ASSEMBLY__

NR_syscall_tables is a new symbol but I don't see any users of this
symbol?

  Ralf
