Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 21:01:47 +0200 (CEST)
Received: from mail-la0-f47.google.com ([209.85.215.47]:33744 "EHLO
        mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013228AbbGFTBqGm6Fn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 21:01:46 +0200
Received: by laar3 with SMTP id r3so167621201laa.0
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 12:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ABKpU8b+6+q0+TSUf2xawsAlCKKdfXcDmC2l9/9WtNQ=;
        b=mI49erMFDhY0H5S5VmyO0FKY531mBD9X8rWUaXFHVugYIwE3HsiFRc75hFjtm0BS0K
         Yf5y6e7OnuyFChYRP8HNT27PxMv+m3GUoJdr+u3h2pzFOUDG0HkWHMP5EjKV0igiWD+G
         rXhfKIgrbybPQxepOYVdRbMdIPtFxC84LBLWCachYsiVz1OdOPXWbWC5K3LZVDXBxxgn
         v30KMwWzWdG+JejOswNaUw/VonuzVuR2g3XE+zsSkygFm87hvwRnekv26BFJwheTBTrX
         97++LIN5XTtJ7c91ylnJihVSbypLWm1vrX/QAlqb7kXCrbYC1bq89wENwUVMsfQA+LBL
         Zaiw==
X-Gm-Message-State: ALoCoQmt3nHV8CNVU266U9/nePscce4mvTvo1Y3RCtri75xpW+uyd5lbj6RyI3mYZdOohDmqADVj
X-Received: by 10.152.45.9 with SMTP id i9mr289528lam.87.1436209300627;
        Mon, 06 Jul 2015 12:01:40 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-249-53.pppoe.mtu-net.ru. [83.237.249.53])
        by mx.google.com with ESMTPSA id l5sm760671lal.29.2015.07.06.12.01.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 12:01:39 -0700 (PDT)
Message-ID: <559AD091.2080505@cogentembedded.com>
Date:   Mon, 06 Jul 2015 22:01:37 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
CC:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH 01/14] MIPS/alchemy/time: Migrate to new 'set-state' interface
References: <cover.1436180306.git.viresh.kumar@linaro.org> <7b140cad62ca40bc9dbe6678c34b6b5d42848a0d.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <7b140cad62ca40bc9dbe6678c34b6b5d42848a0d.1436180306.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48085
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

Hello.

On 07/06/2015 02:11 PM, Viresh Kumar wrote:

> Migrate alchemy driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.

> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.

> We weren't doing anything in the ->set_mode() callback. So, this patch
> doesn't provide any set-state callbacks.

    This is broken as well, for the same reason as cevt-r4k.c.

WBR, Sergei
