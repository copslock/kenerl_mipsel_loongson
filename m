Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2012 12:59:38 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:64678 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903640Ab2EQK7c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 May 2012 12:59:32 +0200
Received: by laap9 with SMTP id p9so1483392laa.36
        for <linux-mips@linux-mips.org>; Thu, 17 May 2012 03:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=HfrI76B4a1ygVd2/vx+rCLeR+RHcmvvSZf2B+/FtXpM=;
        b=WiXcFRh71Gz3sKgzh/5Y2Z3J+G3PR6cJ6ClP+XqvVR5sT6EU6Kc/6x4uNZcrjuOrqp
         Gx9Uj2Q++rCvW1URv5ODtJ2WXcnOZ0ax3GiLpRcTTsCZfFm6PhcOPNgeRcYufvBXIbvZ
         gK/MxVhxf0NOiUAXUNdiUD7NVl9ZfBeDQ02H10OYgf1qlAehFZJubDKF+xWdqPACPp5C
         1gaMyx4riFNS/KtbK+shkbWfLj2tJdxbrc9ZJM3Gpf62skfMNyr2aI2BU7hfTSwm/NL4
         UMbbcP7lqf1z6KJbu27ZMpwPeIigTXY0cu/x+ihNOz0fML5DlrbsKXlUPeibuvQ8MP/q
         dtog==
Received: by 10.112.82.197 with SMTP id k5mr2985156lby.98.1337252367017;
        Thu, 17 May 2012 03:59:27 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-74-198.pppoe.mtu-net.ru. [91.79.74.198])
        by mx.google.com with ESMTPS id gv8sm7344201lab.14.2012.05.17.03.59.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 May 2012 03:59:26 -0700 (PDT)
Message-ID: <4FB4D9F6.7060401@mvista.com>
Date:   Thu, 17 May 2012 14:59:02 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Yong Zhang <yong.zhang0@gmail.com>
CC:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org, david.daney@cavium.com
Subject: Re: [PATCH 6/8] MIPS: call set_cpu_online() on the uping cpu with
 irq disabled
References: <1337249410-7162-1-git-send-email-yong.zhang0@gmail.com> <1337249410-7162-7-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1337249410-7162-7-git-send-email-yong.zhang0@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnZN8Zm5+SXYd/qCTCXU/pVu4zN2vyuFhASC2hR1nOZ5dZdkooRQhicH2VFotcGN0RS7ee8
X-archive-position: 33351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 17-05-2012 14:10, Yong Zhang wrote:

> From: Yong Zhang<yong.zhang@windriver.com>

> To prevent a problem as commit 5fbd036b&&  2baab4e9 try to resolve,

    Please also specify the summary of those commits in parens.

> move set_cpu_online() to the uping CPU and with irq disabled.

    Uping? Maybe "brought up"?

> Signed-off-by: Yong Zhang<yong.zhang0@gmail.com>

WBR, Sergei
