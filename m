Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 19:38:57 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:39546 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903691Ab2EKRiv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2012 19:38:51 +0200
Received: by laap9 with SMTP id p9so2581559laa.36
        for <linux-mips@linux-mips.org>; Fri, 11 May 2012 10:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=tNOjRX1LqVBdf2aKtG1Bs5Q0xIkdw2EC4ru3XERazh8=;
        b=BZY+5p/HxsAxWuJ9hCD7ricgJgPJd3bDnhskRFi5jmBgnApgdrA0ijg6xPfVyZkD2S
         HJG6VFI6ToKQHfY9lW3SYRyxsYOMbsxv606wV+ZKacPTlVVmtjlUSe9hFDtiuhVWPtPn
         BvUAiLnj/2Kvp9qsvQO2TQORuS5up1r5/aiLWVDsA4tJnVbPNgdJaQSiofgOlLGZ5ILp
         VebKrAwunoPIDtWmrCKbW2bUuvNg51zG9v2PccDQtsEa98XDKiIz9eJ3uOViU1F2xJPM
         vHAUwPZMeuRoPXLyihBx66CUBoO+5A8JBI22EX9OX2cGPv29CXt6ZLOYLc36ogMqwv6g
         sVOw==
Received: by 10.112.103.135 with SMTP id fw7mr4095053lbb.25.1336757925856;
        Fri, 11 May 2012 10:38:45 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id j5sm12544392lbg.1.2012.05.11.10.38.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 10:38:44 -0700 (PDT)
Message-ID: <4FAD4E5C.9040607@mvista.com>
Date:   Fri, 11 May 2012 21:37:32 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     "Yegoshin, Leonid" <yegoshin@mips.com>
CC:     "Hill, Steven" <sjhill@mips.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: [PATCH v2] Add MIPS64R2 core support.
References: <1336717784-853-1-git-send-email-sjhill@mips.com>,<4FAD4B9E.70803@mvista.com> <ajcsenx2bmwqyi5629d3ywgh.1336757525517@email.android.com>
In-Reply-To: <ajcsenx2bmwqyi5629d3ywgh.1336757525517@email.android.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQm9IBRbPawZ57KT7GNRrG3aZLOu5jEHoA+uJymLYWwsQMRV+RPItlR4lvav1UTPo0TUnPIN
X-archive-position: 33265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 05/11/2012 09:32 PM, Yegoshin, Leonid wrote:

> Not exactly - it adds 64R2 support in Malta, plus small verification that build kernel could run 32bit binaries.

> I don't think it has sense to multiply patches here, there is no sense to have this separated.

> 5KEc is just test-bed.

    Well, rule of thumb is do one thing per patch. You do three. All that 
without proper description.

WBR, Sergei
