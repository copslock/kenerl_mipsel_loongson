Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 20:11:55 +0200 (CEST)
Received: from mail-la0-f41.google.com ([209.85.215.41]:35101 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013119AbbGFSLxgsyfD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 20:11:53 +0200
Received: by labgy5 with SMTP id gy5so13139551lab.2
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 11:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=efsaXnZTYYOV/MZ62jMEV3TOfCYto/O94Ll1oLHORcM=;
        b=f0GuOud98IHPLAhCCLtEPnSyeVzJ9epYJBRjxdWeESel869dmQilVVthdigV2gQqud
         9MXvJuR96b6yLJgXU7e57iwtPvl2RhDUQoBxRdv7LKN73Si1xf5RQYwdT92/pQ76Nl82
         XQkxB7ZglHo1Uju98TIzX6j9VK/g0VW29Hx+FDJ1PPHdrR5cDibNYRszbDQZQxN8l34G
         wSZB13w8lgnt/Z27TlsyVhmywkWpcFyQPi4hYgXOPo28mXkfZhrdsmlKl48ZeyMFU5MA
         4Bw+vyhtzNj9/JFLEP2yDbB2leybtH4Kkqs0UkYSi39fXrq40xrMUowkQoP1pTrIqjzK
         doJg==
X-Gm-Message-State: ALoCoQnqux5gzcpm0xZ72d0UuCigg9G1mn54Mt84juf/ctzFj/v1zAZ26p7lJxLfXAaALER5XVSG
X-Received: by 10.152.27.197 with SMTP id v5mr163623lag.64.1436206308085;
        Mon, 06 Jul 2015 11:11:48 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-249-53.pppoe.mtu-net.ru. [83.237.249.53])
        by mx.google.com with ESMTPSA id ba6sm4934292lab.26.2015.07.06.11.11.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 11:11:46 -0700 (PDT)
Message-ID: <559AC4E0.80205@cogentembedded.com>
Date:   Mon, 06 Jul 2015 21:11:44 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
CC:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        James Hogan <james.hogan@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH 07/14] MIPS/cevt-r4k: Migrate to new 'set-state' interface
References: <cover.1436180306.git.viresh.kumar@linaro.org> <cc71e2a4cdc16660a59919f22358d159f4bd2ccf.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cc71e2a4cdc16660a59919f22358d159f4bd2ccf.1436180306.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48083
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

> Migrate cevt-4k driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.

> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.

> We weren't doing anything in the ->set_mode() callback. So, this patch
> doesn't provide any set-state callbacks.

    The code in __clockevents_switch_state() looks like it's going to oops as 
you're not implementing set_state_oneshot()...

WBR, Sergei
