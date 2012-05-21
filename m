Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 12:31:42 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:45871 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903558Ab2EUKbf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 12:31:35 +0200
Received: by bkwj4 with SMTP id j4so4991475bkw.36
        for <linux-mips@linux-mips.org>; Mon, 21 May 2012 03:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=YLX0a4MXaFzZjrxO5HgmbJsblsiV9zk+Xbjk45trmPc=;
        b=mCrCPGO3QqaVD3M2Z5hT+CPpilFbpEUG8v/V0gPvtSPQLZZodiIZ8FJO86yguU1NCc
         KqF6WE2gRgDTCVPuh6SS0wmffeMMSB3Si72KkwMfZOmo0BS1Bjzt0FxP13coO38V/T3Y
         +F/dqS8jx6v0MFxcA5tDHJh1MBCgOWhG7LBqJh+R9PyAzt+sEqnikadKqswF6G8fVOjn
         5RKehoWgm5bVXgtXebNe1ruL89WDEspX5PToHVjxiem7mSNLp7FcLOx/9OBrNJQ6LnQZ
         6lA+Q2CXA545zC7iCaVyvVsdgyOtnOYZQyOQp6FqKiGOmWhGqvhSYFarQgDeh79h9Iim
         ImBg==
Received: by 10.204.13.78 with SMTP id b14mr7685526bka.32.1337596288944;
        Mon, 21 May 2012 03:31:28 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-83-176.pppoe.mtu-net.ru. [91.79.83.176])
        by mx.google.com with ESMTPS id f11sm26332560bkw.6.2012.05.21.03.31.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 May 2012 03:31:27 -0700 (PDT)
Message-ID: <4FBA1961.2050504@mvista.com>
Date:   Mon, 21 May 2012 14:30:57 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Yong Zhang <yong.zhang0@gmail.com>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, david.daney@cavium.com
Subject: Re: [PATCH 6/8] MIPS: call set_cpu_online() on the uping cpu with
 irq disabled
References: <1337580008-7280-1-git-send-email-yong.zhang0@gmail.com> <1337580008-7280-7-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1337580008-7280-7-git-send-email-yong.zhang0@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlHLXEGl5uxdVsqatsoz2zSUWsvNJu4Hb92H+hESBxHX8hbWS0sAYhiqAPfwFR5SiW4VwhA
X-archive-position: 33398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 21-05-2012 10:00, Yong Zhang wrote:

> From: Yong Zhang<yong.zhang@windriver.com>

> To prevent a problem as commit 5fbd036b [sched: Cleanup cpu_active madness]
> and commit 2baab4e9 [sched: Fix select_fallback_rq() vs cpu_active/cpu_online]
> try to resolve, move set_cpu_online() to the brought up CPU and with irq
                                                ^^^^^^^^^^
    Now the same change in the subject please.

> disabled.

> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>
> Acked-by: David Daney <david.daney@cavium.com>

WBR, Sergei
