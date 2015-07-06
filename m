Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 21:03:33 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:34633 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013228AbbGFTDc2md0n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 21:03:32 +0200
Received: by lagx9 with SMTP id x9so167247605lag.1
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 12:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=TOL83zwJP6dMeSD2aUCxxGTywpUbsa7XZzOOWgNPsXs=;
        b=KTlv8EDGvbNwHykg5xK0zPc+DKomyFhhFAgtNiOZtV1bKigHMfQKwKiGj6D3+aeftl
         3ZYG5mE456rPgYVrIOb5YA5xhPG6Kw2Zag9FhHO3stsFB1XAcY0sexWSSuxR85pYh3WG
         c+BG1BYJawN0tg1pgttlr5a3zG+ZVByjXHQJsr7ABRBcPjfbyDYaRqjoqGZ3SidTjLuM
         A7M+oWbmb0+1QcyVV/hLyK7ShJytAsHE1jxrMMOVCUABQ201o7KcGnLSt0aeVid3yxZi
         /9UOLYJTsqbFVx+xVHluk/4MUsWgIrO3ikkvjVqrtQ7xgSYfXZfPRA/jZe7LuZ1yAIR8
         Uv3A==
X-Gm-Message-State: ALoCoQmvLXu8uYcbT1+VvTYsXTFThh2HS/iqm+SglhkxK/pSnLqS0VWHhFa66H9X6dFLHnKTWNmA
X-Received: by 10.152.116.76 with SMTP id ju12mr299230lab.75.1436209407226;
        Mon, 06 Jul 2015 12:03:27 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-249-53.pppoe.mtu-net.ru. [83.237.249.53])
        by mx.google.com with ESMTPSA id y3sm4975244laj.8.2015.07.06.12.03.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 12:03:26 -0700 (PDT)
Message-ID: <559AD0FC.4010707@cogentembedded.com>
Date:   Mon, 06 Jul 2015 22:03:24 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
CC:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 02/14] MIPS/jazz/timer: Migrate to new 'set-state' interface
References: <cover.1436180306.git.viresh.kumar@linaro.org> <9392073bddac9adc4f08eb9fbd61f332b1b449f5.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <9392073bddac9adc4f08eb9fbd61f332b1b449f5.1436180306.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48086
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

On 07/06/2015 02:11 PM, Viresh Kumar wrote:

> Migrate jazz driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.

> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.

> We weren't doing anything in the ->set_mode() callback. So, this patch
> doesn't provide any set-state callbacks.

> Cc: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

    Broken too.

WBR, Sergei
