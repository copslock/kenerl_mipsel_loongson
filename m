Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 21:29:41 +0100 (CET)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:35981
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993177AbdB1U3eG2LzN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Feb 2017 21:29:34 +0100
Received: by mail-qk0-x242.google.com with SMTP id u188so5616550qkc.3
        for <linux-mips@linux-mips.org>; Tue, 28 Feb 2017 12:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=R0swP5SzH9onPzQaJlu2CWJ5xPx48oGbi8jocdcaf34=;
        b=H4xDRc+E4Dvnt+Cwad3hN9+ErxyMRNbcMgXQOCpM89TQ4nROuuMCEkyGleCyXGuHdF
         2QegG9HODslf70TypB9nV4D7ATA0Am4QE376HrMJWOW7wcUIeNDVDoBgNHXPupgbgcJh
         6cEB+hJrmDHtjkw/9XCo+c+fq2zquC2vTW8YNNKoQq9PMJE8gxCxxI8dJiT1WC+C6CVY
         /TvWfc5LK/cDPR8KW/heAqbRVWRNlukHkPNJb67MeQ0/tHlyZPcq0gWiperoW0VmJ3r3
         QggSbRadT3lFH8yzEGtiX+sznv+WhmQnuq1AcHRMKuE+s/64+tHlrVCABwfuHCo572L7
         JxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=R0swP5SzH9onPzQaJlu2CWJ5xPx48oGbi8jocdcaf34=;
        b=QC66aRaEVSJmBNHRulMGdBHD9ictkcvh+b/BuIs5XM0E3/fFJbnta5Zcc6pC5eL9L9
         qE+vVAQiEjQFj8VkSBhXDXODHml3pFuunxIWcntNYjSAGm4pjs9Oyy+aEVNIr8B7x4lX
         XxPoQIdE3VSoQBIjesXeKEApQHomDJjYMn+ghwuV9XMFbsm8I3M/QohuFHFblIpiAzWT
         MoonFfVKhyOAAZt4f1j/UqgnQKGIYmpDuXdC8Sad6ixInny8Rxh4qZJIDD+6yRXkHXPH
         x9b09D1JTnCiUeyj2uPHtK+rx/jR0iC1e4hjRPxCNJmQODoVXaHCEEn60oUOq0Vmnems
         ykhg==
X-Gm-Message-State: AMke39le34zuiYR9ojW6R5EM/hs9dER0jBdtd+Q5VOY+gSMPe8js56ufDUnbKwDpaqI7uw==
X-Received: by 10.237.43.68 with SMTP id p62mr5115761qtd.207.1488313768257;
        Tue, 28 Feb 2017 12:29:28 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id i50sm1715844qti.13.2017.02.28.12.29.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Feb 2017 12:29:27 -0800 (PST)
Subject: Re: [PATCH] soc: bcm: brcmstb: Match additional compatible strings
To:     linux-mips@linux-mips.org
References: <20170215004159.11096-1-florian.fainelli@broadcom.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3df8fb67-1809-3781-6f7b-b1057b137f40@gmail.com>
Date:   Tue, 28 Feb 2017 12:29:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170215004159.11096-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 02/14/2017 04:41 PM, Florian Fainelli wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> Match all known sun-top-ctrl compatible strings from our MIPS chips
> counterparts. This allows us to properly report the SoC information to
> user-space through our SoC driver.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.

> ---
> Ralf, James,
> 
> I usually take patches touching this file through an ARM SoC pull request,
> posting to linux-mips for people working on BMIPS STB to get a chance to review
> this.
> 
> Thanks!
-- 
Florian
