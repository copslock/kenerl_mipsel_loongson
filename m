Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Nov 2015 10:37:41 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59128 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011244AbbKJJhjVVswS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 Nov 2015 10:37:39 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tAA9bZES029242;
        Tue, 10 Nov 2015 10:37:35 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tAA9bYMG029241;
        Tue, 10 Nov 2015 10:37:34 +0100
Date:   Tue, 10 Nov 2015 10:37:34 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Tony Wu <tung7970@gmail.com>
Cc:     linux-mips@linux-mips.org, stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH v2] MIPS: kernel: proc: Fix typo in proc.c
Message-ID: <20151110093733.GA29184@linux-mips.org>
References: <20151105001612-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151105001612-tung7970@googlemail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49881
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

On Thu, Nov 05, 2015 at 12:17:44AM +0800, Tony Wu wrote:

> Fix typo introduced in commit 515a6393dbac ("MIPS: kernel: proc:
> Add MIPS R6 support to /proc/cpuinfo"), mips1 should be tested
> against cpu_has_mips_1, not cpu_has_mips_r1.
> 
> Signed-off-by: Tony Wu <tung7970@gmail.com>
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: <stable@vger.kernel.org> # v4.0+
> 
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 211fcd4..3417ce0 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -83,7 +83,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  	}
>  
>  	seq_printf(m, "isa\t\t\t:"); 
> -	if (cpu_has_mips_r1)
> +	if (cpu_has_mips_1)
>  		seq_printf(m, " mips1");
>  	if (cpu_has_mips_2)
>  		seq_printf(m, "%s", " mips2");

Applied - but when I applied the patch I got

/home/ralf/src/linux/linux-mips/.git/rebase-apply/patch:8: trailing whitespace.
	seq_printf(m, "isa\t\t\t:"); 
warning: 1 line adds whitespace errors.

which correct but a bit funny because the line git is complaining about
isn't even being changed.

  Ralf
