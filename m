Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Dec 2004 21:27:44 +0000 (GMT)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:46251 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8225215AbULRV1b>; Sat, 18 Dec 2004 21:27:31 +0000
Received: from localhost ([127.0.0.1])
	by real.realitydiluted.com with esmtp (Exim 4.34 #1 (Debian))
	id 1Cfm6i-00065F-MM; Sat, 18 Dec 2004 15:27:20 -0600
Message-ID: <41C4A1DD.2090003@realitydiluted.com>
Date: Sat, 18 Dec 2004 15:32:13 -0600
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: linux-cvs@linux-mips.org, macro@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
References: <20041218022359Z8225198-1751+3809@linux-mips.org>
In-Reply-To: <20041218022359Z8225198-1751+3809@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

macro@linux-mips.org wrote:
> 
> Modified files:
> 	arch/mips/pci  : Makefile 
> 	include/linux  : pci_ids.h 
> 
> Log message:
> 	Fixup the SiByte PCI-HT bridge lying about being a host bridge.
> 
The file 'arch/mips/pci/fixup-sb1250.c' is missing. Please place into
CVS. Thank you.

-Steve
