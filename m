Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 16:09:09 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([IPv6:::ffff:67.116.42.147]:56864
	"EHLO avtrex.com") by linux-mips.org with ESMTP id <S8226091AbVF3PIx>;
	Thu, 30 Jun 2005 16:08:53 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 30 Jun 2005 08:10:03 -0700
Message-ID: <42C40AF5.6040600@avtrex.com>
Date:	Thu, 30 Jun 2005 08:08:37 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	zhan rongkai <zhanrk@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: I built a mipsel-linux toolchain, but it doesn't work
References: <73e6204505063000264527f601@mail.gmail.com>
In-Reply-To: <73e6204505063000264527f601@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2005 15:10:03.0406 (UTC) FILETIME=[CAA80AE0:01C57D85]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

zhan rongkai wrote:
> Hi folks,
> 
> At last night, I built a mipsel-linux cross-toolchain according to the
> following steps:
> 
> 1) The list of GNU Toolchain source packages
> =======================================================
> 
> * binutils: binutils-2.16.1.tar.gz
> *      gcc: gcc-3.4.4.tar.gz
> *    Linux: Linux-2.6.12.tar.bz2 (from www.kernel.org)
> *   uClibc: uClibc-0.9.27.tar.gz
> *      gdb: gdb-6.3.tar.gz
> 

IIRC gcc does not currently work out-of-the-box with uClibc.  If you are 
using uClibc, your best bet is probably to use the Buildroot system that 
can be found at the uClibc web site.

If you are building mips kernels, it is probably a better bet to get the 
source from linux-mips.org rather than kernel.org.  Because all fixes 
for mips related things show up in linux-mips.org first.

David Daney
