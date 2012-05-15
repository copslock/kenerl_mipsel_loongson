Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 13:10:57 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:53736 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903612Ab2EOLKv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2012 13:10:51 +0200
Received: by laap9 with SMTP id p9so5063159laa.36
        for <linux-mips@linux-mips.org>; Tue, 15 May 2012 04:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=7HAbD6zF+LUOSsK/OnXDYYwQm1ON65TbP4fwy2oUkqw=;
        b=hhqY3FMGvO6foky61Y2lQY87IOwIe9KETTisFT8giGBcMqFAyppQ+z9kBms1LZ8jrz
         HOxbITrXcrTfrccCTpHNB4sCrfqXFfd/5Uew6C7EyMTUBslL+64mgctgNoLyLK0FkD41
         jbTdmqz1n/mwCO3s6LDhb6tHnK7MOC3+7wU3X6i+r5CRqADuMe60Ge2a81KPyK70U6dh
         ZU6FkuuWVcAGBUyHyXRC4/+rifwUGJBFnJeuR17ATaEn6zBG5kZN+GzZG31r5jJrn5ku
         NcvZKLkPmUh7qrKQL6YX0hfcU57GJp37+aZzD/439WCDyzakeHDPORlQSdwdln/gNfZc
         SYhQ==
Received: by 10.112.29.166 with SMTP id l6mr3658764lbh.68.1337080246305;
        Tue, 15 May 2012 04:10:46 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-80-113.pppoe.mtu-net.ru. [91.79.80.113])
        by mx.google.com with ESMTPS id gi19sm6326862lab.16.2012.05.15.04.10.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 May 2012 04:10:44 -0700 (PDT)
Message-ID: <4FB23997.7030004@mvista.com>
Date:   Tue, 15 May 2012 15:10:15 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v2 2/5] MIPS: Make set_handler() __cpuinit.
References: <1337040290-16015-1-git-send-email-ddaney.cavm@gmail.com> <1337040290-16015-3-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1337040290-16015-3-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkWYk4SAyeNPFJ+8Rd+ai1pZE7ow2/arzXk0KQIICDfog56yp/WfOB4hmIVrXendixQJbfa
X-archive-position: 33325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 15-05-2012 4:04, David Daney wrote:

> From: David Daney<david.daney@cavium.com>

> Follow-on patched require this.

    s/patched/patches/
    Maybe Ralf would correct this...

> Signed-off-by: David Daney<david.daney@cavium.com>

WBR, Sergei
