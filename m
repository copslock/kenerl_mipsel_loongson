Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 16:02:37 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53357 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009179AbaLSPCdTqwWC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 19 Dec 2014 16:02:33 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sBJF2TUr003621;
        Fri, 19 Dec 2014 16:02:29 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sBJF2LUc003616;
        Fri, 19 Dec 2014 16:02:21 +0100
Date:   Fri, 19 Dec 2014 16:02:21 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Hibernate: flush TLB entries earlier
Message-ID: <20141219150221.GK14160@linux-mips.org>
References: <1418999184-10216-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1418999184-10216-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44847
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

On Fri, Dec 19, 2014 at 10:26:24PM +0800, Huacai Chen wrote:

> We found that TLB mismatch not only happens after kernel resume, but
> also happens during snapshot restore. So move it to the beginning of
> swsusp_arch_suspend().
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/power/hibernate.S |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
> index 32a7c82..e7567c8 100644
> --- a/arch/mips/power/hibernate.S
> +++ b/arch/mips/power/hibernate.S
> @@ -30,6 +30,8 @@ LEAF(swsusp_arch_suspend)
>  END(swsusp_arch_suspend)
>  
>  LEAF(swsusp_arch_resume)
> +	/* Avoid TLB mismatch during and after kernel resume */
> +	jal local_flush_tlb_all

I'd like to keep the assembler code to a minimum.  Can you rename
swsusp_arch_resume and create a new wrapper function in C named
swsusp_arch_resume() which calls the old swsusp_arch_resume() after
calling local_flush_tlb_all(), something like that?

Thanks,

  Ralf
