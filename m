Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 01:37:00 +0000 (GMT)
Received: from bisque.propagation.net ([IPv6:::ffff:66.221.142.1]:38099 "EHLO
	bisque.propagation.net") by linux-mips.org with ESMTP
	id <S8225240AbTBEBg7>; Wed, 5 Feb 2003 01:36:59 +0000
Received: from freehandsystems.com (adsl-64-170-127-190.dsl.snfc21.pacbell.net [64.170.127.190])
	by bisque.propagation.net (8.11.6/8.8.5) with ESMTP id h151aoA10408;
	Tue, 4 Feb 2003 19:36:50 -0600
Message-ID: <3E406ABC.A9D0D6F@freehandsystems.com>
Date: Tue, 04 Feb 2003 17:37:00 -0800
From: Tibor Polgar <tpolgar@freehandsystems.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Clausen <clausen@melbourne.sgi.com>
CC: Jason Ormes <jormes@wideopenwest.com>, linux-mips@linux-mips.org
Subject: Re: kernel boot error.
References: <200302041841.10507.jormes@wideopenwest.com> <20030205004345.GI27302@pureza.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <tpolgar@freehandsystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tpolgar@freehandsystems.com
Precedence: bulk
X-list: linux-mips

> I'm getting exactly the same problem.  What machine are you using?
> I'm using an ip27 (origin 200), and an acenic network card.
> 
> It seems that there all kinds of PCI hacks in the ip27 support,
> and I'm currently trying to figure out how to get this card working...

My buddy and I used to work at Alteon with my buddy doing most of the original
NIC firmware coding.  I don't remember who did the SGI driver side coding.  
The linux driver was done by Jes Sorensen using our OpenDriver kit. Let me
know if we can help in any way.   Is the Origin an SGI machine?  If so, i do
recall we had to do some special casing to get the card to work correctly. 
This was 4 years ago ....

Tibor
