Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2004 17:27:18 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:5884 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225313AbUFIQ1O>;
	Wed, 9 Jun 2004 17:27:14 +0100
Received: from [10.2.2.68] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA12600;
	Wed, 9 Jun 2004 09:27:01 -0700
Subject: Re: HD Boot on Pb1500 Kernel 2.4.26
From: Pete Popov <ppopov@mvista.com>
To: "r.zilli" <r.zilli@ingredium.it>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040609143837.1848.qmail@pop.ingredium.it>
References: <20040609143837.1848.qmail@pop.ingredium.it>
Content-Type: text/plain
Organization: 
Message-Id: <1086798549.15514.37.camel@thinkpad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 09 Jun 2004 09:29:09 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5272
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
> 
> Thanks for any help 

2.4.25 was fine. I haven't tried 2.4.26 yet to see if anything broke
during the merge. You're just using the ide controller on the Pb1500,
not an external PCI controller, right?

Pete
