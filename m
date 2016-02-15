Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 05:31:18 +0100 (CET)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34490 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006520AbcBOEbQmVDsJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 05:31:16 +0100
Received: by mail-pf0-f195.google.com with SMTP id 71so6994454pfv.1;
        Sun, 14 Feb 2016 20:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nBoeh6KSAHRFbqE4TsKYIPO4FENCrJcWZiGWVNJSJ0Q=;
        b=cKH1vR81LaPJPYIez648IvJKfJjKNhvWFaUlUSaHkLktdQcQVTKbg3hpBBZHWEbb3E
         4rvyux7MC24Zd/+vS8y1y/Yuzh9HTe/VRrGfhFfhz6UmobvOkkNU3CYAnUBB32Vwyj6d
         hqAd98H0peTG3oxiwzu4Z5SDgevwH/WmFukRVyRCpFEwOnJpcwFc/feZRFmZsJNUxren
         hPQX6eFcumA4mkIGaTjezyPvDLl9yDjkaArAJ6oM0/wN45tGJWknvwX+t3YoGUXODTbt
         wdmRoImpWQ4FbzPJNgaEjp6q+zgdrKg8seqcEwN7IV5Hh/djEhN7zg4Km/D6th8cqTXO
         QWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=nBoeh6KSAHRFbqE4TsKYIPO4FENCrJcWZiGWVNJSJ0Q=;
        b=DnnM8DErvIEYT/Fba1rxoKiSFYbsF1p+Jc2RuDCxgkr44/KSFeGUOt6K0Sox2m86iE
         qnwQ4zjbbZvRrB3r+9det94hPVXhqMeSfE2dT31ZGlzcex/IuIYO2WCsxOVGp3d6oTKC
         /6G1Sw0DFxTueRyKmRPH6KujAyBo1cQuaCWytJ5xQXHX2Nx7EKP4XzZ4Pde3M8y/QRM1
         Hda/Wdjde0Sbchl9cQLPKLPLBEACEl7NIIvpW6hexuWUB+MSqHvoZCtRr30nu1v67KyN
         u9HSUanQaTZppmqnSx7zNMKtm70r22AKVajky2vhVy0QX4ZP1ou646yaSEOIhAczJoaE
         XX1w==
X-Gm-Message-State: AG10YORXWKrXtGeI6yWSSG9YRvIslulaTCTTy/L7stlgio/zMWvqDGBC13bpjCeAbLC9FA==
X-Received: by 10.98.15.19 with SMTP id x19mr20800391pfi.60.1455510670604;
        Sun, 14 Feb 2016 20:31:10 -0800 (PST)
Received: from [172.16.1.101] ([211.255.134.166])
        by smtp.gmail.com with ESMTPSA id t12sm34623992pfa.54.2016.02.14.20.31.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Feb 2016 20:31:10 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3120\))
Subject: Re: [PATCH 0/7] cleanup and add device tree for BCM7xxx platforms
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <56788942.3030601@gmail.com>
Date:   Mon, 15 Feb 2016 13:31:05 +0900
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <F1F89384-2E24-4D97-A8A5-19CB45CAA70F@gmail.com>
References: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com> <56788942.3030601@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
X-Mailer: Apple Mail (2.3120)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Hi Ralf,

> On Dec 22, 2015, at 8:20 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> On 18/11/15 18:34, Jaedon Shin wrote:
>> Hi all,
>> 
>> This patch series is including device tree entries that clean up existing
>> entries and adds missing entries for BCM7xxx platforms.
>> 
>> Jaedon Shin (7):
>>  MIPS: BMIPS: remove unused aliases in device tree
>>  MIPS: BMIPS: remove wrong sata properties
>>  MIPS: BMIPS: fix phy name in device tree
>>  MIPS: BMIPS: fix interrupt number in bcm7425.dtsi
>>  MIPS: BMIPS: add device tree entry for BCM7xxx UART
>>  MIPS: BMIPS: add device tree entry for BCM7xxx I2C
>>  MIPS: BMIPS: add device tree entry for BCM7xxx SATA
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Thanks!
> 
> Ralf, since 19e88101c78f MIPS: BMIPS: Add SATA/PHY nodes for bcm7346 and
> other changes got into 4.4-rc1, could you queue at least
> 
> MIPS: BMIPS: remove wrong sata properties
> and
> MIPS: BMIPS: fix interrupt number in bcm7425.dtsi
> 
> for an upcoming 4.4 pull request so we have correct device trees from
> there on?
> 
> Thank you!
> -- 
> Florian

Would you consider applying a patchset or the two fixes?

Thanks,
Jaedon
