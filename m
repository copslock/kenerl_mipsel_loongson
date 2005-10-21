Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Oct 2005 17:04:54 +0100 (BST)
Received: from smtp103.biz.mail.mud.yahoo.com ([68.142.200.238]:62136 "HELO
	smtp103.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133534AbVJUQEh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Oct 2005 17:04:37 +0100
Received: (qmail 55908 invoked from network); 21 Oct 2005 16:04:24 -0000
Received: from unknown (HELO ?192.168.1.102?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp103.biz.mail.mud.yahoo.com with SMTP; 21 Oct 2005 16:04:24 -0000
Subject: Re: FW: Re: au1x00 usb device status
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	"Hamilton, Ian" <Ian.Hamilton@xerox.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <DAF42D2FFC65A146BAB240719E4AD214C212BF@gbrwgceumf02.eu.xerox.net>
References: <DAF42D2FFC65A146BAB240719E4AD214C212BF@gbrwgceumf02.eu.xerox.net>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 21 Oct 2005 09:04:27 -0700
Message-Id: <1129910667.4596.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Fri, 2005-10-21 at 14:17 +0100, Hamilton, Ian wrote:
> Hi Pete and Rodolfo.
> 
> I also need to get the device USB port working on an au1100 board.
> 
> We have code running under a 2.4 kernel working on this board, and I'm
> currently porting the code to a 2.6 kernel.
> 
> The USB device port seems to work OK for us with the 2.4 kernel.
> 
> 
> Pete,
> 
> Is there a full description of the timing problem somewhere on the web?
> In particular, how quickly does the interrupt need to be serviced?

Dan knows more about it but I see he replied already. We had problems
getting gadget to work. Seemed like we were close but couldn't get it to
work reliably.

Pete
