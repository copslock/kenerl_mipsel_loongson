Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jan 2005 08:48:36 +0000 (GMT)
Received: from smtp004.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.81]:9131
	"HELO smtp004.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8224930AbVA1IsV>; Fri, 28 Jan 2005 08:48:21 +0000
Received: from unknown (HELO ?10.2.2.60?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp004.bizmail.sc5.yahoo.com with SMTP; 28 Jan 2005 08:48:18 -0000
Message-ID: <41F9FC53.7070401@embeddedalley.com>
Date:	Fri, 28 Jan 2005 00:48:19 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Kevin Turner <kevin.m.turner@pobox.com>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: pcmcia on au1x00
References: <1106895575.4059.42.camel@troglodyte.asianpear>
In-Reply-To: <1106895575.4059.42.camel@troglodyte.asianpear>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Kevin Turner wrote:
> Compiling from current CVS:
> 
>   CC [M]  drivers/pcmcia/au1000_pb1x00.o
> drivers/pcmcia/au1000_pb1x00.c:29:26: linux/tqueue.h: No such file or directory
> drivers/pcmcia/au1000_pb1x00.c:42:28: pcmcia/bus_ops.h: No such file or directory
> drivers/pcmcia/au1000_pb1x00.c:49:24: asm/au1000.h: No such file or directory
> drivers/pcmcia/au1000_pb1x00.c:50:31: asm/au1000_pcmcia.h: No such file or directory
> drivers/pcmcia/au1000_pb1x00.c:58:24: asm/pb1500.h: No such file or directory
> 
> What's the status of pcmcia on au1x00?
> Selecting db1x00 instead of pb1x00 seems to compile cleanly.

Right. The db1x00 is up to date. The pb1x boards are not.

> Can you give me an idea of what'll be necessary to do to get pcmcia
> working on a new Au1500-based board?

The au1000_generic.c is the generic portion of the driver. Then 
there is the board(s) specific portion. Just a look at the new 
db1x00 part and updating the pb1x00 driver should be pretty straight 
forward. You can reference the 2.4 kernel for the hardware specifics 
of the pb1x.

Pete
