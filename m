Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Sep 2004 19:15:33 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:50891 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225210AbUIJSP2>;
	Fri, 10 Sep 2004 19:15:28 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 10 Sep 2004 11:15:22 -0700
Message-ID: <4141EF51.9050306@avtrex.com>
Date: Fri, 10 Sep 2004 11:15:45 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Buckingham <peter@pantasys.com>
CC: Ralf Baechle <ralf@linux-mips.org>, Christoph Hellwig <hch@lst.de>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] make the bcm1250 work
References: <4140C205.7020405@pantasys.com> <20040910075644.GA27574@lst.de> <4141DAD6.8000802@pantasys.com> <20040910175213.GA9910@linux-mips.org> <4141ECAC.8070806@pantasys.com>
In-Reply-To: <4141ECAC.8070806@pantasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2004 18:15:22.0696 (UTC) FILETIME=[233C4C80:01C49762]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Peter Buckingham wrote:
> Ralf Baechle wrote:
> 
>>Winners use grep(1) ;-)
> 
> 
> guess the old tools still work the best ;-)
> 
> 
>>Include/linux/initrd.h.
> 
> 
> okay, i've attached a new version of the patch. just a few questions. 
> would it make sense to lift __rd_start, __rd_end into initrd.h? also 
> would it make sense to add:
> 
Those are architecture dependent, and must be coordinated with the
linker script.  They probably should not be in linux/initrd.h.

David Daney.
