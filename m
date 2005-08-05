Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Aug 2005 21:07:30 +0100 (BST)
Received: from smtp005.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.82]:34192
	"HELO smtp005.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225806AbVHEUHO>; Fri, 5 Aug 2005 21:07:14 +0100
Received: (qmail 56331 invoked from network); 5 Aug 2005 20:10:46 -0000
Received: from unknown (HELO ?192.168.1.106?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp005.bizmail.sc5.yahoo.com with SMTP; 5 Aug 2005 20:10:45 -0000
Subject: Re: AMD Au1100 problems (USB & Ethernet)
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Michael Kelly <mike@cogcomp.com>
Cc:	Sylvain Munaut <tnt@246tNt.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <6.2.0.14.2.20050805155414.044a0f00@mail.cogcomp.com>
References: <42F3C05E.7060002@246tNt.com>
	 <1123271252.19992.189.camel@localhost.localdomain>
	 <6.2.0.14.2.20050805155414.044a0f00@mail.cogcomp.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 05 Aug 2005 13:10:40 -0700
Message-Id: <1123272640.19992.199.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Fri, 2005-08-05 at 15:58 -0400, Michael Kelly wrote:
> The error count is less than .15%, not 5%.  This does not seem excessive.
> So, the question is what are these errors exactly.  We have done internal
> testing, but there is no way to test with every cable and switch/hub 
> combination.

Of course. I'm sure the CPU module itself is fine. I took a look at the
picture and it looks like the PHY is external so I'm guessing it's on
their custom PCB.

> If you could determine the actual errors (such as CRC, collision, etc) then we
> can try to determine where the errors are coming from.  It may very well be
> HW, but it is a bit too early to make such a broad statement without more
> information.

Well, could be just a cable issue, hub, etc, but I'll put that in the HW
bucket as well :)

Pete
