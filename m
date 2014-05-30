Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2014 18:50:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33763 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6830035AbaE3QuzEIkmR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 May 2014 18:50:55 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s4UGoq6x005191;
        Fri, 30 May 2014 18:50:52 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s4UGoq6o005190;
        Fri, 30 May 2014 18:50:52 +0200
Date:   Fri, 30 May 2014 18:50:52 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 4/5] MIPS: Malta: hang on halt
Message-ID: <20140530165052.GM17197@linux-mips.org>
References: <1399461660-17623-1-git-send-email-paul.burton@imgtec.com>
 <1399461660-17623-5-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1399461660-17623-5-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40390
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

On Wed, May 07, 2014 at 12:20:59PM +0100, Paul Burton wrote:

> When the system is halted it makes little sense to reset it. Instead,
> hang by executing an infinite loop.
> 
> Suggested-by: Maciej W. Rozycki <macro@linux-mips.org>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>  arch/mips/mti-malta/malta-reset.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
> index d627d4b..4471dea 100644
> --- a/arch/mips/mti-malta/malta-reset.c
> +++ b/arch/mips/mti-malta/malta-reset.c
> @@ -24,17 +24,20 @@ static void mips_machine_restart(char *command)
>  
>  static void mips_machine_halt(void)
>  {
> -	unsigned int __iomem *softres_reg =
> -		ioremap(SOFTRES_REG, sizeof(unsigned int));
> +	pr_info("Halting\n");
> +	while (true);
> +}

I don't think this should print anything - communication with the user
is up to userland.

while (true) is going to burn lots of power - undesirable on a virtualized
system in particular.  How about something like while (cpu_wait()); instead?
The invocation of cpu_wait() is a little tricky however in this case I think
it's ok if the CPU goes terminally goes to sleep which simplifies things
over the idle loop :-)

  Ralf
