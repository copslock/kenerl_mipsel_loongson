Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 22:11:11 +0200 (CEST)
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:15663 "EHLO
        hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819780Ab3GRULG3hiNr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 22:11:06 +0200
X-Authority-Analysis: v=2.0 cv=e9yEuNV/ c=1 sm=0 a=Sro2XwOs0tJUSHxCKfOySw==:17 a=Drc5e87SC40A:10 a=m81s-13gt9IA:10 a=5SG0PmZfjMsA:10 a=IkcTkHD0fZMA:10 a=meVymXHHAAAA:8 a=KGjhK52YXX0A:10 a=DHlrDtQkiHoA:10 a=fk1lIlRQAAAA:8 a=zAyngx5bAAAA:8 a=AgRTik3wS6d53wTNwdcA:9 a=QEXdDO2ut3YA:10 a=gH_wm7_JyAQA:10 a=9g6PTisfegMA:10 a=DUX0N4f6TqGyh1Jp:21 a=K6UQCbUFnQzV_Gmk:21 a=Sro2XwOs0tJUSHxCKfOySw==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.255.60.225
Received: from [67.255.60.225] ([67.255.60.225:52250] helo=[192.168.23.10])
        by hrndva-oedge01.mail.rr.com (envelope-from <rostedt@goodmis.org>)
        (ecelerity 2.2.3.46 r()) with ESMTP
        id E6/4F-18705-6DB48E15; Thu, 18 Jul 2013 20:11:03 +0000
Message-ID: <1374178262.6458.266.camel@gandalf.local.home>
Subject: Re: [PATCH] mips/ftrace: Fix function tracing return address to
 match
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Corey Minyard <cminyard@mvista.com>,
        David Daney <david.daney@cavium.com>
Date:   Thu, 18 Jul 2013 16:11:02 -0400
In-Reply-To: <1373926637-24627-1-git-send-email-ddaney.cavm@gmail.com>
References: <1373926637-24627-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.4.4-3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <rostedt@goodmis.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rostedt@goodmis.org
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

On Mon, 2013-07-15 at 15:17 -0700, David Daney wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Dynamic function tracing was not working on MIPS.  When doing dynamic
> tracing, the tracer attempts to match up the passed in address with
> the one the compiler creates in the mcount tables.  The MIPS code was
> passing in the return address from the tracing function call, but the
> compiler tables were the address of the function call.  So they
> wouldn't match.
> 
> Just subtracting 8 from the return address will give the address of
> the function call.  Easy enough.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> [david.daney@cavium.com: Adjusted code comment and patch Subject.]
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/kernel/mcount.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
> index a03e93c..539b629 100644
> --- a/arch/mips/kernel/mcount.S
> +++ b/arch/mips/kernel/mcount.S
> @@ -83,7 +83,7 @@ _mcount:
>  	PTR_S	MCOUNT_RA_ADDRESS_REG, PT_R12(sp)
>  #endif
>  
> -	move	a0, ra		/* arg1: self return address */
> +	PTR_SUBU a0, ra, 8	/* arg1: self address */
>  	.globl ftrace_call
>  ftrace_call:
>  	nop	/* a placeholder for the call to a real tracing function */

I applied this patch to my Yeeloong Lemote laptop and it causes the
system to crash. Not sure why. I'll try to investigate.

-- Steve
