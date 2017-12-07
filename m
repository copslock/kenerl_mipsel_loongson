Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2017 12:17:41 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:45123
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990433AbdLGLRdcBqbI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2017 12:17:33 +0100
Received: by mail-wm0-x241.google.com with SMTP id 9so12364887wme.4
        for <linux-mips@linux-mips.org>; Thu, 07 Dec 2017 03:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eut2KpBvjueKRQ0bSTHB/iXIOLkFXtg4jdmPy5F4gf0=;
        b=WBcGgUCO7xbzC/KKtUgy/+LzZW6TKAQYa7ryY6oR6+4MKJv7lgG3ox63oXJkNqvszZ
         dHJunAdHb4eTK+nF7Pp8brTG3jENUCPHX0GYN24ukWNHnyNT4Lsr+46MgjWiPLCK2zMQ
         CrUz+8v1lnxHZ0JO36QZSIPGpP4u63YO9kYW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eut2KpBvjueKRQ0bSTHB/iXIOLkFXtg4jdmPy5F4gf0=;
        b=QARDeGMaUBf/KHYCDAKsLxlyHYyw0SUsmKM+TnpVuEuwIKOpbh9r7wIpf9iCuDZuv9
         Xq4GaWDuTmZajtBCGCa+euSV0jnmAA0JbZtryrEKDYf8DlFajbghJtFZzUeNLNXfGUN1
         KEKyYBfQjauVWjinWxnKsYoBaYVA0nq3T8cnkAnjLgK6bp9FXz8+IlzDeVunYquOPJrd
         iC+3+vXNUK6zFEV1soqhbvKEzUk5sxykfX44fk1Xe5Vd77kbSPKG+EPCLVfFsW8YcL1G
         pgFAaBhz+rUIuwyndso+hFF5nzI8itw99XC7zTbshXLcN2Unno71NDy9SuPxv+kHrMON
         rcRQ==
X-Gm-Message-State: AKGB3mI4Wxw+hQzr0/ionGGo4He1vbEfjTuBVlK2yFK/G2wQfHWRscV8
        +JGs2JktLxO69RwTdgbZ7eRx2eGlrmI=
X-Google-Smtp-Source: AGs4zMaxZaEwuY7oS8ox2EpOPvZH1k83bkt81YjrQHAxZX0D1Gf11fsczy3KamsSADVYyKRw3bTQVw==
X-Received: by 10.28.16.212 with SMTP id 203mr805859wmq.16.1512645447780;
        Thu, 07 Dec 2017 03:17:27 -0800 (PST)
Received: from ?IPv6:2a01:e35:879a:6cd0:3e97:eff:fe5b:1402? ([2a01:e35:879a:6cd0:3e97:eff:fe5b:1402])
        by smtp.googlemail.com with ESMTPSA id q140sm5429183wmd.35.2017.12.07.03.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2017 03:17:27 -0800 (PST)
Subject: Re: [RFC PATCH] cpuidle/coupled: Handle broadcast enter failures
To:     James Hogan <james.hogan@mips.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
References: <20171205225536.21516-1-james.hogan@mips.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d74c6e8b-3020-6bed-4cf1-132f41a2c5ff@linaro.org>
Date:   Thu, 7 Dec 2017 12:17:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171205225536.21516-1-james.hogan@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61335
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 05/12/2017 23:55, James Hogan wrote:
> From: James Hogan <jhogan@kernel.org>
> 
> If the hrtimer based broadcast tick device is in use, the enabling of
> broadcast ticks by cpuidle may fail when the next broadcast event is
> brought forward to match the next event due on the local tick device,
> This is because setting the next event may migrate the hrtimer based
> broadcast tick to the current CPU, which then makes
> broadcast_needs_cpu() fail.
> 
> This isn't normally a problem as cpuidle handles it by falling back to
> the deepest idle state not needing broadcast ticks, however when coupled
> cpuidle is used it can happen after the coupled CPUs have all agreed on
> a particular idle state, resulting in only one of the CPUs falling back
> to a shallower state, and an attempt to couple two completely different
> idle states which may not be safe.
> 
> Therefore extend cpuidle_enter_state_coupled() to be able to handle the
> enabling of broadcast ticks directly, so that a failure can be detected
> at the higher level, and all coupled CPUs can be made to fall back to
> the same idle state.
> 
> This takes place after the idle state has been initially agreed. Each
> CPU will then attempt to enable broadcast ticks (if necessary), and upon
> failure it will update the requested_state[] array before a second
> coupled parallel barrier so that all coupled CPUs can recognise the
> change.
> 
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
> Is this an acceptable approach in principle?
> 
> Better/cleaner ideas to handle this are most welcome.
> 
> This doesn't directly address the problem that some of the time it won't
> be possible to enter deeper idle states because of the hrtimer based
> broadcast tick's affinity. The actual case I'm looking at is on MIPS
> with cpuidle-cps, where the first core cannot (currently) go into a deep
> idle state requiring broadcast ticks, so it'd be nice if the hrtimer
> based broadcast tick device could just stay on core 0.
> ---

Before commenting this patch, I would like to understand why the couple
idle state is needed for the MIPS, what in the architecture forces the
usage of the couple idle state?

The hrtimer broadcast mechanism is only needed if there isn't a backup
timer outside of the idle state's power domain. That's the case on this
platform?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
