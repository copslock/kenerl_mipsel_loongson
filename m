Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2004 20:19:04 +0000 (GMT)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:21158
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225475AbUAOUTD>; Thu, 15 Jan 2004 20:19:03 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AhDx9-0004UV-00; Thu, 15 Jan 2004 14:18:55 -0600
Message-ID: <4006F5A9.2040602@realitydiluted.com>
Date: Thu, 15 Jan 2004 15:18:49 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Charlie Brady <charlieb-linux-mips@e-smith.com>
CC: "John W. Linville" <linville@lvl7.com>, linux-mips@linux-mips.org
Subject: Re: Broadcom gcc changes (was Re: Broadcom 4702?)
References: <Pine.LNX.4.44.0401151442590.17500-100000@allspice.nssg.mitel.com>
In-Reply-To: <Pine.LNX.4.44.0401151442590.17500-100000@allspice.nssg.mitel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Charlie Brady wrote:
> 
> Here's some of the gcc changes, to give you all a feel for what changes 
> they've made.
> 
> --- gcc-3.0/gcc/config/mips/mips.h      2001-06-14 16:42:18.000000000 
> -0400
> +++ WRT54G/tools-src/gnu-20010422/gcc/config/mips/mips.h        2003-10-10 
> 15:15:14.000000000 -0400
> @@ -214,6 +214,7 @@

The change simply disables the compiler from emitting branch likely
instructions when compiler userspace code. Branch likely instructions
are allowed when compiling kernel code.

-Steve
