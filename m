Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Aug 2005 07:28:46 +0100 (BST)
Received: from smtp003.bizmail.yahoo.com ([IPv6:::ffff:216.136.130.195]:14721
	"HELO smtp003.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8224832AbVHAG21>; Mon, 1 Aug 2005 07:28:27 +0100
Received: (qmail 73002 invoked from network); 1 Aug 2005 06:31:30 -0000
Received: from unknown (HELO ?192.168.1.126?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp003.bizmail.yahoo.com with SMTP; 1 Aug 2005 06:31:29 -0000
Subject: Re: Au1000 PCMCIA I/O space?
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <42EDBE3B.3010503@total-knowledge.com>
References: <42EDBE3B.3010503@total-knowledge.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Sun, 31 Jul 2005 23:31:29 -0700
Message-Id: <1122877889.5014.319.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Sun, 2005-07-31 at 23:16 -0700, Ilya A. Volynets-Evenbakh wrote:
> Is there any particular reason why Au1000 PCMCIA IO space is not 
> included in 36-bit address fixup?
> Attached patch fixes it for me, but I'm wondering if there is valid 
> reason not to do that.

Because it's ioremapped by the au1x pcmcia driver and the driver passes 
the virt address to the pcmcia stack. If this isn't working for you, 
something else is broken.  You only need the fixup when you can't call 
ioremap with the entire 36 bit phys address. For example, the attribute and
common memory space are ioremapped by the "pcmcia stack" in the kernel,
not the low level socket driver over which we have control. Thus, to
work around the fact that you can't easily change the entire pcmcia
stack, you do the fixup thing. 

Unless the pcmcia stack changed, the driver should work as is.

Pete
