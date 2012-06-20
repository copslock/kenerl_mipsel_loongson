Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 12:41:34 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:39348 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903596Ab2FTKl0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jun 2012 12:41:26 +0200
Received: by lbbgg6 with SMTP id gg6so435309lbb.36
        for <linux-mips@linux-mips.org>; Wed, 20 Jun 2012 03:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=0OiS/wn16xJ9+bqqcottDmDD5Fcs2R8kBxX992yq6dQ=;
        b=lmZz06I+6bRc656o0BWqx8dvcSn2BKmjYOF/xEudZbGQpUKeDroF62XanXl1yGPzD8
         6K1favNlfUX/LpPndijsnJcfynRei1RuH7LLd8hBt7Q44Sn8p6yMZ10JA/ibRkBoRZzi
         z6Gj0U4ULlttZY+qipgA1/EzdCpBnUUwwki8i13cAiMv00xaDQCZWnp6jth7FMm4Rqoy
         pRmVx6qTvJwrJG43K8e7BPWzILgr07M9tqF/5S4s6bt/YwboKuMA+6U4UqRNTKjZ7biX
         o3uWUlnYCxvlVCKPs2bWDfXhpwweoXvE9baT2bKf+eGqqjoRmU1r9tPZfHHsiWeqKfi9
         pCSA==
Received: by 10.112.54.100 with SMTP id i4mr9633403lbp.97.1340188880395;
        Wed, 20 Jun 2012 03:41:20 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-90-213.pppoe.mtu-net.ru. [91.79.90.213])
        by mx.google.com with ESMTPS id sy1sm39074894lab.13.2012.06.20.03.41.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 03:41:18 -0700 (PDT)
Message-ID: <4FE1A8A9.1040307@mvista.com>
Date:   Wed, 20 Jun 2012 14:40:41 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Yoichi Yuasa <yuasa@linux-mips.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
        Linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>        <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com> <20120620152759.2caceb8c.yuasa@linux-mips.org>
In-Reply-To: <20120620152759.2caceb8c.yuasa@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlAzFGgWl5JWttbkougt793thvL71Qb7pFhlYoe7NNhrMARblfTPku98D0Hg6OmiXRYGYcy
X-archive-position: 33740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 20-06-2012 10:27, Yoichi Yuasa wrote:

> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578

    Please also specify the summary of that commit in parens.

> breaks all MIPS builds.

[...]

> Signed-off-by: Yoichi Yuasa<yuasa@linux-mips.org>

WBR, Sergei
