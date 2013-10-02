Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Oct 2013 16:11:39 +0200 (CEST)
Received: from mail-ve0-f174.google.com ([209.85.128.174]:49633 "EHLO
        mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868560Ab3JBOLcnAQd8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Oct 2013 16:11:32 +0200
Received: by mail-ve0-f174.google.com with SMTP id jy13so536546veb.5
        for <linux-mips@linux-mips.org>; Wed, 02 Oct 2013 07:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=N3+pDpQE0D/pTIIROh4J3zO7pF20yCQ3xE7JWTt65OA=;
        b=TmkXlQLhIkWBTuiq44yLQivLJwBL3B4vU9c1Bkmt0fjfbMdZNTwMCNNnYxe3gNBOmq
         ZFtfEDgZX6d2c9JN0Z6cOvn6yyQNPEcx4e0ieJ4IDxTTDqWpZb/LnZz127caNC2e2+Eo
         hlAx3A6bgyq+VamK0zkJbwgjWEJk7Mt2hijVkkBOpNj69N5Yfby3LuvhYqKxVEAIW+27
         +ieZ935Jdoj0SWQPnXU6turoiiafaMilrx4Q1ZJGuQaBACbcDPZhPK6S4Uj+3K1Q+Gl9
         3bGVtX1sA2vwSzsYyQUuClM4pzYipTFp/67Wz+TecE2N/DW6GIg/ZJmYxy7kvXz5BNSn
         ExAQ==
X-Gm-Message-State: ALoCoQmEG9PyrTj9ewzLYxPz9AzFbcXx9qlj2GHRZuWBNPlUuvpJlwLPcF4E+jfXyjp4BmWGPET7
MIME-Version: 1.0
X-Received: by 10.58.190.34 with SMTP id gn2mr255645vec.34.1380723086337; Wed,
 02 Oct 2013 07:11:26 -0700 (PDT)
Received: by 10.52.112.39 with HTTP; Wed, 2 Oct 2013 07:11:26 -0700 (PDT)
In-Reply-To: <20131002092457.GB23236@linux-mips.org>
References: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
        <1380552120-31003-2-git-send-email-ulf.hansson@linaro.org>
        <20131002092457.GB23236@linux-mips.org>
Date:   Wed, 2 Oct 2013 16:11:26 +0200
Message-ID: <CAPDyKFo+RxX72Q3V9opOnXB=yUG4ZZ=KSTS_0jPL9D6V+5HbBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: db1235: Don't use MMC_CLKGATE
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Ralf Baechle <ralf@linux-mips.org>, Chris Ball <cjb@laptop.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

On 2 October 2013 11:24, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Sep 30, 2013 at 04:41:59PM +0200, Ulf Hansson wrote:
>
>> As a first step in removing code for MMC_CLKGATE, MIPS db1235 defconfig
>> which is the only current user, shall move away from this option.
>>
>> The mmc host drivers au1xmmc and jz4740_mmc, which are used on MIPS
>> don't support clock gating through MMC_CLKGATE, thus removing the
>> config option will have no effect on power save - clock gating wise.
>>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>
> Feel free to feed this MIPS patch to Linus via the MMC tree.
>
>   Ralf

Thanks Ralf!

Chris, do you mind taking this through your tree?

Kind regards
Ulf Hansson
