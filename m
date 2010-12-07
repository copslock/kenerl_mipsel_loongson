Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2010 03:26:58 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55937 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492182Ab0LGC0y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Dec 2010 03:26:54 +0100
Date:   Tue, 7 Dec 2010 02:26:54 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Matt Turner <mattst88@gmail.com>
cc:     Guenter Roeck <guenter.roeck@ericsson.com>,
        Jean Delvare <khali@linux-fr.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] I2C: SiByte: Convert the driver to make use of
 interrupts
In-Reply-To: <AANLkTikWRsgHao_eb4W47b=E4vm6z=hi36JE_VBtD6Rg@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1012070148050.17185@eddie.linux-mips.org>
References: <1291617494-18430-1-git-send-email-mattst88@gmail.com> <20101206173040.GA18372@ericsson.com> <alpine.LFD.2.00.1012061739200.17185@eddie.linux-mips.org> <AANLkTikWRsgHao_eb4W47b=E4vm6z=hi36JE_VBtD6Rg@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 6 Dec 2010, Matt Turner wrote:

> >  Matt, thanks for keeping your eye on these bits and reviving them; I've
> > meant to do so for a long time now, but never came to it.  Please note
> > however, as I'm the original author, my original Signed-off-by markups
> > continue to apply and you should be quoting them with the submissions.
> > You should only add your own Signed-off-by annotation if you made any
> > changes and it would make sense to state what these changes were.
> 
> Sure thing. Will fix. For patches 2 and 3 of the other series, I don't
> think I was ever 100% sure that you were the author, since they were
> living on OpenWRT.org and I couldn't find them in any mailing list
> archives. Can you confirm that these 4 patches are all yours?

 All the relevant submissions should be present here:

http://www.linux-mips.org/archives/linux-mips/2008-05/threads.html

Specifically:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=Pine.LNX.4.55.0805180447210.10067%40cliff.in.clinika.pl

(5th of a series of 6), and:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=Pine.LNX.4.55.0805070054440.16173%40cliff.in.clinika.pl

(3rd of a series of 4), and:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=Pine.LNX.4.55.0805130353250.535%40cliff.in.clinika.pl

(individual submission).

The "clean up SWARM RTC setup" change seems to be modified (lacking e.g. a 
proper read_persistent_clock() implementation) compared to my proposal 
(second above) and most likely came from someone else and the lm90 change 
definitely comes from someone else.

 Note that for IRQ support you may have to investigate dependencies in the 
other two series as the patch (third above) was intended to apply on top 
of the two series (select the date sort for easier identification of the 
series).  I'd have to dig into that code for further details and I cannot 
afford the time right now, sorry.

  Maciej
