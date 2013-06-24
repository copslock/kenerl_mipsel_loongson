Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jun 2013 20:52:43 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38402 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825885Ab3FXSwczaxb9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jun 2013 20:52:32 +0200
Received: by mail-pa0-f50.google.com with SMTP id fb1so11303414pad.23
        for <multiple recipients>; Mon, 24 Jun 2013 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=pDwYjQS/lqzn2+6M7jsBAAk+ShHuiDGmOZ45Dh8EBkk=;
        b=BRKpH+9Nw9Kp2pDlRRJNpgxDI+JKgQZn/6i9FhJrRycL3T6Ql+m4+iApW3yN0M0j1A
         prsZ1b/8fZiW89ZG/6wBhX/rynS1S41/KjSYaoZqC+41c3qyRXWJUGzkYYRr47mC76/+
         iFhMApC1LOdj94XHVOZMl6A6zLwdt/Mv6vsyylNlRkvYcdeGXMiSC5is8ghll8L1+T2d
         4I1wqEVBE2rYI5UFeXa9HQsJ/v4f2r0lOt0t5h2Gg3I4yEw7JsQu6mCDwcUliD96P8Tn
         6w3PWvPDX/iyfDGWjfn42pNBIqGqPrK9qqtSWmFvlNjMuXozMFCRhVB4qjSYKXD5m+td
         87lg==
X-Received: by 10.68.232.225 with SMTP id tr1mr24720431pbc.143.1372099946411;
        Mon, 24 Jun 2013 11:52:26 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id pm7sm19306375pbb.31.2013.06.24.11.52.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 11:52:25 -0700 (PDT)
Message-ID: <51C89567.3000108@gmail.com>
Date:   Mon, 24 Jun 2013 11:52:23 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 1/2] MIPS: cavium-octeon: cvmx-helper-board: print
 unknown board warning only once
References: <1372023524-17333-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1372023524-17333-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37117
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

On 06/23/2013 02:38 PM, Aaro Koskinen wrote:
> When booting a new board for the first time, the console is flooded with
> "Unknown board" messages. This is not really helpful. Board type is not
> going to change after the boot, so it's sufficient to print the warning
> only once.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

I don't think we need this patch.  In 2/2 you add the board type for the 
board you have, so you shouldn't be getting any messages, and this is 
unneeded.

I don't mind spamming people with all the messages,  if people see these 
messages, they have bigger problems than too many messages.

David Daney


> ---
>
> 	v2: Adjust indentation.
>
>   arch/mips/cavium-octeon/executive/cvmx-helper-board.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> index 7c64977..9838c0e 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> @@ -31,6 +31,8 @@
>    * network ports from the rest of the cvmx-helper files.
>    */
>
> +#include <linux/printk.h>
> +
>   #include <asm/octeon/octeon.h>
>   #include <asm/octeon/cvmx-bootinfo.h>
>
> @@ -184,9 +186,8 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
>   	}
>
>   	/* Some unknown board. Somebody forgot to update this function... */
> -	cvmx_dprintf
> -	    ("cvmx_helper_board_get_mii_address: Unknown board type %d\n",
> -	     cvmx_sysinfo_get()->board_type);
> +	pr_warn_once("%s: Unknown board type %d\n", __func__,
> +		     cvmx_sysinfo_get()->board_type);
>   	return -1;
>   }
>
>
