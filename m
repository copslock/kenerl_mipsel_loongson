Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2014 19:12:15 +0200 (CEST)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:41523 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860040AbaF3RMAcrofc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jun 2014 19:12:00 +0200
Received: by mail-ig0-f176.google.com with SMTP id c1so4546448igq.15
        for <multiple recipients>; Mon, 30 Jun 2014 10:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Y3LeHaEON37+QLbOSbDRunbXQTYt9kvV2+0h6fNdfvI=;
        b=kiqzSs7lXGMS8TtDKy8iRU5PWnko1mG0UBQ0p9eFEpbGxSZEwIRgkuqyv54M9z5Wm8
         7SJIeLbRElpOm128kY5E1E3xva+hwo0wiJn0JumI92R1/ho2LmA9eWMewLJ3aAXv6Mvw
         MByScEWWEKoaZ2MW6fDmtGdbRZqRpnFMvC6KhqKYeg9bjHvvLjeuUmS6gFU9I/NYwZJV
         /fbUdCOwwwacDPpBHl+5m+QnNIPkE21adkOWoJ7hYYnwNesLrt7iWvHbwgu2oGM9wp34
         fgyRkqHiu3SbjPH5iDzbcxkn/74He/fuCGyuhD3gA6VUHHyYsr1HKYn1viWV9PUSVc2N
         NCjw==
X-Received: by 10.42.155.137 with SMTP id u9mr11326664icw.22.1404148313999;
        Mon, 30 Jun 2014 10:11:53 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id d10sm15959391igz.11.2014.06.30.10.11.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Jun 2014 10:11:53 -0700 (PDT)
Message-ID: <53B19A57.2040200@gmail.com>
Date:   Mon, 30 Jun 2014 10:11:51 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Fabian Frederick <fabf@skynet.be>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/1] MIPS: Octeon: remove unnecessary null test before
 debugfs_remove_recursive
References: <1404026179-2910-1-git-send-email-fabf@skynet.be>
In-Reply-To: <1404026179-2910-1-git-send-email-fabf@skynet.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40975
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

On 06/29/2014 12:16 AM, Fabian Frederick wrote:
> Fix checkpatch warning:
> WARNING: debugfs_remove_recursive(NULL) is safe this check is probably not required
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

I haven't tested it, but it seems fine, so...

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/cavium-octeon/oct_ilm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/oct_ilm.c b/arch/mips/cavium-octeon/oct_ilm.c
> index 71b213d..2d68a39 100644
> --- a/arch/mips/cavium-octeon/oct_ilm.c
> +++ b/arch/mips/cavium-octeon/oct_ilm.c
> @@ -194,8 +194,7 @@ err_irq:
>   static __exit void oct_ilm_module_exit(void)
>   {
>   	disable_timer(TIMER_NUM);
> -	if (dir)
> -		debugfs_remove_recursive(dir);
> +	debugfs_remove_recursive(dir);
>   	free_irq(OCTEON_IRQ_TIMER0 + TIMER_NUM, 0);
>   }
>
>
