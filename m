Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Sep 2004 00:17:40 +0100 (BST)
Received: from web40004.mail.yahoo.com ([IPv6:::ffff:66.218.78.22]:61035 "HELO
	web40004.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225220AbUIJXRf>; Sat, 11 Sep 2004 00:17:35 +0100
Message-ID: <20040910231728.62214.qmail@web40004.mail.yahoo.com>
Received: from [63.87.1.243] by web40004.mail.yahoo.com via HTTP; Fri, 10 Sep 2004 16:17:28 PDT
Date: Fri, 10 Sep 2004 16:17:28 -0700 (PDT)
From: Song Wang <wsonguci@yahoo.com>
Subject: Routing Performance Comparison between 2.4 and 2.6 kernel
To: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <wsonguci@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsonguci@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm looking for the network packet routing
performance comparison between the latest 2.4
and 2.6 kernel.

I did some initial testing on my mips-based router.
2.6 kernel performed way below 2.4 kernel. It sucks.
Turning on preemption on 2.6 kernel even makes
routing performance worse.

Anybody did a comprehensive study on the routing
performance for 2.6 and 2.4 kernel?

Thanks.



		
_______________________________
Do you Yahoo!?
Shop for Back-to-School deals on Yahoo! Shopping.
http://shopping.yahoo.com/backtoschool
