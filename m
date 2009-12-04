Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 18:31:05 +0100 (CET)
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46426 "EHLO
        out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493402AbZLDRa6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 18:30:58 +0100
Received: from compute2.internal (compute2.internal [10.202.2.42])
        by gateway1.messagingengine.com (Postfix) with ESMTP id 34EB5C4F8D;
        Fri,  4 Dec 2009 12:30:57 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute2.internal (MEProxy); Fri, 04 Dec 2009 12:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:in-reply-to:references:subject:date; s=smtpout; bh=jGDdHI/SKkc95aZSRhlkrL8K8ls=; b=XVrpsORb26GCaYuPKVOLW1qOPGX7hER44gmNmM134kN5M3pi79PC60YmlYwNus74cI4JhEJh8VspIBOtX+1cSqq0iUjfffdUiGGiwg4Rq5oXPimbPc6EBvSzFTHpECM3pXauzfa1a12khXMlKBwRlHVLblXZv3+R3c42cyT0Bn8=
Received: by web8.messagingengine.com (Postfix, from userid 99)
        id 18656134BAE; Fri,  4 Dec 2009 12:30:57 -0500 (EST)
Message-Id: <1259947857.14965.1348483153@webmail.messagingengine.com>
X-Sasl-Enc: vghcyFVCki5Hc+7gJ3ka12vQo0IH1e+0Kz9FMgnH62f/ 1259947857
From:   myuboot@fastmail.fm
To:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org,
        "linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Mailer: MessagingEngine.com Webmail Interface
In-Reply-To: <20091204160333.GA8842@alpha.franken.de>
References: <20091028103551.0b4052d8@pixies.home.jungo.com>
 <1259891550.19943.1348372917@webmail.messagingengine.com>
 <20091204160333.GA8842@alpha.franken.de>
Subject: Re: PIR OFFSET for AR7
Date:   Fri, 04 Dec 2009 11:30:57 -0600
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips

Thomas,

Sorry, you are right. I mistook PM_OFFSET for PIR_OFFSET.

Thanks, Andrew
On Fri, 04 Dec 2009 17:03 +0100, "Thomas Bogendoerfer"
<tsbogend@alpha.franken.de> wrote:
> On Thu, Dec 03, 2009 at 07:52:30PM -0600, myuboot@fastmail.fm wrote:
> > Hi, What is the use of PIR register for AR7 board in file
> > arch/mips/ar7/irq.c?
> 
> it gives back the channel and line of the pending interrupt with the
> highest priority.
> 
> > If I understand it right, PIR is used to define the
> > polarity of the interrupts. It seems to me that it needs to initialized?
> 
> no, it's a read only register. Why do you think it has something to do
> with interrupt polarity ?
> 
> Thomas.
> 
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessary
> a
> good idea.                                                [ RFC1925, 2.3
> ]
