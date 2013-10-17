Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Oct 2013 19:37:59 +0200 (CEST)
Received: from mail-ob0-f182.google.com ([209.85.214.182]:45314 "EHLO
        mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823123Ab3JQRh4iDeb9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Oct 2013 19:37:56 +0200
Received: by mail-ob0-f182.google.com with SMTP id va2so2169806obc.13
        for <multiple recipients>; Thu, 17 Oct 2013 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HY98NJ7yNzpMYG9Vx4eJTCbkNF8Q0COfh2IUSCy3c9Y=;
        b=NR/DDzX9/bu7CkVeKj0G6AlF8pJq0cl4YISIuu+XbbViaA8c0iQK3bQ0oVSqq368kR
         3wazSsCngh6qSX+6Xwz0LlnrOPdRMgGoz7Phv0mV72AppsBNl59fmMh0MgkSvCcax6JD
         sdmkYsuBiLw0ikpXpEC4HmgOyLe5z1iqi1jqHBpIBRf9snDO1h7qUJ3QLTQURYa6DL3S
         LkMr2eHPklcUiaRMM8I50fflrSPrBjc8peWSCy6xcn1SyI/9wJ2nqsUkM9McjQ+w8Lwv
         m6fia9HzTgSzDW6+sP0rdOV6KGNaYDCvEsQRN/a/JC85M8knLk08vvyKO2anQVBwhaKW
         eovg==
X-Received: by 10.182.246.39 with SMTP id xt7mr15648635obc.16.1382031469711;
        Thu, 17 Oct 2013 10:37:49 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id m7sm38013020obo.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 17 Oct 2013 10:37:48 -0700 (PDT)
Message-ID: <5260206B.6000005@gmail.com>
Date:   Thu, 17 Oct 2013 10:37:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>, ralf@linux-mips.org
Subject: Re: [v2 PATCH 5/6] MIPS: APRP: Add support for Malta CMP platform.
References: <1382030506-16588-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1382030506-16588-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

What changed from V1?


On 10/17/2013 10:21 AM, Steven J. Hill wrote:
> From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
>
> Malta with multi-core CM platforms can now use APRP functionality.
>
> Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
> Reviewed-by: Qais Yousef <Qais.Yousef@imgtec.com>
> ---
>   arch/mips/include/asm/amon.h     |    4 ++--
>   arch/mips/mti-malta/malta-amon.c |   24 +++++++++++++++++++++---
>   arch/mips/mti-malta/malta-int.c  |   12 ++++++++++++
>   3 files changed, 35 insertions(+), 5 deletions(-)
>
[...]
