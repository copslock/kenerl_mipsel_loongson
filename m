Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Feb 2011 09:33:37 +0100 (CET)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:56590 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491014Ab1BNIde convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Feb 2011 09:33:34 +0100
Received: by wwi18 with SMTP id 18so1593144wwi.0
        for <linux-mips@linux-mips.org>; Mon, 14 Feb 2011 00:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zb/UmS/j6Ff98I2FVbSg3QySeW1rTE651z/10pRxYeQ=;
        b=KvshwIxSO8IVzqzXcshBWPSMas6CDeCZNeBIc8zcfH5p2utGtvVv5UmjymV58GpISj
         lEDzz9ZK//zv97p65S0UVa0bhMVbwzoLMqWIXzhf6H46vSE5KO3lxQhhY0Fi7zHzxRc5
         NRa9WiFYNC4/+jFuzy7Fd5DZfRUmXT6qk2Ig4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JV9tPj2SSyNhPLmlAt33x98i4LatBtXhbgPSbz0C/L1bjjStL36WpE9crSvLu7B+3K
         pBj0YST4JCfJttj1tLD4TRNlSV0FAviqiBxy7IRvzvF5ZfdvgIFMoEg0E57wwuKQEVnA
         +Lj1qHoCz453xoGlBDClIiun05pufDcZFYwzs=
MIME-Version: 1.0
Received: by 10.216.71.13 with SMTP id q13mr2962797wed.21.1297672408143; Mon,
 14 Feb 2011 00:33:28 -0800 (PST)
Received: by 10.216.193.195 with HTTP; Mon, 14 Feb 2011 00:33:28 -0800 (PST)
In-Reply-To: <4D58E745.9090003@dare.nl>
References: <4D58E745.9090003@dare.nl>
Date:   Mon, 14 Feb 2011 09:33:28 +0100
Message-ID: <AANLkTikYiA0otyhHgbwhLzMFS7xW+-CTswOOCoL=TZbg@mail.gmail.com>
Subject: Re: alchemy au1100 where is the MMC card
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Robert Bon <robo@dare.nl>
Cc:     linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Robert,

On Mon, Feb 14, 2011 at 9:26 AM, Robert Bon <robo@dare.nl> wrote:
> Kernel 2.6.37
> Where is the support for a MMC card for the Alchemy AU1100 processor?
> Is is only supported  for the AU1200?
>
> See file: "drivers/mmc/host/Kconfig
> config MMC_AU1X
>  tristate "Alchemy AU1XX0 MMC Card Interface support"
>  depends on SOC_AU1200

The driver code seems to support the Au1100, however I doubt
anyone has actually ever tested it on real hardware.
Tell us how it goes...

Manuel
