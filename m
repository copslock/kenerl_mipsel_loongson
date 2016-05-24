Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2016 00:39:42 +0200 (CEST)
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34470 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032211AbcEXWjjVwMr1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2016 00:39:39 +0200
Received: by mail-pf0-f182.google.com with SMTP id y69so11194820pfb.1;
        Tue, 24 May 2016 15:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=LLcnsKQRVA4H5dlOBuRggg5+770wMBMpvbhIx/aWJUM=;
        b=keCJZ4M8Hy9zJWZ+Rr34UeDVAxYoptg/2al1h5r2fF8+sI/l8HvRO8CGOexQUeDWcZ
         fOk/BvycnuugIjoeDPfihsPf3cGrjo3p6XMuY7Wj9l+dvG3Fwv+ju8NoWckyLJzKaDA8
         7PcbqoXOksBRJs4iHcO5/zqkrA/weJgagPSM4vCTfDawsZ51564+yBLSay3DYr+iu754
         Ay3tggidCYsUP3YzLDdHLHizoFwWR2HSpmQKWgETmmrDE5Xaw1+mU8PpoFpyMMHefEyT
         4Zue8vptPo5H++L93tZCdLr80pGWTvWhMewR2wEYRqeXV8H1J46tTc0AflpfLGSCwPuq
         Gl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=LLcnsKQRVA4H5dlOBuRggg5+770wMBMpvbhIx/aWJUM=;
        b=dB6cuG3HjvXpsGwszhjCer1hmIabqHWhNmAUhkPHiLg+r5MPKn8iiECFdviq2BWNFX
         LSjoOrMkiurac8SZYPktdvQD1CVWoKuyRcxOM1FA3PY1QkIPyjyDJ0qTVorfBB9xCOrH
         qWqurBDaoTU+v6yluQNbnXkoliIMwrmFLCmNzaBxvlIA2ZfvXd0lclS8SX7jWQ+r0F1s
         q6n8b2UK4vFRXVfY0K5aoKzfp6neSF3idVylM7B548Xgc4SsVTDEq+iY9T+aBXZ/x60r
         XA33rbcUpHZkubk0Fpi9PxHesAfp6W4M1GHQ0WIH18sgwtPDdE784O8PiwuRlp7bLCyA
         Er2Q==
X-Gm-Message-State: ALyK8tKo7iEboKpLae+DZ8BBkzx8Np5avUuAUCwBlts9TVxr2xz3+QoNkYjVseNPKtf5PA==
X-Received: by 10.98.90.130 with SMTP id o124mr830002pfb.115.1464129573180;
        Tue, 24 May 2016 15:39:33 -0700 (PDT)
Received: from dl.caveonetworks.com ([50.233.148.158])
        by smtp.googlemail.com with ESMTPSA id 205sm8375958pfy.32.2016.05.24.15.39.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 15:39:31 -0700 (PDT)
Message-ID: <5744D823.2060001@gmail.com>
Date:   Tue, 24 May 2016 15:39:31 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     Joshua Kinard <kumba@gentoo.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: THP broken on OCTEON?
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net> <20160523152007.GB28729@linux-mips.org> <5743529A.4070506@gentoo.org> <20160523192219.GB24125@linux-mips.org> <57435CB4.5080609@gentoo.org> <20160524212139.GC1253@raspberrypi.musicnaut.iki.fi>
In-Reply-To: <20160524212139.GC1253@raspberrypi.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53649
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

On 05/24/2016 02:21 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, May 23, 2016 at 03:40:36PM -0400, Joshua Kinard wrote:
>> Might try some of those combinations and see if things improve on the Octeon?
>> IP27 was equally affected by this, minus the bits about RAM and Impact Gfx.
>> turning off THP, IP30 can run 64KB PAGE_SIZE without issue (compiles of
>> packages is actually sped up quite significantly under >4KB PAGE_SIZE).
>
> I think with 64KB page size, huge pages (512MB) are never allocated
> unless you have insane amounts of memory?

Yes, you need a lot of memory, but more importantly the replacement of 
pages with a THP cannot happen unless there are 512MB aligned chunks of 
VMAs, and that is rare.

> I tried today some builds
> with 64KB pages on 4GB system and it was stable, but also AnonHugePages
> stayed constantly at zero. But with 4KB pages it is frequently changing,
> and crashes in minutes.
>
> A.
>
>
>
