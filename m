Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 16:33:32 +0100 (BST)
Received: from smtp102.biz.mail.mud.yahoo.com ([68.142.200.237]:15009 "HELO
	smtp102.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133541AbVJFPdO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 16:33:14 +0100
Received: (qmail 61886 invoked from network); 6 Oct 2005 15:33:06 -0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp102.biz.mail.mud.yahoo.com with SMTP; 6 Oct 2005 15:33:06 -0000
Subject: Re: au1x00 usb device status
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <20051006073345.GB17583@gundam.enneenne.com>
References: <20051006073345.GB17583@gundam.enneenne.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Thu, 06 Oct 2005 08:32:52 -0700
Message-Id: <1128612772.9971.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Thu, 2005-10-06 at 09:33 +0200, Rodolfo Giometti wrote:
> I'm trying to enable usb device support on an au1x00 based board, but
> I notice that such support is still not ported to 2.6 nor to usb
> gadget.

USB Host should be working fine. USB Gadget on the Au1000,1100,1500,1550
just won't happen due to hw limitations. USB host and gadget on the 1200
are on hold at the moment. I'll let you know if that moves forward. We
already split out the pci bus dependencies from the echi driver and sent
David the patches. They'll be going upstream soon. Adding ehci host
support for the 1200 will be much easier then.

Pete
