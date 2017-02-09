Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2017 15:10:48 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:60448 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990601AbdBIOKlxun1z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2017 15:10:41 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 45012609C9; Thu,  9 Feb 2017 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1486649440;
        bh=wbeqp0G/Fl5pyz/lzeePTfWNTiKKpouR2OBkl3BIQ6I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=RHYoX9FNhuFb10rEWSR96pPZPQLe31bwv0OiMPxDs9iPIjc2XfFNshSYB301QgPgo
         LgBsiduUG2OVDUUCdWasCUzzJkc+OdpFt6trMElCvqeBQ/NReqp2Wuyxk24mi0f5PJ
         ugqrAPpsqtEySYAwXYSamE5ki1PFdfey2mYN4QU4=
Received: from potku.adurom.net (a88-115-187-87.elisa-laajakaista.fi [88.115.187.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B61AE60856;
        Thu,  9 Feb 2017 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1486649438;
        bh=wbeqp0G/Fl5pyz/lzeePTfWNTiKKpouR2OBkl3BIQ6I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Az3BHl515noo78HN8K2mojeF2EcW8tZy6CSAJnh0p2c2zaCLLijvJ7NGWmFXX7Zlc
         KN5lW4Gt7Uh+408riiNTQtQdLCkysVRpjF/lPl28y2uGHN0jQM7HQZkJulDkFRpSMx
         oDxVsatFlMQkNt3UF9FGBDVE+diz0AYi7vW7vjJo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B61AE60856
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-mips@linux-mips.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, target-devel@vger.kernel.org,
        andrew@lunn.ch, anna.schumaker@netapp.com,
        derek.chickles@caviumnetworks.com,
        felix.manlunas@caviumnetworks.com, bfields@fieldses.org,
        jlayton@poochiereds.net, jirislaby@gmail.com,
        mcgrof@do-not-panic.com, madalin.bucur@nxp.com,
        UNGLinuxDriver@microchip.com, nab@linux-iscsi.org,
        mickflemm@gmail.com, nicolas.ferre@atmel.com,
        raghu.vatsavayi@caviumnetworks.com, ralf@linux-mips.org,
        satananda.burla@caviumnetworks.com,
        thomas.petazzoni@free-electrons.com, timur@codeaurora.org,
        trond.myklebust@primarydata.com,
        vivien.didelot@savoirfairelinux.com, woojung.huh@microchip.com
Subject: Re: [PATCH net-next v2 00/12] net: dsa: remove unnecessary phy.h include
References: <20170207230305.18222-1-f.fainelli@gmail.com>
        <20170208.110626.346978547122180233.davem@davemloft.net>
        <87h944ll0w.fsf@kamboji.qca.qualcomm.com>
        <5fe312c8-e59e-669c-cd29-f6773adcd8e5@gmail.com>
Date:   Thu, 09 Feb 2017 16:10:06 +0200
In-Reply-To: <5fe312c8-e59e-669c-cd29-f6773adcd8e5@gmail.com> (Florian
        Fainelli's message of "Wed, 8 Feb 2017 11:45:11 -0800")
Message-ID: <877f4zjw01.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@codeaurora.org
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

Florian Fainelli <f.fainelli@gmail.com> writes:

>>> If not, for something like this it's a must:
>>>
>>> drivers/net/wireless/ath/wil6210/cfg80211.c:24:30: error: expected ‘)’ before ‘bool’
>>>  module_param(disable_ap_sme, bool, 0444);
>>>                               ^
>>> drivers/net/wireless/ath/wil6210/cfg80211.c:25:34: error: expected ‘)’ before string constant
>>>  MODULE_PARM_DESC(disable_ap_sme, " let user space handle AP mode SME");
>>>                                   ^
>>> Like like that file needs linux/module.h included.
>> 
>> Johannes already fixed a similar (or same) problem in my tree:
>> 
>> wil6210: include moduleparam.h
>> 
>> https://git.kernel.org/cgit/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?id=949c2d0096753d518ef6e0bd8418c8086747196b
>> 
>> I'm planning to send you a pull request tomorrow which contains that
>> one.
>
> Thanks Kalle!
>
> David, can you hold on this series until Kalle's pull request gets
> submitted? Past this error, allmodconfig builds fine with this patch
> series (just tested). Thanks!

Just submitted the pull request:

https://patchwork.ozlabs.org/patch/726133/

-- 
Kalle Valo
