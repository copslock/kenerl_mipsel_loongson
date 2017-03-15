Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 10:04:26 +0100 (CET)
Received: from mail-lf0-x233.google.com ([IPv6:2a00:1450:4010:c07::233]:36027
        "EHLO mail-lf0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990514AbdCOJESSaxGy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 10:04:18 +0100
Received: by mail-lf0-x233.google.com with SMTP id y193so4069399lfd.3
        for <linux-mips@linux-mips.org>; Wed, 15 Mar 2017 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=FW2o8K6fXXPrg3a1JaBQMaT2gpKhtVDvBiYZ/D/asuI=;
        b=SWto5+XUs3VzazoEeBAlLjiJcdd7VsdbYzBXjarsDCbUGh3ss3NoQsT4vvyczFKEYf
         WRxv8BoaBdE5H9ZlePwjNHdlTLGHYKaFJ6ScThLqp+gZjL5Krvr7raEphPUskcfVEAJH
         fjqTEF7SRI0Bzjkxe0hGas+fsTKZ7cH9SK9T4f9/mM5KUHphlOBahxVROd1iucmcg3xa
         li0Li3avOjZyoaeUtwSXa+GR0nPLIIe3fp/0psCArpIoeb4OwZs43lrKrm8Tr7oNqC+B
         aD91N6pR37O9vvsNOgnXkkh7iEZoFi/V6zkTXcPAKvChMtkddaYNsLiwsQZVPqHgrZe7
         qA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=FW2o8K6fXXPrg3a1JaBQMaT2gpKhtVDvBiYZ/D/asuI=;
        b=lkTOGiBpoJMV4c4EpSk0BXrFJ69EcR5C5yJ6gzlkXHZryB1KdWe/b+Gj9t8138R35L
         C6R+DVKbl+6X+rc0hWsvUntdbTJQyYjEjjQt7uvFlpL1T0wNCgzbkQ7mYwc10/duuXag
         k0o8HCIV1GBTolVWYl4FfB/NJ9Pg+Z8Kb1eFCIrf5nLZ3N0wpLFUdhpYctIUKGaJaYf0
         kEyxNb9K+Y6TNtJVlNzYDB74FbzQg75/k6bLBZ7tnrXfz4r9HCLw0i8JAGJUDcYyHy/a
         fbVksEK3lI69D6KiCXy1plo8DSd0iZZBrdvM0URRbe2oIenFELbxS0+Q5AKS2iD3eke9
         vaIA==
X-Gm-Message-State: AFeK/H07FSHLzyR6JfLHrpvIBQAZTwnCEcOaxIp+sO/git2rOv98p75c1XJNJaOUSYhprg==
X-Received: by 10.46.77.149 with SMTP id c21mr490176ljd.80.1489568652773;
        Wed, 15 Mar 2017 02:04:12 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.87.59])
        by smtp.gmail.com with ESMTPSA id q71sm221968lfe.40.2017.03.15.02.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Mar 2017 02:04:12 -0700 (PDT)
Subject: Re: [PATCH] MIPS: PCI: scan PCI controllers in reverse order
To:     Mathias Kresin <dev@kresin.me>, ralf@linux-mips.org
References: <1489565039-2621-1-git-send-email-dev@kresin.me>
Cc:     linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <a676692b-5bca-7d3a-0360-f4cb99dc6676@cogentembedded.com>
Date:   Wed, 15 Mar 2017 12:04:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1489565039-2621-1-git-send-email-dev@kresin.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57283
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

On 3/15/2017 11:03 AM, Mathias Kresin wrote:

> Commit 23dac14d05 "MIPS: PCI: Use struct list_head lists" changed the

    Need 12 digits and () around "<summary>".

> controller list from reverse to straight order without taking care of
> the changed order for the scan of the recorded PCI controllers.
>
> Traverse the list in reverse order to restore the former behaviour.
>
> This patches fixes the following PCI error on lantiq:
>
>   pci 0000:01:00.0: BAR 0: error updating (0x1c000004 != 0x000000)
>
> Fixes: 23dac14d05 ("MIPS: PCI: Use struct list_head lists")

    Need 12 digits.

> Signed-off-by: Mathias Kresin <dev@kresin.me>
[...]

MBR, Sergei
