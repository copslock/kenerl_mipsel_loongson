Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Mar 2013 19:06:59 +0100 (CET)
Received: from mail-bk0-f45.google.com ([209.85.214.45]:49267 "EHLO
        mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826582Ab3CKSG6z8njJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Mar 2013 19:06:58 +0100
Received: by mail-bk0-f45.google.com with SMTP id i18so1837441bkv.32
        for <linux-mips@linux-mips.org>; Mon, 11 Mar 2013 11:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=ReFzloy1+0tonQdm9zCoWt6X+ijS4GLlWiacRKP/Ems=;
        b=ExyABORfUgu0mpvBIYCPBeEEKv033htOy0EVMIZqkiTJQYz0wuTT7AdBZoO5/jspHV
         O4/snhpgT1jxpCc41t6W6a98hSptbyvp2bFt0ynCGUhVqi0x5P9AHzekQSv8fKfEOrrP
         RymhnohnnhH6MA76ZJ7piIqAxm59uYbo77jhU32tOP1sT5/z4I1/7THehsv0+Te6aDeO
         yDqhxbc9AAhyHnoyOLcPeKL+KvBz7fTyD2Cty6BH1X7EgODN/Rmas5G5I3NUnl/Etnq5
         us1q9j0ZYtZVPljDEQXH8HJZr0N+1ip0XsEhgRFgnyccIlYOL3nn3BejiCkAV7VOKqGR
         b8VQ==
X-Received: by 10.205.96.197 with SMTP id ch5mr5057051bkc.52.1363025213321;
        Mon, 11 Mar 2013 11:06:53 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-79-93-4.pppoe.mtu-net.ru. [91.79.93.4])
        by mx.google.com with ESMTPS id o2sm4413340bkv.3.2013.03.11.11.06.50
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 11:06:52 -0700 (PDT)
Message-ID: <513E2B89.40308@cogentembedded.com>
Date:   Mon, 11 Mar 2013 22:07:53 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
MIME-Version: 1.0
To:     Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, juhosg@openwrt.org,
        blogic@openwrt.org, kaloz@openwrt.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: use newly introduced devm_ioremap_resource()
References: <1363015477-29685-1-git-send-email-silviupopescu1990@gmail.com>
In-Reply-To: <1363015477-29685-1-git-send-email-silviupopescu1990@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmRrNVMqR6fO+34VuJcuXBkFt9Zamp3eHFSrQIH4BHUaNEXWwcwbhRQBE2lyb6laAy+g4Ty
X-archive-position: 35868
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 03/11/2013 06:24 PM, Silviu-Mihai Popescu wrote:

> Convert all uses of devm_request_and_ioremap() to the newly introduced
> devm_ioremap_resource() which provides more consistent error handling.
>
> devm_ioremap_resource() provides its own error messages so all explicit
> error messages can be removed from the failure code paths.
>
> Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
> ---
>   arch/mips/pci/pci-ar71xx.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
    I think the idea was to combine changes to the 2 files in one patch.
Then the subject will truly reflect what it's doing...

WBR, Sergei
