Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2005 17:21:06 +0000 (GMT)
Received: from mail.scs.ch ([IPv6:::ffff:212.254.229.5]:10928 "EHLO
	mail.scs.ch") by linux-mips.org with ESMTP id <S8225274AbVATRVC>;
	Thu, 20 Jan 2005 17:21:02 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.scs.ch (8.12.11/8.12.11) with ESMTP id j0KHKcOW000433;
	Thu, 20 Jan 2005 18:20:38 +0100
Received: from mail.scs.ch ([127.0.0.1])
 by localhost (mail.scs.ch [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 00395-01; Thu, 20 Jan 2005 18:20:37 +0100 (CET)
Received: from kronenbourg.scs.ch (190.scs.ch [212.254.229.190])
	by mail.scs.ch (8.12.11/8.12.11) with ESMTP id j0KHKNrC000420;
	Thu, 20 Jan 2005 18:20:23 +0100
Subject: Re: Au1000 Big Endian USB OHCI
From:	Thomas Sailer <sailer@scs.ch>
To:	Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1106239023.4048.13.camel@xterm.intra>
References: <1106238575.8838.9.camel@kronenbourg.scs.ch>
	 <1106239023.4048.13.camel@xterm.intra>
Content-Type: text/plain
Organization: SCS
Date:	Thu, 20 Jan 2005 18:20:23 +0100
Message-Id: <1106241623.8838.13.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at scs.ch
Return-Path: <sailer@scs.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sailer@scs.ch
Precedence: bulk
X-list: linux-mips

On Thu, 2005-01-20 at 17:37 +0100, Herbert Valerio Riedel wrote:

> I'm successfully running linux 2.6.10 on an au15xx in big endian mode,
> with some slight modifications to the usb code, for which I posted a
> patch on the list some time ago (22 Nov 2004)...

I've seen this patch (thanks...) and applied it (by hand, it doesn't
quite apply any more), but it didn't help. Btw I have an AMD Pb1000
Board.

Tom
