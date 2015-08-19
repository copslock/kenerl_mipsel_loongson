Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Aug 2015 10:59:19 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35973 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011322AbbHSI7PxUo0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Aug 2015 10:59:15 +0200
Received: by pawq9 with SMTP id q9so56465018paw.3
        for <linux-mips@linux-mips.org>; Wed, 19 Aug 2015 01:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Bz6Ayi/y0/Q7KpKcnSmv8fV9aYSluipumoTmiGpWMeg=;
        b=WmHScVWYqtNXtwR3VJwweOG3gIJZ2j+4qRJLG9FaHuIkhMsVxRdhR0+QSZidw3+lJy
         9D/zOx0hPpi5wIIqWZNOhsmBB6qIBVS60e9KIiRqqWfVekv9EUy6lLTb4huCsptFHpT/
         PFpPhC0ORlONecnsTIkUXHmQvpnnxl8MjyLBlB9xvh4ZC/cQhJ3tX0VBK9aIWM45kTkf
         blRwwXrwPudIYcWDykZs9E68Pa5jZAfuVah9he5D2aiofv69Pxri81bHy5fGsVWF8CUZ
         qYkhVWIdQfIXUjEgesAVkdMuH6pHY8lL2V2kqJjEfVKI1HPLN/jR6XEk6lVlo8FQUZky
         QfHw==
X-Gm-Message-State: ALoCoQnRazmlEpc18Pzc61N/nlARo9T/d+ZDf1irdfy5x8QQE73P+aEElJ82UD4A2K9s0YJcYCv1
X-Received: by 10.68.196.233 with SMTP id ip9mr22683455pbc.139.1439974749617;
        Wed, 19 Aug 2015 01:59:09 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by smtp.gmail.com with ESMTPSA id n6sm28570pdr.55.2015.08.19.01.59.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Aug 2015 01:59:08 -0700 (PDT)
Date:   Wed, 19 Aug 2015 14:29:04 +0530
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
Message-ID: <20150819085904.GF3258@linux>
References: <45d35e38970b9c7196faa3a6892d2b5e4e6f40aa.1438851213.git.viresh.kumar@linaro.org>
 <20150812101845.GA20238@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150812101845.GA20238@linux>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48942
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

On 12-08-15, 15:48, Viresh Kumar wrote:
> On 06-08-15, 14:25, Viresh Kumar wrote:
> > This should have been removed by: 604cbe1de254 ("MIPS: loongson64/timer:
> > Migrate to new 'set-state' interface") commit, but it wasn't.
> > 
> > Remove it now.
> > 
> > Fixes: 604cbe1de254 ("MIPS: loongson64/timer: Migrate to new 'set-state' interface")
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Ralf:
> > 
> > Not sure how it was left out in my series, but I thought it should have
> > been caught by the compilers as the function hpet_set_mode doesn't exist
> > today.
> > 
> > Either merge it with the offending commit or keep it separate.
> > 
> >  arch/mips/loongson64/loongson-3/hpet.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/mips/loongson64/loongson-3/hpet.c b/arch/mips/loongson64/loongson-3/hpet.c
> > index 950096e8d7cd..bf9f1a77f0e5 100644
> > --- a/arch/mips/loongson64/loongson-3/hpet.c
> > +++ b/arch/mips/loongson64/loongson-3/hpet.c
> > @@ -228,7 +228,6 @@ void __init setup_hpet_timer(void)
> >  	cd->name = "hpet";
> >  	cd->rating = 320;
> >  	cd->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> > -	cd->set_mode = hpet_set_mode;
> >  	cd->set_state_shutdown = hpet_set_state_shutdown;
> >  	cd->set_state_periodic = hpet_set_state_periodic;
> >  	cd->set_state_oneshot = hpet_set_state_oneshot;
> 
> Ping

Another Ping !!

-- 
viresh
