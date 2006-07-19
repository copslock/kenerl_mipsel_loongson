Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jul 2006 17:22:04 +0100 (BST)
Received: from smtp106.biz.mail.re2.yahoo.com ([206.190.52.175]:13758 "HELO
	smtp106.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133715AbWGSQVz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Jul 2006 17:21:55 +0100
Received: (qmail 66070 invoked from network); 19 Jul 2006 16:21:49 -0000
Received: from unknown (HELO ?172.16.1.43?) (dan@embeddedalley.com@12.6.244.2 with plain)
  by smtp106.biz.mail.re2.yahoo.com with SMTP; 19 Jul 2006 16:21:48 -0000
In-Reply-To: <20060719155804.GB5162@dusktilldawn.nl>
References: <20060719155804.GB5162@dusktilldawn.nl>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C4E21CBB-A5C6-49F5-A585-0910DD069544@embeddedalley.com>
Cc:	linux-mips@linux-mips.org
Content-Transfer-Encoding: 7bit
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: pseudo 32 bit physical addresses and the real 36 bit world
Date:	Wed, 19 Jul 2006 12:22:10 -0400
To:	Freddy Spierenburg <freddy@dusktilldawn.nl>
X-Mailer: Apple Mail (2.752.2)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Jul 19, 2006, at 11:58 AM, Freddy Spierenburg wrote:

> The AU1100 processor uses internally a 36-bit address bus. The
> kernel (32 bits) is only able to work with 32-bit addresses.
> Well, there must exist some sort of scheme for the kernel to work
> with these 36-bit addresses, but I don't quiet get it yet. Is
> anybody willing to give me some insight?

On the Alchemy processors, only some peripherals exist
above the 32-bit boundary.  We use a 64-bit version of
ioremap() to access this space.

> Of course the compiler warns us during compilation of
> drivers/pcmcia/au1000_generic.c:
>
> drivers/pcmcia/au1000_generic.c:403: warning: integer constant is  
> too large for "long" type

It looks like your configuration file is not enabling the
64-bit IO option.

> ....  I expect
> from reading the au1100 databook and 'See MIPS Run (chapter 6)
> that the TLB is involved, but I'm not yet able to link it
> altogether.

This has already been done for you :-)  There is nothing
for you to invent.  You didn't mention which version of
the kernel you are using, but the default configuration
files for boards with Alchemy processors should have
all of this properly configured.

Thanks.

	-- Dan
