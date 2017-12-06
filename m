Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2017 15:51:04 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:43558 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990552AbdLFOuzo0pAs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 6 Dec 2017 15:50:55 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vB6Dvk0p010088;
        Wed, 6 Dec 2017 14:57:46 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vB6Dvjsk010087;
        Wed, 6 Dec 2017 14:57:45 +0100
Date:   Wed, 6 Dec 2017 14:57:45 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@mips.com>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: CM: Drop WARN_ON(vp != 0)
Message-ID: <20171206135745.GD5238@linux-mips.org>
References: <20171205222822.15034-1-james.hogan@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205222822.15034-1-james.hogan@mips.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61320
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

On Tue, Dec 05, 2017 at 10:28:22PM +0000, James Hogan wrote:

> Since commit 68923cdc2eb3 ("MIPS: CM: Add cluster & block args to
> mips_cm_lock_other()"), mips_smp_send_ipi_mask() has used
> mips_cm_lock_other_cpu() with each CPU number, rather than
> mips_cm_lock_other() with the first VPE in each core. Prior to r6,
> multicore multithreaded systems such as dual-core dual-thread
> interAptivs with CPU Idle enabled (e.g. MIPS Creator Ci40) results in
> mips_cm_lock_other() repeatedly hitting WARN_ON(vp != 0).
> 
> There doesn't appear to be anything fundamentally wrong about passing a
> non-zero VP/VPE number, even if it is a core's region that is locked
> into the other region before r6, so remove that particular WARN_ON().
> 
> Fixes: 68923cdc2eb3 ("MIPS: CM: Add cluster & block args to mips_cm_lock_other()")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Reviewed-by: Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 4.14+
> ---
>  arch/mips/kernel/mips-cm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
> index dd5567b1e305..8f5bd04f320a 100644
> --- a/arch/mips/kernel/mips-cm.c
> +++ b/arch/mips/kernel/mips-cm.c
> @@ -292,7 +292,6 @@ void mips_cm_lock_other(unsigned int cluster, unsigned int core,
>  				  *this_cpu_ptr(&cm_core_lock_flags));
>  	} else {
>  		WARN_ON(cluster != 0);
> -		WARN_ON(vp != 0);

I think the reason is that for a while the combination of SMP/CMP with
MT was at the bottom of priorities and nobody really cared about it so
a WARN_ON was thrown in.  Which in this case might well itself be a bug!

  Ralf
