Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Sep 2004 12:19:11 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:27638 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225220AbUIALTH>;
	Wed, 1 Sep 2004 12:19:07 +0100
Received: from [10.2.2.63] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id EAA05728;
	Wed, 1 Sep 2004 04:19:02 -0700
Subject: Re: gadget driver for Au1500
From: Pete Popov <ppopov@mvista.com>
To: "Peter 'p2' De Schrijver" <p2@mind.be>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040901094005.GX2305@mind.be>
References: <20040901094005.GX2305@mind.be>
Content-Type: text/plain
Organization: 
Message-Id: <1094037536.2502.7.camel@thinkpad.pacbell.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 01 Sep 2004 04:18:56 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, 2004-09-01 at 02:40, Peter 'p2' De Schrijver wrote:
> Hi,
> 
> Is there a USB gadget driver for the AMD Au1500 or is someone working on
> it ?

I have a patch for it but it doesn't work yet. The driver starts the
negotiation with the host but fails in the end. It was hard to debug the
problem without a USB analyzer, and I ran out of time, so it's on hold
at the moment. Someone else will take a look at it at some point. Are 
you willing to debug it :)?

Pete
