Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 13:24:40 +0200 (CEST)
Received: from mail-la0-f47.google.com ([209.85.215.47]:43312 "EHLO
        mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834877Ab3DOLYjIgNN9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 13:24:39 +0200
Received: by mail-la0-f47.google.com with SMTP id eh20so3160391lab.20
        for <linux-mips@linux-mips.org>; Mon, 15 Apr 2013 04:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=npRTsuJOEkR5jH24kjfCvi38gS0FJBB+oF1qU2AIgZw=;
        b=NQf/TtLWCaQesa79Bs7d1DzLJtfIg9Wm35B1HBF0soDJ2KyRCBVrkcphijXb32ghmR
         ol9XPQTDwDieI7YzWEhHrpGZGBeBzPACH5HYvY9ww5SZId7bqESyn+72tdavPYq9ozjD
         hMOxgTDYf9VtGLf3y5YhxYPNwbRueInLOUDyKbbXUy2Y9nX2iYyBhnnHfg819is+S51T
         cH/uX71qruwtCGc+120/NhJQjQZ/ofe7yH7lSw5TncFlGlBqllLW4dpWD7QGqB3G35iT
         deuXx3SuN21bMOHb4XXu70NEw8o3oIb9fEjC6fctV09SXtnKQHpREqAEPqdNZBScvV7f
         2gIQ==
X-Received: by 10.152.114.164 with SMTP id jh4mr10238472lab.1.1366025073360;
        Mon, 15 Apr 2013 04:24:33 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-88-234.pppoe.mtu-net.ru. [91.79.88.234])
        by mx.google.com with ESMTPS id jh4sm7913855lab.7.2013.04.15.04.24.31
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 04:24:32 -0700 (PDT)
Message-ID: <516BE330.2000502@cogentembedded.com>
Date:   Mon, 15 Apr 2013 15:23:28 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] owrt: MIPS: ralink: add usb platform support
References: <1366021644-8353-1-git-send-email-matthijs@stdin.nl> <1366021644-8353-3-git-send-email-matthijs@stdin.nl> <516BD656.6090709@phrozen.org>
In-Reply-To: <516BD656.6090709@phrozen.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlJbj3THe+acueMLbkSwGpcfJFvPHp5IeLjTgYW94rYnKwn7tidqEKGyxQumZk1YinbCLEX
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36178
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

On 15-04-2013 14:28, John Crispin wrote:

>> From: John Crispin<blogic@openwrt.org>

>> Add code to load the platform ehci/ohci driver on Ralink SoC. For the usb core
>> to work we need to populate the platform_data during boot, prior to the usb
>> driver being loaded.

>> Signed-off-by: John Crispin<blogic@openwrt.org>
>> [matthijs@stdin.nl: Extracted non-ohci/ehci 3052 code into separate patch]
>> Signed-off-by: Matthijs Kooijman<matthijs@stdin.nl>

> this patch sits ontop of a patch from openwrt that adds a OF binding for
> ohci/ehci so it wont go upstream until the usb people decided how to expose
> ohci-platform and ehci-platform in OF

    Note that there's already a patch exposing ehci-platform to DT in Greg's 
'usb-next' branch:

https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=f3bc64d6d1f21c1b92d75f233a37b75d77af6963

>      John

WBR, Sergei
