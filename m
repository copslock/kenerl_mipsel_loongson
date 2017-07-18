Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2017 21:55:30 +0200 (CEST)
Received: from mail-wr0-x241.google.com ([IPv6:2a00:1450:400c:c0c::241]:34202
        "EHLO mail-wr0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994845AbdGRTzX1MkoZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2017 21:55:23 +0200
Received: by mail-wr0-x241.google.com with SMTP id w4so7331381wrb.1;
        Tue, 18 Jul 2017 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+csPmFxFy8k9WwhCUFJHcV1xya0JNSwsismP2egylF0=;
        b=rcHaMy9qghE5J/WeNG3z8HQDyyJJK+FHR/9/tIulTT8C3hYNDcj8LVtb55B7rFdOdj
         I9teJbF8MteqzEY6ZJS3Ra8Da4KZ3YzrpN2Ny9vuDEIWcwG/2k+yVofr7Uktk85jn0ea
         PYq18+1KLJmS4/OgSFaAMXmp9Lrj2C9sXldRRyxo6j4x8OMGTKYgjdVm024+F4MkHOnL
         RdSki37arfuSKlOX+3NpX6imtloK+bZBgC3RsSZkyunkRLqmOntbv2Oz9L23MREgPR82
         6ftBgsP7tvn1RK/wB/LkeszO0M5ubepQBcmLVsA4SdX//19v62FerW/qtrzFjcbxRp7m
         fHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+csPmFxFy8k9WwhCUFJHcV1xya0JNSwsismP2egylF0=;
        b=TYbMLtgSfq/HqvU6ERGp21XGYBcpuvL8ksaELyU+3q0YgqEmpOsipXUqJF8Is0pZd4
         PsW/X0PrgHvwc6xBMNK8iazNX5QeIWu+T2Nwvwq8wHWf6/LHhfhh/kx8a0h2nli68WG+
         8ea+7KdV/XjTSKvMPgMCddI4qQepjD0ii9oHoCJxF9rc5tMWFAOmHv36pW1nUwWqct1S
         hNxPeaPfaB8QI/1foti+ysjtV1fCCIHhUR60NkskfcIPULjILFRPTUguTJO17+XNPPoF
         5x4zGSWqkPw4VgRFaNU7C6S4nqOmJJcK8rT7o/xixfC4NvMyz5gZEKRr8D8WwSXjO5/E
         qdCg==
X-Gm-Message-State: AIVw111N6ZuMo5DQA9Frfce4ycJPAeSPrc4O3DzvfKaRsaZdmzkGcIwV
        /RMAbEbFnqp11A==
X-Received: by 10.223.131.162 with SMTP id 31mr2062598wre.161.1500407718156;
        Tue, 18 Jul 2017 12:55:18 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id 90sm2736337wrk.38.2017.07.18.12.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2017 12:55:17 -0700 (PDT)
Subject: Re: [PATCH 6/9] MIPS: BCM63XX: allow NULL clock for clk_get_rate
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <20170718101730.2541-1-jonas.gorski@gmail.com>
 <20170718101730.2541-7-jonas.gorski@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d2ced2a2-ab53-4bc1-b767-52298c946bca@gmail.com>
Date:   Tue, 18 Jul 2017 12:55:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170718101730.2541-7-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59138
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

On 07/18/2017 03:17 AM, Jonas Gorski wrote:
> Make the behaviour of clk_get_rate consistent with common clk's
> clk_get_rate by accepting NULL clocks as parameter. Some device
> drivers rely on this, and will cause an OOPS otherwise.
> 
> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs.")
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> Reported-by: Mathias Kresin <dev@kresin.me>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
