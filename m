Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2017 11:21:36 +0200 (CEST)
Received: from mail-lf0-x232.google.com ([IPv6:2a00:1450:4010:c07::232]:36828
        "EHLO mail-lf0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbdC0JV2Y7hWX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Mar 2017 11:21:28 +0200
Received: by mail-lf0-x232.google.com with SMTP id x137so17160974lff.3
        for <linux-mips@linux-mips.org>; Mon, 27 Mar 2017 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=FSz14took+oBPp8vuei1Ai85yLCLgkHk2dC1YPPmq+I=;
        b=ygLSqLydJ0o3cHZe32estcpjzk56ymo2pBibHdqQoupalXglC1i+Tvj4xlEmpe83Mz
         R+eaClMczZrz0HDbtmAmyvxkTHfqhJqjejt8QwpaTXrbGC4rA7HUD1+b/XORkTYHRzcB
         MxK21/BkullR2Gk4T6YLyz3O1eQFDlgfkH9DeXW/macXQABCzPTlPtsmcEXB4Xys4unl
         iRAygaEWGbXb2bumxoLiMfqmonXIfgjA00XvbYBce+Ud5kMxyNOsMnqn8bH79Kvwiqbk
         39LINXQQxbMpV3OAd+4U8vpXHTv0mXGU6d39QVRZp2G/aYNohYnu+HnCZDCCFuz5/eXK
         lk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=FSz14took+oBPp8vuei1Ai85yLCLgkHk2dC1YPPmq+I=;
        b=cyG2wvx4NdsvAHUqMWSFURsZpaqbdxkvd1amcRbTyCrjueCfc+sNc5smKE+JDTPscB
         NmixiyhYpeT/JW+vT2Vgt4L0nMLopktmk45yXi5gio+6M6YXPLUt4U3Zkm7BnXE4vfG4
         agHMqh101cd0k3j79x4ZKn6y43M77fWcaTzcS4Kfv0C8a6W+8D4m2acaclIBz2x8cSCu
         3km0I6sBELCo4rdbXzi2nlyK96jo+xvMvdojJdlmwQ559YQJLWHPxemAta2kY2vddHp9
         lp3a9CMef3goPHt/BtS8Dw86pfz8v4fvqXXHhUROeT6Z6YB43YiI43dco82ZWD5GwR1+
         SbCw==
X-Gm-Message-State: AFeK/H0qqiEG6RHU7W0QDf4wPTzlp/A+Gz4KS03Ne4fBa96VZwFtf3xWzXoMslfphYj+lQ==
X-Received: by 10.25.39.14 with SMTP id n14mr9909769lfn.0.1490606482783;
        Mon, 27 Mar 2017 02:21:22 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.86.91])
        by smtp.gmail.com with ESMTPSA id d72sm1854715lfe.58.2017.03.27.02.21.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Mar 2017 02:21:22 -0700 (PDT)
Subject: Re: [PATCH v3] MIPS: PCI: add controllers before the specified head
To:     Mathias Kresin <dev@kresin.me>, ralf@linux-mips.org
References: <1490547936-21871-1-git-send-email-dev@kresin.me>
Cc:     linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5afd93ac-94c8-6ede-9b6f-f004fc462908@cogentembedded.com>
Date:   Mon, 27 Mar 2017 12:21:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1490547936-21871-1-git-send-email-dev@kresin.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57450
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

On 3/26/2017 8:05 PM, Mathias Kresin wrote:

> With commit 23dac14d058f ("MIPS: PCI: Use struct list_head lists") new
> controllers are added after the specified head where they where added

    s/where/were//

> before the specified head previously.
>
> Use list_add_tail to restore the former order.
>
> This patches fixes the following PCI error on lantiq:
>
>   pci 0000:01:00.0: BAR 0: error updating (0x1c000004 != 0x000000)
>
> Fixes: 23dac14d058f ("MIPS: PCI: Use struct list_head lists")
> Signed-off-by: Mathias Kresin <dev@kresin.me>

[...]

MBR, Sergei
