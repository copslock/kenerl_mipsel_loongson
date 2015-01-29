Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2015 17:33:40 +0100 (CET)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:47996 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012205AbbA2Qdi0KutP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Jan 2015 17:33:38 +0100
Received: by mail-lb0-f180.google.com with SMTP id b6so29979613lbj.11
        for <linux-mips@linux-mips.org>; Thu, 29 Jan 2015 08:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ntzGA+VFvNNEuGU3xaxUptLiLlWK50NTdpvkMpYVqvo=;
        b=hMIPs8xT21t8Vy0U45KVNiVK1MstlB7Ik7M1w3Ijmb5TVba2SIeEA6r/LjieK9wKmK
         YtnHN+Of3R0XjyXXm5o9tepnYcbSgkNZ22Ac5ETt0ArrkVdmBei16i2zkk5SUrobKjlI
         LPfH3Rp03oRBpC9uCSH8AcRuNVQwvigFKOxEeMYZ9Sxkbnaf+JqCM6C38lkpeLjC0Ca7
         qoBvHAZvbaU0AZNQqP0HnVgnRU3EkDod7zTgSwXDcxmJKe9MKjxsFSbtIVeNQ9w+TdV6
         k+JD5E3qkAv4bK3QkVwUffNzn5OoC4yxvWJlDjVIX9OWOloo9kniJr8lScqTOWhwiIMZ
         7JCA==
X-Gm-Message-State: ALoCoQnYopo0sKbMwus17jTz6QUKGv/+24HtZgla6v7uSxdGzG8RbkTe55PrW4RpgL8AjnhabwSE
X-Received: by 10.152.164.232 with SMTP id yt8mr1876088lab.7.1422549212737;
        Thu, 29 Jan 2015 08:33:32 -0800 (PST)
Received: from wasted.cogentembedded.com (ppp28-99.pppoe.mtu-net.ru. [81.195.28.99])
        by mx.google.com with ESMTPSA id k1sm2201952laf.19.2015.01.29.08.33.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2015 08:33:31 -0800 (PST)
Message-ID: <54CA60D9.8080008@cogentembedded.com>
Date:   Thu, 29 Jan 2015 19:33:29 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 2/3] MIPS: Alchemy: preset loops_per_jiffy based on
 CPU clock
References: <1422544004-25254-1-git-send-email-manuel.lauss@gmail.com> <1422544004-25254-2-git-send-email-manuel.lauss@gmail.com>
In-Reply-To: <1422544004-25254-2-git-send-email-manuel.lauss@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45538
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

On 01/29/2015 06:06 PM, Manuel Lauss wrote:

> This was lost during the rewrite of clock framework support.

> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> v2: more syntactic sugar for Sergei,

    Thank you. At least I don't need syntactic insulin in order to digest it. 
There's a risk of the semicolon cancer though. :-)

[...]

WBR, Sergei
