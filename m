Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Aug 2017 11:09:13 +0200 (CEST)
Received: from mail-lf0-x233.google.com ([IPv6:2a00:1450:4010:c07::233]:37716
        "EHLO mail-lf0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991978AbdHMJJAOnDMP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 13 Aug 2017 11:09:00 +0200
Received: by mail-lf0-x233.google.com with SMTP id m86so29809371lfi.4
        for <linux-mips@linux-mips.org>; Sun, 13 Aug 2017 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UjHSepHMJl1/082sARBNAPVG12F1Cu/em25NfxggR/g=;
        b=qAYWWl0dbq9ZAqw5oyXd+/AYADm5QRXTe6GAi4I1E2IgAHxf8x8dIu/mtJwWmNWkf+
         sH8lCrHzL4PhpgeXqdRzfxN1OVpJu3TfOGV2zTcLyuro+jsWBgJtyeSvmQDyF1C70LTI
         pQzj5kqvRarI6zI2a0/flCjE1b1PlElPoTlTC5yZNc1Zh2X1CbuZMxphg/Mn3dwGmcZI
         tOgh0kKH1SodfPpWlKPAJ/fuZleedfkMlJ2PjWiRzBo3VvIxXDNGUsUA5HsttS+ktl7W
         hz4FVdQq/762gBrm88RGCD7fsg9klU052EZBlv34MXfbTn6iLH/Trmwuoi1S7ve1uIcR
         qnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UjHSepHMJl1/082sARBNAPVG12F1Cu/em25NfxggR/g=;
        b=Xg4yJi7Zk1G2e1As5s8Ys9c/iOYInuYwFR0g++LncTy62lhix3hOpcw7ExvOB0BPeg
         HhVh1xZ3/YPbDyQai5NyMgPtEnJo2Wk2YT9OOHzgv78CJp4cd3+3l87iCKqwYuZ/Vqxc
         Dhujjd8Qq8YhLsyL+TL3DkmoPMFQuHGHDIRSmOL0tcqsiO7WQbZ1mQCXecNEs9IvEmDF
         fd9eTT9QLs2GVtd0aUbMfu4j/r4NwKhZet+tE9UMwbnnGlWti3ylUj2Doq9zTe8We5Wo
         msyX1bS0ZO1PIWCpmcE1vQmLFUPml7OjtadGQnZUjKStmkvWOo9aH3KUJr79kCZ77xr9
         uIfw==
X-Gm-Message-State: AHYfb5jZV/5CP0YcLRt+dry+6SyFP9Dj9jThrW3dvWyi/L+86tytNcuv
        Gv8//z4WFyCDHkq+
X-Received: by 10.25.229.197 with SMTP id i66mr7339251lfk.163.1502615333711;
        Sun, 13 Aug 2017 02:08:53 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.87.50])
        by smtp.gmail.com with ESMTPSA id y65sm936432lfd.13.2017.08.13.02.08.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Aug 2017 02:08:52 -0700 (PDT)
Subject: Re: [PATCH 37/38] irqchip: mips-gic: Use cpumask_first_and() in
 gic_set_affinity()
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>
References: <20170813043646.25821-1-paul.burton@imgtec.com>
 <20170813043646.25821-38-paul.burton@imgtec.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <8af291b4-2cdc-d9aa-88a3-a6c3af856bb4@cogentembedded.com>
Date:   Sun, 13 Aug 2017 12:08:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170813043646.25821-38-paul.burton@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59555
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

Hello!

On 8/13/2017 7:36 AM, Paul Burton wrote:

> Currently in gic_set_affinity() we calculate a temporary cpumask holding
> the intersection of the provided cpumask & the CPUs that are online,
> then we call cpumask_first twice on it to find the first such CPU. Since
> we don't need to temporary cpumask for anything else & we only care

    s/to/the/?

> about the first CPU that's both online & in the provided cpumask, we can
> instead use cpumask_first_and to find that CPU & drop the temporary
> mask.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org
[...]

MBR, Serge
