Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 May 2013 08:09:20 +0200 (CEST)
Received: from mail-bk0-f48.google.com ([209.85.214.48]:41061 "EHLO
        mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822664Ab3E2GJPs4BLO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 May 2013 08:09:15 +0200
Received: by mail-bk0-f48.google.com with SMTP id jf20so3117128bkc.7
        for <multiple recipients>; Tue, 28 May 2013 23:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=he8t6I4AtJlGvF5QHry7Cby1XFCVOfYXGHZX74A0mg8=;
        b=mhS3rzX8kKLEzyGwKcSU3HlIvSrBhfAYB5OQxzmZH1g0ecYF/C4XUHoUp8adoHFhBE
         mMm7vTcXZAWMeyXMB0d04vuY+RC69apYWzDYmIbCQ0Bsctd7EAMOXnzo2VNwnuKdQo/3
         chSao9EQTqXSiuHDx2mU/QQE1aUPN7llTBISVE3WbrJ8cwOWhCL5TcbbzVLrri05o6Nq
         XEe/oAa988Wp6zMGh83559YHdEbOWxBMb4O8ZCAQ68VfGPjbGLKqL5/DfY0CIjg/JULy
         /ycn1rWtyk0kg7YAPK9iYjxzNQkm6ki/zkk/H42j2PYjC5UpNw1iUdKKyV8tFUX6x/Uq
         srTA==
X-Received: by 10.204.189.7 with SMTP id dc7mr287991bkb.108.1369807750177;
        Tue, 28 May 2013 23:09:10 -0700 (PDT)
Received: from [0.0.0.0] ([62.159.77.167])
        by mx.google.com with ESMTPSA id og1sm7344133bkb.16.2013.05.28.23.09.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 28 May 2013 23:09:09 -0700 (PDT)
Message-ID: <51A59B7D.2040506@gmail.com>
Date:   Wed, 29 May 2013 08:09:01 +0200
From:   Wladislav Wiebe <wladislav.kw@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH] MIPS: OCTEON: Improve _machine_halt implementation.
References: <1369416182-7345-1-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1369416182-7345-1-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wladislav.kw@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36627
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wladislav.kw@gmail.com
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

Hi,

On 24/05/13 19:23, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> As noted by Wladislav Wiebe:
>    $ halt
>    ..
>    Sent SIGKILL to all processes
>    Requesting system halt
>    [66.729373] System halted.
>    [66.733244]
>    [66.734761] =====================================
>    [66.739473] [ BUG: lock held at task exit time! ]
>    [66.744188] 3.8.7-0-sampleversion-fct #49 Tainted: G           O
>    [66.750202] -------------------------------------
>    [66.754913] init/21479 is exiting with locks still held!
>    [66.760234] 1 lock held by init/21479:
>    [66.763990]  #0:  (reboot_mutex){+.+...}, at: [<ffffffff801776c8>] SyS_reboot+0xe0/0x218
>    [66.772165]
>    [66.772165] stack backtrace:
>    [66.776532] Call Trace:
>    [66.778992] [<ffffffff805780a8>] dump_stack+0x8/0x34
>    [66.783972] [<ffffffff801618b0>] do_exit+0x610/0xa70
>    [66.788948] [<ffffffff801777a8>] SyS_reboot+0x1c0/0x218
>    [66.794186] [<ffffffff8013d6a4>] handle_sys64+0x44/0x64
> 
> This is an alternative fix to the one sent by Wladislav.  We kill the
> watchdog for each CPU and then spin in WAIT with interrupts disabled.
> This is the lowest power mode for the OCTEON.  If we were to spin with
> interrupts enabled, we would get a continual stream of warning messages
> and backtraces from the lockup detector, so I chose to disable
> interrupts.
> 

good alternative!

Thanks.
--
Wladislav Wiebe


> Signed-off-by: David Daney <david.daney@cavium.com>
> Cc: Maxim Uvarov <muvarov@gmail.com>
> Cc: Wladislav Wiebe <wladislav.kw@gmail.com>
> ---
>  arch/mips/cavium-octeon/setup.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index b0baa29..01b1b3f 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -428,13 +428,16 @@ static void octeon_restart(char *command)
>   */
>  static void octeon_kill_core(void *arg)
>  {
> -	mb();
> -	if (octeon_is_simulation()) {
> -		/* The simulator needs the watchdog to stop for dead cores */
> -		cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
> +	if (octeon_is_simulation())
>  		/* A break instruction causes the simulator stop a core */
> -		asm volatile ("sync\nbreak");
> -	}
> +		asm volatile ("break" ::: "memory");
> +
> +	local_irq_disable();
> +	/* Disable watchdog on this core. */
> +	cvmx_write_csr(CVMX_CIU_WDOGX(cvmx_get_core_num()), 0);
> +	/* Spin in a low power mode. */
> +	while (true)
> +		asm volatile ("wait" ::: "memory");
>  }
>  
>  
> 
