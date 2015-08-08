Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Aug 2015 13:34:56 +0200 (CEST)
Received: from mail-lb0-f172.google.com ([209.85.217.172]:33516 "EHLO
        mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010184AbbHHLeyQqy6q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Aug 2015 13:34:54 +0200
Received: by lbbyj8 with SMTP id yj8so73397986lbb.0
        for <linux-mips@linux-mips.org>; Sat, 08 Aug 2015 04:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=CNWc1BNFPE058Trmw1+Rjd2vuL24+yRtHtq0cNya3NQ=;
        b=Nu3oSUtVoCDgUs6nss/AO+Pzt00xNzSS9JWGR+Yc/ovKOl5ZhvmA4p0+jF7Zjokc8L
         KXZv6ZDct7Ula2V2fLwGXvUl4Oad0m+UJXGFg5YG+aXVUfOLFIxy8DuM2APrvHkFD6qT
         DlBru68c/da0gpe950oOLGszrZAIKWYqJo/3Zw+loq6x2p5Hj1nUerJXGu1vEmK0Ln64
         UmWQn+lBBY7h+MWYh6W4KWkBm4+OBB27n5SpZzuwvmG01zkVoXbBCaf7UXj4FdrgRw9x
         PJzTWhe8jiZmg4UmgHUH9JJjJAE5mVl0IvZBHPI444PTD3g63C5ShBDskfYqmM8d9ymr
         k5DA==
X-Gm-Message-State: ALoCoQlTKfqepxEuNxjLZ4YPgvKD178u3sEUHaOVV8Zpp1GJpJy48Z6HFW0TNl4IinTOg1nc923y
X-Received: by 10.112.150.4 with SMTP id ue4mr12539629lbb.26.1439033688757;
        Sat, 08 Aug 2015 04:34:48 -0700 (PDT)
Received: from [192.168.3.154] (ppp25-243.pppoe.mtu-net.ru. [81.195.25.243])
        by smtp.gmail.com with ESMTPSA id a9sm2792981laf.12.2015.08.08.04.34.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2015 04:34:47 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] clk: pistachio: correct critical clock list
To:     Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
References: <1438964413-18876-1-git-send-email-govindraj.raja@imgtec.com>
 <1438964413-18876-5-git-send-email-govindraj.raja@imgtec.com>
Cc:     Zdenko Pulitika <zdenko.pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <55C5E956.5060308@cogentembedded.com>
Date:   Sat, 8 Aug 2015 14:34:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <1438964413-18876-5-git-send-email-govindraj.raja@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48735
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

On 8/7/2015 7:20 PM, Govindraj Raja wrote:

> From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

> Current critical clock list for pistachio enables
> only mips and sys clocks by default but there also
                                                ^ are

> other clocks that are not claimed by anyone and
> needs to be enabled by default.

> This patch updates the critical clocks that needs
> to enabled by default.
     ^ be

> Add a separate struct to distinguish the critical clocks

    Need colon here.

> one is core clock(mips) and others are from periph_clk_*

> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>

MBR, Sergei
