Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Feb 2003 17:31:00 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:14843 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224939AbTBXRbA>;
	Mon, 24 Feb 2003 17:31:00 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA09440;
	Mon, 24 Feb 2003 09:30:30 -0800
Subject: Re: QUERY: Porting Linux kernel to Toshiba TX4927
From: Pete Popov <ppopov@mvista.com>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: SANTHOSH K <santhoshk@nestec.net>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <3E5A223B.5020505@realitydiluted.com>
References: <F6E1228667B6D411BAAA00306E00F2A5153A6F@pdc2.nestec.net>
	 <3E5A223B.5020505@realitydiluted.com>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1046108071.30379.500.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Feb 2003 09:34:31 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, 2003-02-24 at 05:46, Steven J. Hill wrote:
> SANTHOSH K wrote:
> > 
> > 1. Has somone already ported Linux to TX4927 chip?
>  >
> Yes, we (TimeSys) have already done this.
> 
> > 2. If not, what is the complexity of this wor?
>  >
> Oh, it was a pretty interesting port. The PCI code is
> pretty awful.
> 
> > 3. If yes, then who is maintaining it. We could not get any information from
>  > the source tree.
>  >
> We will actively maintain it.
> 
> > 4. If yes, is it an open source? where can I get the source code.
> >
> The code should be released in the next couple of months.

Duplicated effort. We too have a 4927 port which the development
engineer who worked on it hasn't had time to push out.

Pete
