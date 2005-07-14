Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2005 22:21:49 +0100 (BST)
Received: from smtp001.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.125]:24991
	"HELO smtp001.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226740AbVGNVVa>; Thu, 14 Jul 2005 22:21:30 +0100
Received: (qmail 26680 invoked from network); 14 Jul 2005 21:22:44 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp001.bizmail.yahoo.com with SMTP; 14 Jul 2005 21:22:44 -0000
Subject: Re: What is the current USB support status on DB1550?
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Kevin Turner <kevin.m.turner@pobox.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <1121374174.30104.7.camel@troglodyte.asianpear>
References: <2db32b7205071408327b005e4e@mail.gmail.com>
	 <1121356192.4797.362.camel@localhost.localdomain>
	 <1121374174.30104.7.camel@troglodyte.asianpear>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 14 Jul 2005 14:22:50 -0700
Message-Id: <1121376170.16115.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-07-14 at 13:49 -0700, Kevin Turner wrote:
> On Thu, 2005-07-14 at 08:49 -0700, Pete Popov wrote:
> > Host only. We couldn't make gadget work due to interrupt latency
> > requirements by the HW that couldn't be reliably achieved with Linux.
> > But gadget does work on the Au1200.
> 
> Is the Au1500 in the same boat as the DB1550? 

The Db1550 is the reference board for the Au1550.

>  Do the hardware
> requirements apply to all boards with that SOC, or is it somewhat
> board-dependent?

All boards with the 1100, 1500, or 1550. The Au1200 gadget works, but
the usb controller on the SOC is different. We've made the other CPUs
work before but it was on top of RTLinux, different/proprietary usb
stack, and a lot of debug and tuning.

Pete
