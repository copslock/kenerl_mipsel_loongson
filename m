Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2003 12:36:08 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:41979 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225204AbTCGMgH>;
	Fri, 7 Mar 2003 12:36:07 +0000
Received: from [10.2.2.20] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id EAA05164;
	Fri, 7 Mar 2003 04:35:58 -0800
Subject: Re: Mycable XXS board
From: Pete Popov <ppopov@mvista.com>
To: Alexander Popov <s_popov@prosyst.bg>
Cc: linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <3E689267.3070509@prosyst.bg>
References: <3E689267.3070509@prosyst.bg>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1047040846.10649.10.camel@adsl.pacbell.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 07 Mar 2003 04:40:46 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, 2003-03-07 at 04:36, Alexander Popov wrote:
> Hi all,
> 
> Has anyone used the kernel on a Mycable XXS board ( it has Alchemy au1500 )...
> What CPU type should I choose for the au1500? R5000? Sorry for the lame question but I haven't used 
> MIPS-based boards and I know nothing baout the CPU...

Given that the board has an Alchemy Au1500 CPU, I would say you should
chose the Au1500 :)  Start with the Pb1500 board port that's in
linux-mips.org. Maybe, just maybe, a Pb1500 kernel will boot fine on
your board. And if it doesn't, creating a port for the above mentioned
board should be fairly easy.

Pete
