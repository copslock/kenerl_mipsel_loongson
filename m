Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2003 17:42:54 +0000 (GMT)
Received: from real.realitydiluted.com ([IPv6:::ffff:208.242.241.164]:50831
	"EHLO real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225352AbTLLRmx>; Fri, 12 Dec 2003 17:42:53 +0000
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1AUrJM-000202-00; Fri, 12 Dec 2003 11:42:44 -0600
Message-ID: <3FD9FE11.3060501@realitydiluted.com>
Date: Fri, 12 Dec 2003 12:42:41 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: durai <durai@isofttech.com>
CC: mips <linux-mips@linux-mips.org>
Subject: Re: Network problem in mips
References: <008f01c3bff7$252e3b40$0a05a8c0@DURAI> <3FD88C4D.6010700@realitydiluted.com> <001d01c3c083$be226600$0a05a8c0@DURAI>
In-Reply-To: <001d01c3c083$be226600$0a05a8c0@DURAI>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3747
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

durai wrote:
>
> Sorry for the incomplete information.
> My OS is uCLinux (linux kernel 2.4.10) . Whenever I start a high transfer
> through the wireless interface the system crashes, sometimes it hangs
> without any messages in the console. Here is the oops message.
>
No problem. You have a thick skin :). Let's take a look at things.

[SNIP]
> epc  : 80f930c1
> Status: 3000fc00
> Cause : 00000010
>
What is the function at '0x80f930c1'? If the function is less than 20 lines,
go ahead a paste it in. If not, compile with debugging symbols, use GDB on
the kernel and do a 'dissassem 0x80f930c1' and show us the lines that way.

[SNIP]
> Code:Unaligned memory access at 8020b780, address 80f930b5, PID -2142680720
> ( )
> 
Well, you have an unaligned access, so hopefully we can see from the code
what you were trying to do. Looking forward to your reply.

-Steve
