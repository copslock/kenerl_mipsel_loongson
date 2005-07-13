Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2005 01:46:05 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:16142 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8226667AbVGMApt>; Wed, 13 Jul 2005 01:45:49 +0100
Received: from [192.168.1.109] (adsl-71-128-175-242.dsl.pltn13.pacbell.net [71.128.175.242])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j6D0X7mN016492;
	Tue, 12 Jul 2005 20:33:08 -0400
In-Reply-To: <ecb4efd105071217254e68b9e2@mail.gmail.com>
References: <ecb4efd105071217254e68b9e2@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b5f7ad7b7c6ca0a1a80a3b8cb41a964c@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: reboot gets stuck in a TLB exception on Au1550 based board
Date:	Tue, 12 Jul 2005 17:46:44 -0700
To:	Clem Taylor <clem.taylor@gmail.com>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Jul 12, 2005, at 5:25 PM, Clem Taylor wrote:

> I was wondering if anyone else has a problem with reboot not working
> on a Au1550?

What kernel and what version of YAMON?

I just happened to have a shell prompt on the Au1550 with 2.4.31
and YAMON ROM Monitor, Revision 02.24DB1550.

Reboot worked just fine, got me back to the YAMON prompt and
booted Linux.

>  When I issue a reboot, the kernel prints "** Resetting
> Integrated Peripherals", but the system doesn't reboot.

Do you know what peripherals may have been running
when you did the reboot?  I was using an NFS root file system
and had AC97 audio running.

> My BDI shows ....

What happens if you don't have the BDI connected?  Often,
boot roms step on debugger set up that the BDI does, causing
confusion on both parties.

> One difference between the stock db1x00 code and my code ....

Oh, now you tell me :-)  Custom hardware and different code,
I wonder why it doesn't work? :-)

It seems that if the hardware, YAMON, and Linux are all compatible,
there isn't any trouble.  Yes, I was using the Db1550.

> I was wondering if anyone might have a clue what is going on or some
> suggestions on what I can do to continue debugging this?

Only you know what is different, so you may want to look in those
places first.

Have fun!

	-- Dan
