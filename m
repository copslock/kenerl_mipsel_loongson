Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2012 12:17:32 +0100 (CET)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:39484 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903884Ab2BCLRZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Feb 2012 12:17:25 +0100
Received: by laam7 with SMTP id m7so2113889laa.36
        for <multiple recipients>; Fri, 03 Feb 2012 03:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZT5Z2iInb47N6i9bZiu8CsSG4PBQ94Ce8tALgv3rSe8=;
        b=LG1Yv6gi3T+BNQ+Gw68P1JG1QenKksIfUlDYSBvqzVKJ0fvS/EuegIwNUZ/lb8JXXB
         CY7aoWVPxsBuAyctra9AnzwOB3wruOsgzwUPXFhcVcWcb5OUsSU3L8oQCTSvKRRKi6dk
         Ual1FcuJPl1dO+8tDhEl09GhNIRFYcg6AVEes=
Received: by 10.112.9.40 with SMTP id w8mr1686893lba.103.1328267840267; Fri,
 03 Feb 2012 03:17:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.112.22.2 with HTTP; Fri, 3 Feb 2012 03:17:00 -0800 (PST)
In-Reply-To: <4F2BB61F.8010708@mvista.com>
References: <1328215931-24817-1-git-send-email-jonas.gorski@gmail.com> <4F2BB61F.8010708@mvista.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Fri, 3 Feb 2012 12:17:00 +0100
Message-ID: <CAOiHx=kG+qhzBSn3stNCG7kyRg64zwVs+xiewi0zz8-GErdhXQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM63XX: add missing include for bcm63xx_gpio.h
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 32400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

On 3 February 2012 11:25, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
>   You should then addd "Cc: stable@vger.kernel.org" line after your signoff.

Hrm, somehow I misremember this is supposed to be done only after the
patch got accepted. You are (mostly) right, only the address is now
stable@kernel.org :) I'll resend shortly.

a bit more confused than usually,
Jonas
