Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jun 2004 07:01:13 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:18932 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224898AbUFNGBK>;
	Mon, 14 Jun 2004 07:01:10 +0100
Received: from [10.2.2.63] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id XAA09205;
	Sun, 13 Jun 2004 23:00:57 -0700
Subject: Re: HD Boot on Pb1500 Kernel 2.4.26
From: Pete Popov <ppopov@mvista.com>
To: "r.zilli" <r.zilli@ingredium.it>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040609143837.1848.qmail@pop.ingredium.it>
References: <20040609143837.1848.qmail@pop.ingredium.it>
Content-Type: text/plain
Organization: 
Message-Id: <1087192850.1666.1.camel@thinkpad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 13 Jun 2004 23:00:50 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2004-06-09 at 07:38, r.zilli wrote:
> Hi, list 
> 
> i've successful patched the 2.4.26 with v4l support to get the saa7134 
> driver support on Alchemy Pb1500. The driver for the HPT370 is ok but the 
> ide channels are not scanned and hard disk are not recognized. 

I just tried stock 2.4.26 from linux-mips on the Db1500 and the IDE
works fine for me. The Pb1500 should work as well. Try a stock kernel
without any additional patches you may be working on to make sure that's
not the problem.

Pete
