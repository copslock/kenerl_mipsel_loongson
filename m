Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2005 15:05:18 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:40462 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225474AbVFXOFB>; Fri, 24 Jun 2005 15:05:01 +0100
Received: from [192.168.2.27] (h69-21-252-132.69-21.unk.tds.net [69.21.252.132])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j5ODqMws013586;
	Fri, 24 Jun 2005 09:52:23 -0400
In-Reply-To: <20050624072541.95080.qmail@web25801.mail.ukl.yahoo.com>
References: <20050624072541.95080.qmail@web25801.mail.ukl.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <414d5d874e0b9705dc71bd95e0e019ba@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	Ulrich Eckhardt <eckhardt@satorlaser.com>,
	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: which 2.6 kernel can be run on db1550?
Date:	Fri, 24 Jun 2005 10:04:01 -0400
To:	moreau francis <francis_moreau2000@yahoo.fr>
X-Mailer: Apple Mail (2.622)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Jun 24, 2005, at 3:25 AM, moreau francis wrote:

> although 2.6.12 tag doens't exist and HEAD doens't compile (I checked 
> it
> yesterday)...

I just checked out the top of the linux-mips tree, which is 2.6.12.
It compiles and runs fine on the Db1500.  I'm now doing the same
for the Pb1550, but I don't suspect any problems because I have
been using it for quite some time.  It looks like it is time to update
the default configuration files, but accepting the default answer for
any new options seems to work fine.

I am using gcc-3.3.3 or 3.4.1, and some 2.15 version of binutils.
Using your MIPS SDE tools is going to be a problem because
they are not up to date with what the source code requires.

Thanks.


	-- Dan
