Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2015 18:15:50 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45738 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27007995AbbFAQPscc804 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Jun 2015 18:15:48 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t51GFi2v031816;
        Mon, 1 Jun 2015 18:15:44 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t51GFitJ031815;
        Mon, 1 Jun 2015 18:15:44 +0200
Date:   Mon, 1 Jun 2015 18:15:44 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: MIPS: oprofile: Distinguish R14000 from R12000
Message-ID: <20150601161544.GC26432@linux-mips.org>
References: <5562A1D9.2080400@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5562A1D9.2080400@gentoo.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47765
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

On Mon, May 25, 2015 at 12:15:21AM -0400, Joshua Kinard wrote:

> From: Joshua Kinard <kumba@gentoo.org>
> 
> Currently, arch/mips/oprofile/op_model_mipsxx.c treats an R14000 as an
> R12000.  This patch distinguishes one from the other.
> 
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>  op_model_mipsxx.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> linux-mips-oprofile-fix-r14k.patch
> diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
> index 6a6e2cc..75f1967 100644
> --- a/arch/mips/oprofile/op_model_mipsxx.c
> +++ b/arch/mips/oprofile/op_model_mipsxx.c
> @@ -408,10 +408,13 @@ static int __init mipsxx_init(void)
>  		break;
>  
>  	case CPU_R12000:
> -	case CPU_R14000:
>  		op_model_mipsxx_ops.cpu_type = "mips/r12000";
>  		break;
>  
> +	case CPU_R14000:
> +		op_model_mipsxx_ops.cpu_type = "mips/r14000";
> +		break;
> +

Note the string returned here is exported to userland which uses it
to lookup event and unit_mask definitions in /usr/share/oprofile.
In other words without changes to userland oprofile you've just broken
R14000 oprofile support.

Due to the large number of such files it is only acceptable to add new
such files for CPUs that differ significantly from other CPUs.  This
is not the case for the R14000 which supports the same events as the
R12000, so this patch is wrong, sorry.

I don't want to think about what the mixing R10000 and R12000/R14000
in a single system means for using oprofile ...

  Ralf
