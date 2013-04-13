Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Apr 2013 16:50:58 +0200 (CEST)
Received: from mail-la0-f48.google.com ([209.85.215.48]:43199 "EHLO
        mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817043Ab3DMOu5HQl1D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Apr 2013 16:50:57 +0200
Received: by mail-la0-f48.google.com with SMTP id fq12so3278729lab.35
        for <linux-mips@linux-mips.org>; Sat, 13 Apr 2013 07:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=VXiAjv/Vbzi2Ljzf61bcTxgSt59nH3nHvBgLdNdH6Pw=;
        b=iW3vMRCnsVSMQFc0xR5v6+SwnfQvWvAnmpxyMD1Q8jwYezUuKRKnI3FbS5BdrYiU6S
         X95f6Vnq9Ox++4Ozs73Y10rZbJJ/IcY3E3W4yB0SqEMP0JT6+xoaP+DnSZotZv9gpvjp
         JsdA+znEuHSYkw4M97rKJZic4TbH7muDS65E7fJvXSHFgz6kHwnRA4xboHjlWEq2rTBR
         +2Y1FE+agAt6wzFywlahf4H8UbiJouSORspVEx+UYuD3rI3G5zCFNVDH/A6dgQYYYgAE
         /VLsOivWSm+I0PpzLVJINzlVYtO0pGNl1sNA2KjruymAmqUNvov26B655atZvFJiFiqM
         R/5g==
X-Received: by 10.152.116.73 with SMTP id ju9mr6236744lab.54.1365864651349;
        Sat, 13 Apr 2013 07:50:51 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-80-142.pppoe.mtu-net.ru. [91.79.80.142])
        by mx.google.com with ESMTPS id f7sm4928853lbj.13.2013.04.13.07.50.49
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 13 Apr 2013 07:50:50 -0700 (PDT)
Message-ID: <5169708C.6040209@cogentembedded.com>
Date:   Sat, 13 Apr 2013 18:49:48 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 3/6] DT: MIPS: ralink: extend RT3050 dtsi and dts file
References: <1365843026-11015-1-git-send-email-blogic@openwrt.org> <1365843026-11015-3-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365843026-11015-3-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQm80CScq3c/hB9N239VK2FUONEeLWBRxA6/TZIZiUS8d9JQwHt0zNx2yr/Zom+pqiy7M1Zc
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36150
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

On 13-04-2013 12:50, John Crispin wrote:

> * remove nodes for cores whose drivers are not upstream yet

    And you call that "extend"? :-)

> * add compat string for an additional soc
> * fix a whitespace error

> Signed-off-by: John Crispin <blogic@openwrt.org>

WBR, Sergei
