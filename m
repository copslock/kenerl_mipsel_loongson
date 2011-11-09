Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 13:43:32 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:35951 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903561Ab1KIMn0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2011 13:43:26 +0100
Received: by faaq17 with SMTP id q17so2073522faa.36
        for <multiple recipients>; Wed, 09 Nov 2011 04:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SRMvdZ884C3XmpYZonYMO4RS4Qy10EP1+lUu/l+0RdQ=;
        b=jBoNwXplfDRDc8jZTwb+mRF+WU4kvjk4jmYLml2DSAbEkI4QYBCaAjEuPq1S8F12T9
         JATgSDXsYSi+DiCzDS1Qp0Us5wIJx1qBCKNa4VEPNk2UvbMdOgCQs1EMG0KVj4WEPqQn
         GY5Lq7hlY5Ns6Gqu4yVXz77qTgSOlN6mYPZTc=
Received: by 10.223.6.15 with SMTP id 15mr4774951fax.4.1320842601107; Wed, 09
 Nov 2011 04:43:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.118.15 with HTTP; Wed, 9 Nov 2011 04:43:00 -0800 (PST)
In-Reply-To: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
References: <1320430175-13725-1-git-send-email-mbizon@freebox.fr>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 9 Nov 2011 13:43:00 +0100
Message-ID: <CAOiHx==+XMd05e6-JP_+9uXk_-8972uzAPJBW1T6Qqi7ov9=tg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] MIPS: BCM63XX: add support for Broadcom 6368 CPU.
To:     Maxime Bizon <mbizon@freebox.fr>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 31453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7699

Hi Maxime,

On 4 November 2011 19:09, Maxime Bizon <mbizon@freebox.fr> wrote:
>
> New in v2:
>
> Addressed all Jonas comments but the SPI register set. Since Florian
> and you have upcoming SPI drivers to submit, I'll let you decide which
> block deserves its own register set.
>
> External IRQ support has been changed slightly to handle more than 4
> irq, it now uses a fixed number range above 100. It has been tested on
> 6348/58/68.

Apart from patch 10/11 (and the nitpick regarding the {read,write}ll
-> q) these look all fine to me. Thanks for your work!


Regards,
Jonas
