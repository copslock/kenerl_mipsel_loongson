Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 17:37:21 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:40536 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493653Ab1HXPhO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Aug 2011 17:37:14 +0200
Received: by gyh20 with SMTP id 20so1170116gyh.36
        for <multiple recipients>; Wed, 24 Aug 2011 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KKg38CRY+RF6xDgYny6PoHYErqi1l7sIMSSFpMF/GBg=;
        b=Asox2cexf3JW93zeE7IcDQxH1yzpYcBmANcVKi+A/Ibl9Kn6ZAGMfDD6GY0xGAg1MM
         ofYgvKSqX0rZQNEd8bTdl5kS8ETXC2ISWJE9WO4HAc5nredzap6Bm6GYUcPgRd4xPdMj
         gyzD9r7UloZk0DUFlM7GdKPwoHh08UiTX9GpE=
Received: by 10.52.88.133 with SMTP id bg5mr5443721vdb.88.1314200228074; Wed,
 24 Aug 2011 08:37:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.156.131 with HTTP; Wed, 24 Aug 2011 08:36:48 -0700 (PDT)
In-Reply-To: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Wed, 24 Aug 2011 11:36:48 -0400
Message-ID: <CAEdQ38E6qqVAKC1MkAWto5yeU9N2uoyGY1Y5431kNUNL_yc8EA@mail.gmail.com>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of interrupts
To:     Jean Delvare <khali@linux-fr.org>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <guenter.roeck@ericsson.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Aug 18, 2011 at 7:43 PM, Matt Turner <mattst88@gmail.com> wrote:
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

Jean,
Do you want to take this patch, or should Ralf through his tree?

Thanks,
Matt
