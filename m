Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2005 23:21:51 +0100 (BST)
Received: from smtp003.bizmail.yahoo.com ([IPv6:::ffff:216.136.130.195]:11413
	"HELO smtp003.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226152AbVGFWVe>; Wed, 6 Jul 2005 23:21:34 +0100
Received: (qmail 63964 invoked from network); 6 Jul 2005 22:21:58 -0000
Received: from unknown (HELO ?192.168.1.107?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp003.bizmail.yahoo.com with SMTP; 6 Jul 2005 22:21:57 -0000
Subject: Re: booting error on db1550 using linux 2.6.12 from linux-mips.org
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	rolf liu <rolfliu@gmail.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <2db32b72050706151542b4dd93@mail.gmail.com>
References: <2db32b7205070114172483d2dd@mail.gmail.com>
	 <1120253048.5987.16.camel@localhost.localdomain>
	 <2db32b72050701153566c83bb6@mail.gmail.com>
	 <1120257851.5987.37.camel@localhost.localdomain>
	 <2db32b7205070508504b675dd6@mail.gmail.com>
	 <1120633934.5724.29.camel@localhost.localdomain>
	 <2db32b72050706151542b4dd93@mail.gmail.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Wed, 06 Jul 2005 15:22:01 -0700
Message-Id: <1120688521.5724.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Wed, 2005-07-06 at 15:15 -0700, rolf liu wrote:
> Pete,
> could you give me some clues how I can make hpt371n work under linux 2.6? 
> Is there a need to force the 371n to use 372n timing? 

No idea. If I knew what the problem may be off the top of my head, I
would have just fixed it. The only thing I can tell you is that you'll
have to debug the problem, find the root cause, fix it, and then
hopefully send the list a patch :)

> can just timing issue cause the kernel to crash (panic)? 

I wouldn't rule out anything.

Pete
