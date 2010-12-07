Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2010 06:15:12 +0100 (CET)
Received: from imr4.ericy.com ([198.24.6.8]:43513 "EHLO imr4.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491029Ab0LGFPH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Dec 2010 06:15:07 +0100
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
        by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id oB75i73F025589;
        Mon, 6 Dec 2010 23:44:08 -0600
Received: from localhost (147.117.20.213) by eusaamw0712.eamcs.ericsson.se
 (147.117.20.182) with Microsoft SMTP Server id 8.2.234.1; Tue, 7 Dec 2010
 00:14:39 -0500
Date:   Mon, 6 Dec 2010 21:14:38 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Matt Turner <mattst88@gmail.com>,
        Jean Delvare <khali@linux-fr.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
Message-ID: <20101207051438.GA20144@ericsson.com>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com>
 <20101206173040.GA18372@ericsson.com>
 <alpine.LFD.2.00.1012061739200.17185@eddie.linux-mips.org>
 <AANLkTikWRsgHao_eb4W47b=E4vm6z=hi36JE_VBtD6Rg@mail.gmail.com>
 <alpine.LFD.2.00.1012070148050.17185@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1012070148050.17185@eddie.linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <groeck@ericsson.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips

On Mon, Dec 06, 2010 at 09:26:54PM -0500, Maciej W. Rozycki wrote:
[ ... ]
> 
>  Note that for IRQ support you may have to investigate dependencies in the 
> other two series as the patch (third above) was intended to apply on top 
> of the two series (select the date sort for easier identification of the 
> series).  I'd have to dig into that code for further details and I cannot 
> afford the time right now, sorry.
> 
A quick look through sb1250 vs. sb1480 code shows that the 1480 uses different
interrupt numbers. The patch assigns the sb1250 interrupt numbers, so unless
I am missing something the code as written can not work for sb1480.

Thanks,
Guenter
