Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Aug 2015 19:03:16 +0200 (CEST)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36229 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006795AbbHURDOlyA8T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Aug 2015 19:03:14 +0200
Received: by igcse8 with SMTP id se8so4752005igc.1
        for <linux-mips@linux-mips.org>; Fri, 21 Aug 2015 10:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=FsMa4nJqruvZi8B+W034hkg/IZ7jcZjnNJN/YGQcyEg=;
        b=zh1CbVym516tZ+4tY3G6Vej5I2vN+3hxlPcjQAfGBxg/Ue4KivMhxAUCzj5isV293F
         ks5sLA/5qfLfh4JPYSECyVb4cVImyfe27qXhTUV6pOfYsxEArTfkbI6PTDHHMjnl72QH
         ORNprc+PZ89VW7NzyPWYqyQVBvWbskMoR5AVii7g0QTdc1oKo+Z7PrfB3Fz1Jk+M2Ba0
         2CSkiVEP3OAV4iNPXMIMEDocrp05GSUTDqM7eHJ7ZkdWP68tuKfndvDi2MUwGG0TJzX7
         FHqd9lOzRM+SRm3/n+80wC1ak3bsplDIYnzrjwKU3rDelYkRxPDCKAMCx0Hsmlah3EGZ
         33Og==
X-Received: by 10.50.78.98 with SMTP id a2mr3621011igx.87.1440176588631;
        Fri, 21 Aug 2015 10:03:08 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id z7sm2166600ige.22.2015.08.21.10.03.06
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 10:03:07 -0700 (PDT)
Message-ID: <55D759CA.7060409@gmail.com>
Date:   Fri, 21 Aug 2015 10:03:06 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: kernel: signal: Drop unused arguments for traditional
 signal handlers
References: <1440071122-24971-1-git-send-email-markos.chandras@imgtec.com> <1440071122-24971-3-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1440071122-24971-3-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 08/20/2015 04:45 AM, Markos Chandras wrote:
> Traditional signal handlers (ie !SA_SIGINFO) only need only argument
> holding the signal number so we drop the additional arguments and fix
> the related comments. We also update the comments for the SA_SIGINFO
> case where the second argument is a pointer to a siginfo_t structure.
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/kernel/signal.c     | 6 +-----
>   arch/mips/kernel/signal32.c   | 6 +-----
>   arch/mips/kernel/signal_n32.c | 2 +-
>   3 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/arch/mips/kernel/signal.c b/arch/mips/kernel/signal.c
> index be3ac5f7cbbb..3a125331bf8b 100644
> --- a/arch/mips/kernel/signal.c
> +++ b/arch/mips/kernel/signal.c
> @@ -683,15 +683,11 @@ static int setup_frame(void *sig_return, struct ksignal *ksig,
>   	 * Arguments to signal handler:
>   	 *
>   	 *   a0 = signal number
> -	 *   a1 = 0 (should be cause)
> -	 *   a2 = pointer to struct sigcontext
>   	 *
>   	 * $25 and c0_epc point to the signal handler, $29 points to the
>   	 * struct sigframe.
>   	 */
>   	regs->regs[ 4] = ksig->sig;
> -	regs->regs[ 5] = 0;
> -	regs->regs[ 6] = (unsigned long) &frame->sf_sc;

This changes the kernel ABI.

Have you tested this change against all userspace applications that use 
signals to make sure it doesn't break anything?

David Daney
