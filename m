Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2005 17:54:21 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:15769 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225344AbVHVQyD>; Mon, 22 Aug 2005 17:54:03 +0100
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.50 #1 (Debian))
	id 1E7Ehw-0008Ld-Er; Mon, 22 Aug 2005 10:59:32 -0500
Message-ID: <430A0463.4070004@realitydiluted.com>
Date:	Mon, 22 Aug 2005 11:59:15 -0500
From:	"Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Chris Wedgwood <cw@f00f.org>
CC:	mohanlal jangir <mohanlaljangir@hotmail.com>,
	linux-mips@linux-mips.org
Subject: Re: NPTL info needed
References: <200508181804.LAA04568@mon-irva-10.broadcom.com> <4304D201.2060306@mvista.com> <BAY18-DAV2A05369EA8C7D91990C16D2B50@phx.gbl> <4308D75D.3090205@realitydiluted.com> <20050821200151.GA23815@taniwha.stupidest.org>
In-Reply-To: <20050821200151.GA23815@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Chris Wedgwood wrote:
> 
> How stable is GCC is head?  Hostorically thre have been periods of
> time when gcc itself wasn't stable or the code it produce wasn't
> stable.
>
The last working GCC 4.1.0 I checked out was on 20050604. I have yet
to get a cross build to work with uClibc. glibc-based toolchains seem
to work okay, but yes, GCC 4.1.0 is a piece of ****.

-Steve
