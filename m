Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jul 2005 18:12:37 +0100 (BST)
Received: from [IPv6:::ffff:81.2.110.250] ([IPv6:::ffff:81.2.110.250]:45486
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8226309AbVGGRMW>; Thu, 7 Jul 2005 18:12:22 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j67HA3sI000325;
	Thu, 7 Jul 2005 18:10:03 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j67HA2N9000323;
	Thu, 7 Jul 2005 18:10:02 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: booting error on db1550 using linux 2.6.12 from linux-mips.org
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	rolf liu <rolfliu@gmail.com>
Cc:	ppopov@embeddedalley.com,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
In-Reply-To: <2db32b7205070508504b675dd6@mail.gmail.com>
References: <2db32b7205070114172483d2dd@mail.gmail.com>
	 <1120253048.5987.16.camel@localhost.localdomain>
	 <2db32b72050701153566c83bb6@mail.gmail.com>
	 <1120257851.5987.37.camel@localhost.localdomain>
	 <2db32b7205070508504b675dd6@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1120756200.317.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Thu, 07 Jul 2005 18:10:01 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2005-07-05 at 16:50, rolf liu wrote:
> Pete,
> I tried to make HPT working on db1550 for linux 2.6.12 cvs head. If I
> didn't force it to use 372 timing, it just hangs up after it detect
> the drive. If I used the 372 timing using the 2.4 trick, the kernel
> just crashed. Any clue?

Fix has been in the -ac tree for ages. Its finally gotten to Linus for
2.6.13 tree so pull it out of there.
