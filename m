Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Sep 2014 19:42:39 +0200 (CEST)
Received: from mail-vc0-f173.google.com ([209.85.220.173]:49313 "EHLO
        mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009158AbaIQRmhpvMuP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Sep 2014 19:42:37 +0200
Received: by mail-vc0-f173.google.com with SMTP id le20so1637149vcb.18
        for <linux-mips@linux-mips.org>; Wed, 17 Sep 2014 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wDXHgprvJFc/6S+T4c0GoFrZXmm7+YEwp3JI2IIEs7U=;
        b=gdQhZMCxp/KZCO+pA7CFEZWiXlzQgNI4Xj5+vFbRlmSSIcjCUD6zr3962yBLSRbgZ4
         K4jC2BUZ7vVhsGctXs+kPjL0vGsDwBsdah/iKFm06HmEsr1cwhRvzI8wFoj79sFbscYh
         CV3BWhVIiF88xGFTuV0FrTMS4+WSQIWuguB4cgRPnRzurfMsLk3TzVZFM1HkVBUl2lqV
         TPyRLEC2u5GRK+oTeNvewTh3573tn8+tSyVPacjfSxYB89XTfDvZQAcKIbgC18x9SGd5
         JlOBlBlfiykNgVuXU6u3f/8ThSfe68RFGon7Gi6x8U+81KQYsYGiLm0iF+EUNCxUOYlx
         0Efw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wDXHgprvJFc/6S+T4c0GoFrZXmm7+YEwp3JI2IIEs7U=;
        b=Kvb4n5xFtImKsj8+Aeo/UXFS8lDy9Pv1zNfAL4tdEEQfIqIZ++pHYYQFFaMpRP6Pkw
         vTUgti6JNS7HTl7m7245ZhAQdCAiljSccjs2MGSuick/1J/xSvnX4UcHrY9S0ghigvzw
         XGJDpg4Ba9THAh4/3SmIwac01jaTgzkyEn428=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wDXHgprvJFc/6S+T4c0GoFrZXmm7+YEwp3JI2IIEs7U=;
        b=KXBPIrGHuv1CDCWVBCLB61PwrNdHLbTlaGisT8jKqkWvCiszkHZi3bm8F3ajxsKKPh
         xkyom68V0yFfcV7IFGkSZnnO3W7NEURqWjucrR+Q+oEWFM3bcnTdcnU6cGXUgVMUsbcx
         jcvVLBsm4getvJuLiw4Hdk/fqb7VYxpJDGo8pL/cRe8U3HgF1Fvk3YcNLX2esa1DVcYH
         gJDDDphFRA8UMie1yVt4+2E6tveqZfNESkw92Ya18V3tpKTA15BLy4Z969a4Ke+vDDRo
         XYvv/oXQ2Mmbo2wVU9LPjcrBnEPzOFE7rsim7XlL40xSniSbhXyTV2xHvYaGE6kILcz8
         we9w==
X-Gm-Message-State: ALoCoQlf7BHZ3DLQbB7Faosp/9UUXrVLvUVDSfDwt53IKKb41hjObPiaO3boN380ghF6eIag8gfr
MIME-Version: 1.0
X-Received: by 10.52.165.97 with SMTP id yx1mr5195811vdb.15.1410975751883;
 Wed, 17 Sep 2014 10:42:31 -0700 (PDT)
Received: by 10.52.168.200 with HTTP; Wed, 17 Sep 2014 10:42:31 -0700 (PDT)
In-Reply-To: <54196086.9030204@imgtec.com>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
        <54196086.9030204@imgtec.com>
Date:   Wed, 17 Sep 2014 10:42:31 -0700
X-Google-Sender-Auth: maPIHK6BwZxFuDJR9ZDk9fBiD80
Message-ID: <CAL1qeaGF2rZ3qRBwWa24-Jun1GB=-i2ibartqAS+z_U9G33Wdw@mail.gmail.com>
Subject: Re: [PATCH 00/24] MIPS GIC cleanup, part 1
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Wed, Sep 17, 2014 at 3:20 AM, Qais Yousef <qais.yousef@imgtec.com> wrote:
> On 09/16/2014 12:51 AM, Andrew Bresticker wrote:
>>
>> The current MIPS GIC driver and the platform code using it are rather
>> ugly and could use a good cleanup before adding device-tree support [0].
>> This major issues addressed in this series are converting the GIC (and
>> platforms using it) to use IRQ domains and properly mapping interrupts
>> through the GIC instead of using it transparently.  For part 2 I plan
>> on: updating the driver to use proper iomem accessors, cleaning up and
>> moving the GIC clocksource driver to drivers/clocksource/, adding DT
>> support, and possibly converting the GIC driver to use generic irqchip.
>>
>> Patches 1-16 are cleanups for the existing GIC driver and prepare
>> platforms
>> using it for the switch to IRQ domains and using the GIC in a
>> non-transparent
>> way.
>>
>> Patches 17-24 convert the GIC driver to use IRQ domains and updates the
>> platforms using it to properly map GIC interrupts instead of using the
>> static
>> routing tables to make the GIC appear transparent.
>>
>> I've tested this series on Malta and, with additional patches, on the
>> DT-enabled Danube platform.  Unfortunately I do not have SEAD-3 hardware,
>> so that has only been compile tested.  Compile tested on all other
>> affected
>> architectures (ath79, ralink, lantiq).
>
>
> I boot tested this on sead3 without problems.

Thanks Qais!  Can I add your Tested-by for the series?
