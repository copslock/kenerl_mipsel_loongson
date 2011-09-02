Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2011 15:35:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50424 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491053Ab1IBNfo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2011 15:35:44 +0200
Date:   Fri, 2 Sep 2011 14:35:44 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Jean Delvare <khali@linux-fr.org>
cc:     Matt Turner <mattst88@gmail.com>, linux-i2c@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
In-Reply-To: <20110902152104.1cc3e2c6@endymion.delvare>
Message-ID: <alpine.LFD.2.00.1109021432060.4855@eddie.linux-mips.org>
References: <1313710991-3596-1-git-send-email-mattst88@gmail.com>        <CAEdQ38E6qqVAKC1MkAWto5yeU9N2uoyGY1Y5431kNUNL_yc8EA@mail.gmail.com> <20110902152104.1cc3e2c6@endymion.delvare>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, 2 Sep 2011, Jean Delvare wrote:

> > > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > > Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> > 
> > Do you want to take this patch, or should Ralf through his tree?
> 
> My tree is fine, unless Ralf has a specific reason to pick it. Just
> give me a couple hours to review the patch.

 As a side note I do really need to get back to this series and see if 
there's anything else that needs reviving.  Hopefully within the next 
couple of weeks.

 Thanks, Matt, for taking care of this patch.  I reckon I've got some 
other old SWARM stuff that needs digging up too.

  Maciej
