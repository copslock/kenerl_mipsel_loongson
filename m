Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 13:40:05 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:51247 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903697Ab2DJLj5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2012 13:39:57 +0200
Received: by bkcjk13 with SMTP id jk13so5420331bkc.36
        for <linux-mips@linux-mips.org>; Tue, 10 Apr 2012 04:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=wsGDDOhTZhXNEi0txkl6EnQETbr9xCeKp9isLDe7b1g=;
        b=i0gcz+t8VxldG5lntugtQi8PfT5cyAhnn41zSVNBajT5sTOzEdeHwC2E69zV5LMt2U
         ERjSlW+3/XVSf4IPNxiojBQrMDyGIuexrxHXvTDKkojS5DIXqgEUfW4fVdxDyMH8d14H
         lNIbDoRGt/PozsIaCiCSWlfrLJ9w2ct+JolQvYcoRts3ljq867d1SdaHZ9eFIetSJpwV
         EoX96w4i1q5UGZd+d8/YsfiCmP/dcKDCzsgYeW/k9RQqj/e8tEHL+hhlBdNehzUc7bJa
         IuA2Lf+CBDzGsbQ65+SDuf4laem1NWX2Z6zMC0dvLbIsBLAFTrT5kE6YJ/ly0wqnhf8N
         0Hlg==
Received: by 10.204.156.146 with SMTP id x18mr4443894bkw.138.1334057992294;
        Tue, 10 Apr 2012 04:39:52 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-84-232.pppoe.mtu-net.ru. [91.79.84.232])
        by mx.google.com with ESMTPS id u5sm35595866bka.5.2012.04.10.04.39.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 04:39:50 -0700 (PDT)
Message-ID: <4F841BA7.6010409@mvista.com>
Date:   Tue, 10 Apr 2012 15:38:15 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: Re: [PATCH] Fix FPU flag race condition.
References: <1333987345-716-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1333987345-716-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQki2k7/z4qhHDTlA5Q7eynUeahO9tywvyFidFDT+p9uNL9NNthZCEOr4kwGEZlGAOuArrn1
X-archive-position: 32921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 09-04-2012 20:02, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>

> Subject:

    Why repeat the subject, modified?

> [PATCH] Fix race condition with FPU thread task flag during context

    Switch?

> Signed-off-by: Leonid Yegoshin <yegoshin@mips.com>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>

WBR, Sergei
