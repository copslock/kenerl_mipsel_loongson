Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2003 12:22:44 +0000 (GMT)
Received: from p508B7C1E.dip.t-dialin.net ([IPv6:::ffff:80.139.124.30]:26081
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224847AbTCFMWn>; Thu, 6 Mar 2003 12:22:43 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h26CMV815985;
	Thu, 6 Mar 2003 13:22:31 +0100
Date: Thu, 6 Mar 2003 13:22:31 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: jackson <jackson@realtek.com.tw>
Cc: linux-mips@linux-mips.org
Subject: Re: gnu tool-chain support for mips16?
Message-ID: <20030306132231.A15899@linux-mips.org>
References: <001a01c2e3ba$dd490e90$7405a8c0@realtek.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <001a01c2e3ba$dd490e90$7405a8c0@realtek.com.tw>; from jackson@realtek.com.tw on Thu, Mar 06, 2003 at 04:32:02PM +0800
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 06, 2003 at 04:32:02PM +0800, jackson wrote:

> I follow rules on http://www.ltc.com/~brad/mips/mips-cross-toolchain/
> to build gnu tool-cahin. 
> It works pefect for me to build linux/glibc/ulibc, and perform excellent
> on my Demo Board.
> 
> However, it report some bug messags as following when I compile a test.c 
> like:
> int test()
> {
>     return 0;
> }
> 
> ===================
> mips-linux-gcc -c -mips16 -o test test.c
> /tmp/ccjnCwV7.s: Assembler messages:
> /tmp/ccjnCwV7.s:14: Internal error!
> Assertion failure in macro_build_lui at ../../gas/config/tc-mips.c line 3107.
> Please report this bug.

All userspace with glibc, the standard userspace library environment for
Linux, must be PIC code and therefore the Linux compiler defaults to PIC
It's not possible to combine PIC code and MIPS16 ...

  Ralf
