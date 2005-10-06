Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 17:43:00 +0100 (BST)
Received: from smtp102.biz.mail.mud.yahoo.com ([68.142.200.237]:39017 "HELO
	smtp102.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133533AbVJFQmi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 17:42:38 +0100
Received: (qmail 87433 invoked from network); 6 Oct 2005 16:41:27 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@71.128.175.242 with plain)
  by smtp102.biz.mail.mud.yahoo.com with SMTP; 6 Oct 2005 16:41:27 -0000
Subject: Re: au1x00 usb device status
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <20051006154702.GA11086@gundam.enneenne.com>
References: <20051006073345.GB17583@gundam.enneenne.com>
	 <1128612772.9971.34.camel@localhost.localdomain>
	 <20051006154702.GA11086@gundam.enneenne.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 06 Oct 2005 09:41:14 -0700
Message-Id: <1128616874.9971.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-10-06 at 17:47 +0200, Rodolfo Giometti wrote:
> On Thu, Oct 06, 2005 at 08:32:52AM -0700, Pete Popov wrote:
> > USB Host should be working fine. USB Gadget on the Au1000,1100,1500,1550
> > just won't happen due to hw limitations. USB host and gadget on the 1200
> 
> Thanks for your answer!
> 
> Can you please explain to me (in brief :) which hw limitations are you
> talking about? Do you mean that usb device support in Linux cannot be
> implemented, or just that this can be done but with some restriction?

Timing issues with the Au1x00 (not the au1200) make the Linux gadget
implementation extremely difficult to support. If you don't service the
usb interrupt within a certain amount of time, you lose the status and
the gadget loses its state.

Pete
