Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 01:02:14 +0000 (GMT)
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:26218 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20021880AbXCMBCI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 01:02:08 +0000
Received: (qmail 97569 invoked from network); 13 Mar 2007 01:01:01 -0000
Received: from unknown (HELO server1.RightHand.righthandtech.com) (righthandtech@sbcglobal.net@69.223.13.78 with login)
  by smtp111.sbc.mail.re2.yahoo.com with SMTP; 13 Mar 2007 01:01:01 -0000
X-YMail-OSG: 8BDp8vYVM1lLwzCftjQ9ctBDzhcCViyKj3yWbK5kOmKkVw5yrPEJ2hXjhcbBE4TzA5uBkEYhpKuZ09zAKgr3Lu9bSh2lIzmXV4VdQxA.U9HrWn8CQJevq1KSwWqUGVxdhll3gzujc_zYDeM-
Received: from [127.0.0.1] ([10.0.0.76]) by server1.RightHand.righthandtech.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 12 Mar 2007 19:01:01 -0600
Message-ID: <45F5F7CA.3000503@righthandtech.com>
Date:	Mon, 12 Mar 2007 20:00:58 -0500
From:	Andrew Dyer <adyer@righthandtech.com>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Marco Braga <marco.braga@gmail.com>,
	Domen Puncer <domen.puncer@telargo.com>,
	linux-mips@linux-mips.org
Subject: Re: Trouble with sound/mips/au1x00.c AC97 driver
References: <20070307104930.GD25248@dusktilldawn.nl> <d459bb380703082322r18879381ma4c57149a8b7adfe@mail.gmail.com> <45F350E9.3020208@cooper-street.com> <d459bb380703120157wb3dde00p4c232e300e82fd3d@mail.gmail.com> <d459bb380703120259r53889966xd8af623ff01ef297@mail.gmail.com> <20070312103927.GC14658@moe.telargo.com> <d459bb380703120609i7d3a9e1dwf7f4fa431a9631e5@mail.gmail.com> <45F57328.8000606@ru.mvista.com> <20070313004315.GA26119@linux-mips.org>
In-Reply-To: <20070313004315.GA26119@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Mar 2007 01:01:01.0182 (UTC) FILETIME=[114049E0:01C7650B]
Return-Path: <adyer@righthandtech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adyer@righthandtech.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> For the general MIPS case (Alchemy may provide guarantees I don't know of)
> a SYNC instruction is not sufficient to ensure that a write has actually
> been reached by the device.  It may just like on PCI take a read from the
> same device again:

I just looked it up.

Section 2.4.5 of the Alchemy Au1550 datasheet says that a SYNC is 
guaranteed to commit the write buffer to memory.

Whoever is looking at this should also pay attention to the CCA bits in 
the TLB mapping the registers (Section 2.3.6 of the manual) or the fixed 
regions (depending on the VA used) to make sure that merging and 
gathering are turned off.

-- 
Andrew Dyer <adyer@righthandtech.com>
Sr. Engineer
RightHand Technologies, Inc.
6545 N. Olmsted Ave.
Chicago, IL 60631
(773) 774-7600 x111
