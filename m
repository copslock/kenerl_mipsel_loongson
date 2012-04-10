Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 13:57:44 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:34018 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903702Ab2DJL5i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2012 13:57:38 +0200
Received: by bkcjk13 with SMTP id jk13so5437490bkc.36
        for <linux-mips@linux-mips.org>; Tue, 10 Apr 2012 04:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=mii7kVH7ZZRJS2T3pnJRW3w25bgIledNowMHxtVJtI0=;
        b=dNHdQpkXMoYr1s5/WhtKV8C/jE7JrMjnVcQP2BNZ2YYKFPnCp3XMRguPlIdTGHH2Pp
         roq60pWYrH66W2jt6j4FaPwkRE3v/W4C2Jpjc3WAAJan77g4emBty5YqjahPTj/xzvAY
         4tfde8G7xL5tpyPpCjNl93BWU42rPiNBPqTmt13utGWo8KIEa3EGk2cvtJRFv6lAgljW
         lOVWSoh3mdSP1p9rvqDW1qMvebG82/oBpjalVdAufxQcfyC9tOcebS6V/dQVPGdrRHgR
         E5LR+iWQwT9ipCSSb8WT6zI8SNmmih1FCImFr0fjT4W2KIaTs79I2hh/gNTGXM1S97sq
         RGdA==
Received: by 10.204.155.143 with SMTP id s15mr4427147bkw.44.1334059053241;
        Tue, 10 Apr 2012 04:57:33 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-84-232.pppoe.mtu-net.ru. [91.79.84.232])
        by mx.google.com with ESMTPS id u5sm35705234bka.5.2012.04.10.04.57.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 04:57:32 -0700 (PDT)
Message-ID: <4F841FCC.5020302@mvista.com>
Date:   Tue, 10 Apr 2012 15:55:56 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: Re: [PATCH] Revert fixrange_init() limiting to the FIXMAP region.
References: <1333988075-1289-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1333988075-1289-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQk5oIRZtZ5e7NOK1TaFA6Dbqx33mvP8EumEjencEMB1tvS4rtZ2dWVu0OsG97lT1kFkdYHi
X-archive-position: 32923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 09-04-2012 20:14, Steven J. Hill wrote:

> From: "Steven J. Hill"<sjhill@mips.com>

> This patch reverts 464fd83e841a16f4ea1325b33eb08170ef5cd1f4 which
> may not take calculate the right length while taking into account

    So, take or calculate?

> page table alignment by PMD.

> Signed-off-by: Leonid Yegoshin<yegoshin@mips.com>
> Signed-off-by: Steven J. Hill<sjhill@mips.com>

WBR, Sergei
