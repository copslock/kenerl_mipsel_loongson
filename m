Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2003 17:49:16 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:42999 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225376AbTIJQtO>;
	Wed, 10 Sep 2003 17:49:14 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id JAA22465;
	Wed, 10 Sep 2003 09:49:12 -0700
Message-ID: <3F5F5607.A094779E@mvista.com>
Date: Wed, 10 Sep 2003 10:49:11 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: "Steven J. Hill" <sjhill@realitydiluted.com>,
	linux-mips@linux-mips.org
Subject: Re: PATCH:2.4:tx4927 updates (mostly minor)
References: <3F5E0566.4E0DD26C@mvista.com> <3F5E85DD.1010700@realitydiluted.com> <20030910102057.GB1627@linux-mips.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips

> His patch removes the hardwired options - good thing - but anyway, I
> still think shipping anything but 9600 8N1 as default is wrong in most
> cases - there are still plenty of terminal servers and ancient hardware
> terminals in use that just don't support anything else or anything faster.
Since the board's f/w defaults to 38400, you'll need a termal faster than
9600 anyway.  I think this is one of the cases were the 9600 default makes
sense for the driver, but it also makes sense for the board to override it.
