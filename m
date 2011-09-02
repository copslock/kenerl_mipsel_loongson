Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2011 15:21:30 +0200 (CEST)
Received: from zone0.gcu-squad.org ([212.85.147.21]:28324 "EHLO
        services.gcu-squad.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491047Ab1IBNVX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2011 15:21:23 +0200
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=endymion.delvare)
        by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1QzUqu-0002cd-8l
        (TLSv1:AES128-SHA:128)
        (envelope-from <khali@linux-fr.org>)
        ; Fri, 02 Sep 2011 16:36:16 +0200
Date:   Fri, 2 Sep 2011 15:21:04 +0200
From:   Jean Delvare <khali@linux-fr.org>
To:     Matt Turner <mattst88@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <guenter.roeck@ericsson.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Message-ID: <20110902152104.1cc3e2c6@endymion.delvare>
In-Reply-To: <CAEdQ38E6qqVAKC1MkAWto5yeU9N2uoyGY1Y5431kNUNL_yc8EA@mail.gmail.com>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>
        <CAEdQ38E6qqVAKC1MkAWto5yeU9N2uoyGY1Y5431kNUNL_yc8EA@mail.gmail.com>
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.20.1; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 31031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khali@linux-fr.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 24 Aug 2011 11:36:48 -0400, Matt Turner wrote:
> On Thu, Aug 18, 2011 at 7:43 PM, Matt Turner <mattst88@gmail.com> wrote:
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> 
> Do you want to take this patch, or should Ralf through his tree?

My tree is fine, unless Ralf has a specific reason to pick it. Just
give me a couple hours to review the patch.

-- 
Jean Delvare
