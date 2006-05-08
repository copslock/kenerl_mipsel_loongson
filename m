Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 May 2006 19:57:56 +0100 (BST)
Received: from smtp104.biz.mail.re2.yahoo.com ([206.190.52.173]:6275 "HELO
	smtp104.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133499AbWEHS5q (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 May 2006 19:57:46 +0100
Received: (qmail 26676 invoked from network); 8 May 2006 18:57:39 -0000
Received: from unknown (HELO ?172.16.0.134?) (dan@embeddedalley.com@12.6.244.2 with plain)
  by smtp104.biz.mail.re2.yahoo.com with SMTP; 8 May 2006 18:57:39 -0000
In-Reply-To: <445F8F73.6030808@am.sony.com>
References: <20060504230647.GA3465@linux-mips.org> <445F8F73.6030808@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <628C0B36-1275-4BCC-AB4D-99D5EBBF6778@embeddedalley.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from envir onment var
Date:	Mon, 8 May 2006 14:56:56 -0400
To:	Tim Bird <tim.bird@am.sony.com>
X-Mailer: Apple Mail (2.749.3)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On May 8, 2006, at 2:35 PM, Tim Bird wrote:

> .....  I understand that having the cross-compiler prefix
> specified outside the build system has drawbacks.  When I first got
> into embedded Linux (many years ago), I was struck by the inelegance
> of this also.


The only drawback is you have to type it in correctly :-)
This "inelegance" of having to set an environment variable has
proven extremely useful in many of my experiences with
clients building real products.  They have installed many different
cross compilers, and often use build procedures to meet
various configuration management requirements.  The
need to explicitly select a complier is absolutely necessary,
you can't have a Makefile guessing.

I personally like setting the environment option, and wish
MIPS would just drop this whole cross compile selection
from the configuration process and work like all of the
other architectures.

Thanks.

	-- Dan
