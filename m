Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 May 2013 12:19:14 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:49994 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823763Ab3E0KTMZLXNL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 May 2013 12:19:12 +0200
Received: by mail-la0-f44.google.com with SMTP id fr10so6364679lab.17
        for <linux-mips@linux-mips.org>; Mon, 27 May 2013 03:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=+J12BxkeqrGqFzgLCEqv/ADyAO0s+7BkYGsCqL4T+xU=;
        b=kbuLGWYvzRA2KX2zYqDL9evkrDH1JETsxgMWYqIHuLszhz5/AXuK/lnJfb96dcVcPK
         czqmnxDPY0zklk5aZnD6zTw5EUIlcvUW/q5DW8uF9XTXFGnM+Qexr65KSSRCimuhRYeL
         OWbwVMNP9bgLJ4O6oitxhXpwWe6xpJBB1bn5QwfxYqT6JvINN636P+v2TdBLGcBFnGwT
         hMJNhLNo930mK9XMR6PwFFB7fnc3ZzYfyHp9PhRzookSiDM7VexuErbYoRQxxfGCzq6o
         8LAwIYvHT9YM1lP60mzX14iAaVy2xsFJTvs1Ko932NFySPxSq2GMZxYgzgedF0UW8LkG
         sixg==
X-Received: by 10.152.116.36 with SMTP id jt4mr9654557lab.57.1369649946640;
        Mon, 27 May 2013 03:19:06 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-155-34.pppoe.mtu-net.ru. [91.76.155.34])
        by mx.google.com with ESMTPSA id e9sm10277444lbj.3.2013.05.27.03.19.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 May 2013 03:19:05 -0700 (PDT)
Message-ID: <51A33317.2060202@cogentembedded.com>
Date:   Mon, 27 May 2013 14:19:03 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: cavium-octeon: cvmx-helper-board: print unknown
 board warning only once
References: <1369600543-21558-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1369600543-21558-1-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkWe9/9pYhGM5eVytbVoZpG+hT8odNRvzZ/SgcyiJ0A8yHYBhHzdTj950QzsamLNedfnVGN
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 27-05-2013 0:35, Aaro Koskinen wrote:

> When booting a new board for the first time, the console is flooded with
> "Unknown board" messages. This is not really helpful. Board type is not
> going to change after the boot, so it's sufficient to print the warning
> only once.

> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>   arch/mips/cavium-octeon/executive/cvmx-helper-board.c |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> index 7c64977..e0451a0 100644
> --- a/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper-board.c
[...]
> @@ -184,8 +186,7 @@ int cvmx_helper_board_get_mii_address(int ipd_port)
>   	}
>
>   	/* Some unknown board. Somebody forgot to update this function... */
> -	cvmx_dprintf
> -	    ("cvmx_helper_board_get_mii_address: Unknown board type %d\n",
> +	pr_warn_once("%s: Unknown board type %d\n", __func__,
>   	     cvmx_sysinfo_get()->board_type);

    Please align this line under the next char under (.

WVR, Sergei
