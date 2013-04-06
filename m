Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Apr 2013 17:20:56 +0200 (CEST)
Received: from mail-da0-f43.google.com ([209.85.210.43]:50465 "EHLO
        mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834879Ab3DFPUyrKJln (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Apr 2013 17:20:54 +0200
Received: by mail-da0-f43.google.com with SMTP id u36so1991728dak.16
        for <linux-mips@linux-mips.org>; Sat, 06 Apr 2013 08:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1tJUkqSQ4kalbJBPepNwILXgEkhAGQJvYdXLoEjLQgk=;
        b=IY7W0PpKt5flwaYFUMA1qof1G/8sB7BO2p7IEGhVqq37WlNTgIDJ3AZVjbS4BxAn3t
         pUGzQyWTOFKxoEGsvw3BwlDAxouJZTutpoPlMBaW5Kk3uEjeZCXWJroJ0U3sdGNd0ee3
         gJ9DUN8NSrSn3uVUx02MMijHOYIQX/zmJt1ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=1tJUkqSQ4kalbJBPepNwILXgEkhAGQJvYdXLoEjLQgk=;
        b=YzGb/D+I5IHdcCGXjGAzX+fJG2pC3qj576eezehxBB3R4qaS8YAaup8SLghx20EJ0L
         buQP8Uquo+xbFzjazOV+gFsGJp+euFn9ZTUBPalURzBdHANlAuUW8YGdaxgDA9Os4ja7
         J/ruMFDT9Ospm9aBRItr0mzu4ghSBXu5GyQH6MStV9g4ZY0i4f0X2wth1MsWRF7LPq9F
         l7FIlu4FMt5yeQR0FfZqhxrIIlrzzkyvP0hH+doF0fcScdcOKjta6TqFcehxvckE/huO
         SG7qaITs05BfzO69/blg6Xjbse8Kw7lIosoVGg/QEcjSVmyt7/8mhse1dnzM4vps5nbs
         mzEw==
X-Received: by 10.68.103.5 with SMTP id fs5mr20683315pbb.32.1365261647730;
        Sat, 06 Apr 2013 08:20:47 -0700 (PDT)
Received: from localhost (c-76-28-172-123.hsd1.wa.comcast.net. [76.28.172.123])
        by mx.google.com with ESMTPS id yp2sm20708741pab.10.2013.04.06.08.20.45
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Apr 2013 08:20:46 -0700 (PDT)
Date:   Sat, 6 Apr 2013 08:20:44 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH] MIPS: BCM63XX: merge bcm63xx_clk.h into bcm63xx/clk.c
Message-ID: <20130406152044.GA12202@kroah.com>
References: <1365247862-19358-1-git-send-email-jogo@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1365247862-19358-1-git-send-email-jogo@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQltn8pn5doYETjBElYDDTNtlVb2MoQ/4u2pQR+3gklVaiLP7DkHylYaqdpudcOMy0LfBvFO
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Sat, Apr 06, 2013 at 01:31:02PM +0200, Jonas Gorski wrote:
> All the header file does is provide the internal structure of clk,
> which shouldn't be used by anyone except clk.c itself anyway.
> 
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
>  arch/mips/bcm63xx/clk.c                          |    8 +++++++-
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h |   11 -----------
>  drivers/tty/serial/bcm63xx_uart.c                |    1 -
>  3 files changed, 7 insertions(+), 13 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_clk.h

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
