Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2015 22:52:12 +0200 (CEST)
Received: from mail-la0-f44.google.com ([209.85.215.44]:33576 "EHLO
        mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013327AbbGFUwJilnCM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jul 2015 22:52:09 +0200
Received: by laar3 with SMTP id r3so171017866laa.0
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 13:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2SbsowVdy+yiPk69sDwXQHPGHXnpTNttaZfCgNlWDZ0=;
        b=A+aeOKN18LLMwtxaKT21m/9Vd8vsfJ7b9xGx8BYBQefJ3LPnPnqmqdD8s+HB5q6hKS
         BOv7cpVpdeKjPdEJKavXIwcHnXUi8HrAAM+bYWVzIhoeyBEved2sRi4o0d8Swo/knL/Z
         VM7axgWj7lM7fri7/J0+rlk8UI9NJLgrF6n0qhJYN0IL2JCBYkMTdghH9zZXgiCSvt0z
         PgdppOsBJEg7bJJDqenpKOtn+1orJre0QkJGVD7Tbmh+LZWpF4RhiVMStN3VYEdlqmBu
         Q5zjaOGXdlIkUayYCfcGCrzn+2+w2kAdenEJrJ5gAPsGGpP7hR+P1g0BVU0RoaJkpeAC
         Sinw==
X-Gm-Message-State: ALoCoQm+Gn1DFCps7+LKwg+T5+m0N927huBCwG+XJW+fS9zRXvE0UPpBwJ/zkokR1l4JNwV7kppg
X-Received: by 10.112.164.35 with SMTP id yn3mr678940lbb.91.1436215924155;
        Mon, 06 Jul 2015 13:52:04 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-249-53.pppoe.mtu-net.ru. [83.237.249.53])
        by mx.google.com with ESMTPSA id cu1sm5060186lbb.28.2015.07.06.13.52.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 13:52:03 -0700 (PDT)
Message-ID: <559AEA71.3020502@cogentembedded.com>
Date:   Mon, 06 Jul 2015 23:52:01 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
CC:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Michael Opdenacker <michael.opdenacker@free-electrons.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>
Subject: Re: [PATCH 00/14] MIPS: Migrate clockevent drivers to 'set-state'
References: <cover.1436180306.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48089
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

> This series migrates MIPS clockevent drivers (present in arch/mips/
> directory), to the new set-state interface. This would enable these
> drivers to use new states (like: ONESHOT_STOPPED, etc.) of a clockevent
> device (if required), as the set-mode interface is marked obsolete now
> and wouldn't be expanded to handle new states.

> Rebased over: v4.2-rc1

> Following patches:
>    MIPS/alchemy/time: Migrate to new 'set-state' interface
>    MIPS/jazz/timer: Migrate to new 'set-state' interface
>    MIPS/cevt-r4k: Migrate to new 'set-state' interface
>    MIPS/sgi-ip27/timer: Migrate to new 'set-state' interface
>    MIPS/sni/time: Migrate to new 'set-state' interface

> must be integrated to mainline kernel via clockevents tree, because of
> dependency on:
>    352370adb058 ("clockevents: Allow set-state callbacks to be optional")

    I had a hard time finding this by ID, since it hasn't landed in any 
official trees still.

WBR, Sergei
