Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2014 23:27:30 +0100 (CET)
Received: from mail-qa0-f45.google.com ([209.85.216.45]:50218 "EHLO
        mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823119AbaBUW1214HjU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Feb 2014 23:27:28 +0100
Received: by mail-qa0-f45.google.com with SMTP id m5so4068545qaj.18
        for <linux-mips@linux-mips.org>; Fri, 21 Feb 2014 14:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=TlyuP9kFfR1sT6ErVEj7CKIELpHnDcGRNjizsUopOTE=;
        b=Sfdbci7qed4TqG54SNq1fNGlB89tXj4Co+hVot5rOOTwW4c0INZ6QRRlROgsOOvUbD
         kyW1lAd/rkXU42EAEI31pxcJ24O1aaU9eFAncVbUnvH+vKyHRe30H+QpHqOxrJtgQpLT
         eXy12BLzf/g1jPzTAVnwAlA+Zh8RsleW/o+2M4CxiaTiCdNZ3bkeA++h6eDrS6aId17J
         gKIQ2jn1PQrlBAUBHLYswAxCAeDS74P947BoBl7cKwPifKy3F4RCFoa8TZDb7tS9r6TV
         QQGjyMvntl6kxNskw4zYhjGfawpW29wt9R20Y/PoVL+K4TaWDPLQQrbNpA+a9R4+6Gf9
         zb2Q==
X-Gm-Message-State: ALoCoQn8R3vX/Qhg4MNlJXc8EDHm8U9Aj4AUXrB0xw1e5nOuho4weKMOumeH7+Vg2Pdxb5onxoMY
X-Received: by 10.224.67.193 with SMTP id s1mr13504385qai.53.1393021642447;
        Fri, 21 Feb 2014 14:27:22 -0800 (PST)
Received: from xanadu.home (modemcable177.143-130-66.mc.videotron.ca. [66.130.143.177])
        by mx.google.com with ESMTPSA id u10sm16764298qar.21.2014.02.21.14.27.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 14:27:21 -0800 (PST)
Date:   Fri, 21 Feb 2014 17:27:20 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Paul Burton <paul.burton@imgtec.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] cpuidle/mips: remove redundant cpuidle_idle_call()
In-Reply-To: <20140221214428.GJ19285@linux-mips.org>
Message-ID: <alpine.LFD.2.11.1402211719140.17677@knanqh.ubzr>
References: <alpine.LFD.2.11.1402171101060.17677@knanqh.ubzr> <20140221214428.GJ19285@linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <nicolas.pitre@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicolas.pitre@linaro.org
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

On Fri, 21 Feb 2014, Ralf Baechle wrote:

> On Mon, Feb 17, 2014 at 11:09:45AM -0500, Nicolas Pitre wrote:
> 
> > I noticed commit c0b5d598aefda in linux-next adds a call to 
> > cpuidle_idle_call().  At the same time we're rationalizing the idle 
> > handling code in order to integrate it with the scheduler proper.  
> > Please note that a similar patch to the one below will be necessary once 
> > everything gets merged together.
> 
> So how shall we merge this patch, shall I fold it into c0b5d598aefda or?

Merging it on your side is probably the best option.  There would be a 
window in mainline during which the callback registered with cpuidle 
won't be invoked, but that is not worse than the v3.13 behavior.


Nicolas
