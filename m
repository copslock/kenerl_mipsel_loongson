Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Aug 2004 16:46:00 +0100 (BST)
Received: from web13303.mail.yahoo.com ([IPv6:::ffff:216.136.175.39]:52334
	"HELO web13303.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225196AbUHZPpz>; Thu, 26 Aug 2004 16:45:55 +0100
Message-ID: <20040826154553.39496.qmail@web13303.mail.yahoo.com>
Received: from [12.33.232.234] by web13303.mail.yahoo.com via HTTP; Thu, 26 Aug 2004 08:45:53 PDT
Date: Thu, 26 Aug 2004 08:45:53 -0700 (PDT)
From: Ken Giusti <manwithastinkydog@yahoo.com>
Subject: Re: bcm1250 crash in eth rx in an -old- kernel
To: linux-mips <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <manwithastinkydog@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manwithastinkydog@yahoo.com
Precedence: bulk
X-list: linux-mips

s/bcm5682/bcm1250/g  - sorry.... -K

--- Ken Giusti <manwithastinkydog@yahoo.com> wrote:

> Hi,
> 
> I'm maintaining a bcm1250-based system that's
<snip>
> I've monitored these crashes for awhile now, and the
> stackdumps are all similar in that they appear to 
> involve the bcm5682 ethernet receive path.  Not
> exact,
> but very similar, and always involving a socket
> operation (allocation, wakeup, put).
<snip>


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - You care about security. So do we.
http://promotions.yahoo.com/new_mail
