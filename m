Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 12:18:58 +0200 (CEST)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36582 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011520AbbHLKSza2foX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 12:18:55 +0200
Received: by pdco4 with SMTP id o4so5998590pdc.3
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 03:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=XWeuLYq8XZiCZOQaO5nz9ZKeoPJ/qTxWcWL7goJJwtU=;
        b=OrG0/jP5mrABk5llrGZQnY2wq0khoWofN++bUjmWaqOvSNHFcFwfXfoIEy4mC5/KpF
         QFP1/yg3eFrFSQyiEOLdDag3j11xCbfrBlGwd7jYugEYIWwj8ZGbG9L1x75b5TnX7DAE
         OXZGHYmj/MtFqFE/ktVygKQscHmHhFleYFNYrkTWkLuPNP+xoMZo12IG1x/jmA1A2nxH
         XJR3htYBM4db4teBptCt+W6ZmjesCLSXzG5yqz+24ogLFblAwAuiHS+iz3QWfmtISHAN
         2G+vS9OOl3pPJfuJQjVOIhNwL7tK7Fqn5HEzc86SOXmFYSH9yFM3ffshMVdICS7ZCpCK
         uiaw==
X-Gm-Message-State: ALoCoQlVygu67Kh5M4kh0/QVshm5FUDbGFmEEcGy9iT6yQH5/W/iEjagvAsrhSV6iEVPex1dafRy
X-Received: by 10.70.127.235 with SMTP id nj11mr63956516pdb.70.1439374729423;
        Wed, 12 Aug 2015 03:18:49 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by smtp.gmail.com with ESMTPSA id jr12sm5834083pbb.91.2015.08.12.03.18.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 03:18:48 -0700 (PDT)
Date:   Wed, 12 Aug 2015 15:48:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        Michael Opdenacker <michael.opdenacker@free-electrons.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>
Subject: Re: [PATCH] MIPS:loongson64:hpet: Drop the dangling 'set_mode'
 assignment
Message-ID: <20150812101845.GA20238@linux>
References: <45d35e38970b9c7196faa3a6892d2b5e4e6f40aa.1438851213.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d35e38970b9c7196faa3a6892d2b5e4e6f40aa.1438851213.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

On 06-08-15, 14:25, Viresh Kumar wrote:
> This should have been removed by: 604cbe1de254 ("MIPS: loongson64/timer:
> Migrate to new 'set-state' interface") commit, but it wasn't.
> 
> Remove it now.
> 
> Fixes: 604cbe1de254 ("MIPS: loongson64/timer: Migrate to new 'set-state' interface")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Ralf:
> 
> Not sure how it was left out in my series, but I thought it should have
> been caught by the compilers as the function hpet_set_mode doesn't exist
> today.
> 
> Either merge it with the offending commit or keep it separate.
> 
>  arch/mips/loongson64/loongson-3/hpet.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/loongson64/loongson-3/hpet.c b/arch/mips/loongson64/loongson-3/hpet.c
> index 950096e8d7cd..bf9f1a77f0e5 100644
> --- a/arch/mips/loongson64/loongson-3/hpet.c
> +++ b/arch/mips/loongson64/loongson-3/hpet.c
> @@ -228,7 +228,6 @@ void __init setup_hpet_timer(void)
>  	cd->name = "hpet";
>  	cd->rating = 320;
>  	cd->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> -	cd->set_mode = hpet_set_mode;
>  	cd->set_state_shutdown = hpet_set_state_shutdown;
>  	cd->set_state_periodic = hpet_set_state_periodic;
>  	cd->set_state_oneshot = hpet_set_state_oneshot;

Ping

-- 
viresh
