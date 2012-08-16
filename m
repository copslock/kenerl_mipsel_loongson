Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2012 11:41:07 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:64650 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903435Ab2HPJlD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Aug 2012 11:41:03 +0200
Received: by ggnm2 with SMTP id m2so2875757ggn.36
        for <linux-mips@linux-mips.org>; Thu, 16 Aug 2012 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3CiwWcZRnf/p4trTEXZggrmxVTqRWzpHUp7aSCdurOU=;
        b=KHOoz6H/hyWuwL/60AjQVR+t6uWH/wY1DTSa6SZckxCUNrbh+Tuokurqk+5f2KgZEE
         kHaEYEUqBwS3KBX7NE39uUz7XmW0r1ZW8auvLXbBZ2SDLnj+EGZdCUIBk4xs0g6gr3Br
         1dThBjh+SOGLkdDqY0FmRQ6YYrSlgbKIJv6FKWM6PidECeSGw/2DiOSWdho9pcIwQf5l
         wQrFg47MzGcvQlSmWAgQyldr2uYafwImygygDBqUzUXMD3yKoXlkRrVDNKMjcoeM38wg
         Vm1/RqemW4jiYJFTKxOL9dZW/20Cism7qFVLXBA6SxySEUT26SCYIyRH8KRYP1RW9S7c
         jSjg==
MIME-Version: 1.0
Received: by 10.50.186.165 with SMTP id fl5mr545641igc.47.1345110056286; Thu,
 16 Aug 2012 02:40:56 -0700 (PDT)
Received: by 10.43.44.7 with HTTP; Thu, 16 Aug 2012 02:40:56 -0700 (PDT)
In-Reply-To: <502CB736.6010107@openwrt.org>
References: <1345102448-4612-1-git-send-email-blogic@openwrt.org>
        <CAM=Q2cvCmKMkQjWd0nvuvMMkNt3sH-AcupCq_KzM7EXDuD_-wQ@mail.gmail.com>
        <502CB736.6010107@openwrt.org>
Date:   Thu, 16 Aug 2012 15:10:56 +0530
Message-ID: <CAM=Q2csrm-zfnGUvR03EXj-Ybi-py8VqAy39g8kBjSHcyZZ8mQ@mail.gmail.com>
Subject: Re: [PATCH] I2C: MIPS: lantiq: add FALC-ON i2c bus master
From:   Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To:     John Crispin <blogic@openwrt.org>
Cc:     Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: omaplinuxkernel@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi John,

On Thu, Aug 16, 2012 at 2:32 PM, John Crispin <blogic@openwrt.org> wrote:
> Hi Shubhrajyoti,
>
> Thanks for the comments, I just noticed that clk_put() is also missing
> and that the clock gate should be deactivated upon a rmmod ... i will
> fix all of these and resend the patch.

There are two things

1> Relinquishing the handle. I think clk_put does that not sure.

2> Gating , ie deactivating the clock the best place for this to
happen is when there is no
transfer. However that aggression in  PM can happen later.
>
> John
