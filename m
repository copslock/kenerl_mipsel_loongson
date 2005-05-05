Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 May 2005 20:19:20 +0100 (BST)
Received: from mx01.qsc.de ([IPv6:::ffff:213.148.129.14]:48107 "EHLO
	mx01.qsc.de") by linux-mips.org with ESMTP id <S8225210AbVEETTF>;
	Thu, 5 May 2005 20:19:05 +0100
Received: from port-195-158-168-232.dynamic.qsc.de ([195.158.168.232] helo=hattusa.textio)
	by mx01.qsc.de with esmtp (Exim 3.35 #1)
	id 1DTls9-0002ps-00; Thu, 05 May 2005 21:18:57 +0200
Received: from ths by hattusa.textio with local (Exim 4.50)
	id 1DTls8-0003hR-QR; Thu, 05 May 2005 21:18:56 +0200
Date:	Thu, 5 May 2005 21:18:56 +0200
To:	Ulrich Teichert <krypton@ulrich-teichert.org>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: USB hangs on AU1100
Message-ID: <20050505191856.GD1628@hattusa.textio>
References: <20050505172017.GC1628@hattusa.textio> <200505051756.j45Hu54Y021121@arbas.nms.ulrich-teichert.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505051756.j45Hu54Y021121@arbas.nms.ulrich-teichert.org>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ulrich Teichert wrote:
> Hi,
> 
> [del]
> >I wonder if the code works reliable. At least, a comma operator isn't a
> >sequence point, which means the compiler is free to change the execution
> >order.
> 
> Not accordingly to the C standard, which notes strict left-to-right
> execution without reordering for the comma operator.

You are right, apparently I remembered incorrectly.


Thiemo
