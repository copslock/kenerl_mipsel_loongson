Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Feb 2013 11:56:44 +0100 (CET)
Received: from mail-wg0-f43.google.com ([74.125.82.43]:41816 "EHLO
        mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822501Ab3BHK4nTPPgN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Feb 2013 11:56:43 +0100
Received: by mail-wg0-f43.google.com with SMTP id e12so2860813wge.22
        for <multiple recipients>; Fri, 08 Feb 2013 02:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type;
        bh=5LVpgDT62+99OAzRGVWb/YTS9d6+ma5SvB4zE+gXf+g=;
        b=gMnhu/ss3Dxz23q9v4NId+j8rYuxiRmqcXvhIPAIbTrV9osJ2a3ABZXvhVaZ4As6ui
         AWULavf2q741gRIgyUnqjUY1HQyxYEn1RJ/Vh7I7eEm6VDjIFGOaPA8dP6NDwXlPCNLd
         cm6l5gJ2p618hZgXC3thAhy124N2wdMb3m74sBPYT0YTfUCirKVf/2FWlo7Cn/njsH5o
         4nNArCNhTXuwyOjqO4D/iPoaqkBZTD/Z3tEqiUlpHItR0G4G93xIac64rfqRWLkqs8/8
         IHGFK1701o8Fl9wjcvpdUkj3x5Y7E8XngkXW7OVtpvWISfxG6Y1X/uZgKiNTD0h8Gndz
         pfVQ==
X-Received: by 10.180.99.72 with SMTP id eo8mr1544436wib.34.1360320997552;
        Fri, 08 Feb 2013 02:56:37 -0800 (PST)
Received: from ?IPv6:2a01:e34:ec0d:40e0:200:5aff:fe70:ca64? ([2a01:e34:ec0d:40e0:200:5aff:fe70:ca64])
        by mx.google.com with ESMTPS id m6sm14692921wic.2.2013.02.08.02.56.35
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Feb 2013 02:56:36 -0800 (PST)
Message-ID: <5114D932.5050509@openwrt.org>
Date:   Fri, 08 Feb 2013 11:53:38 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org, blogic@openwrt.org
Subject: Re: [PATCH] MIPS: SMTC: fix implicit declaration of set_vi_handler
References: <1360320314-9255-1-git-send-email-florian@openwrt.org>
In-Reply-To: <1360320314-9255-1-git-send-email-florian@openwrt.org>
Content-Type: multipart/mixed;
 boundary="------------090507080502090101030103"
X-archive-position: 35728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

This is a multi-part message in MIME format.
--------------090507080502090101030103
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2013 11:45 AM, Florian Fainelli wrote:
> This patch fixes the following implicit declaration while building with
> MIPS SMTC support enabled:
>
> arch/mips/kernel/smtc.c: In function 'setup_cross_vpe_interrupts':
> arch/mips/kernel/smtc.c:1205:2: error: implicit declaration of function
> 'set_vi_handler' [-Werror=implicit-function-declaration]
> cc1: all warnings being treated as errors

And attached the config file to reproduce the build failure.
--
Florian

--------------090507080502090101030103
Content-Type: application/gzip;
 name="config-fail.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="config-fail.gz"

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
CHssyyXEI+ke2/w/uhEnG/+gAAA=
--------------090507080502090101030103--
