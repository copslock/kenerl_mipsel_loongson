Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2004 20:51:34 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:17366 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225209AbUHQTva>;
	Tue, 17 Aug 2004 20:51:30 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 17 Aug 2004 12:48:29 -0700
Message-ID: <41226134.7000401@avtrex.com>
Date: Tue, 17 Aug 2004 12:49:08 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Marcus Gustafsson <marcus.gustafsson@kreatel.se>,
	linux-mips@linux-mips.org
Subject: Re: Busybox v0.60.2 insmod gives segmentation fault without any m
 essages when trying to load a loadable module
References: <5BB336130A66D7119DEF009027463C2C0F2CDA@BERNTSSON> <20040817180806.GA14578@linux-mips.org>
In-Reply-To: <20040817180806.GA14578@linux-mips.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Aug 2004 19:48:29.0416 (UTC) FILETIME=[2B441E80:01C48493]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Aug 17, 2004 at 09:24:49AM +0200, Marcus Gustafsson wrote:
> 
> 
>>Im using gcc-3.3.3 and busybox-0.60.5 and insmod works if I strip the debug
>>symbols from the module.
> 
> 
> Seems that insmod is derived from an awfully old version from kernel.org;
> this bug was fixed years ago.
> 

GCC 3.3 introduced several new debugging information sections.  The
ability of insmod to handle these new sections was not added until
around October 2003 (to my best recollection).

David Daney.
