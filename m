Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2003 11:21:01 +0100 (BST)
Received: from p508B5748.dip.t-dialin.net ([IPv6:::ffff:80.139.87.72]:24753
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225348AbTIJKU7>; Wed, 10 Sep 2003 11:20:59 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8AAKwLT012376;
	Wed, 10 Sep 2003 12:20:58 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8AAKviF012375;
	Wed, 10 Sep 2003 12:20:57 +0200
Date: Wed, 10 Sep 2003 12:20:57 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: michael_pruznick@mvista.com, linux-mips@linux-mips.org
Subject: Re: PATCH:2.4:tx4927 updates (mostly minor)
Message-ID: <20030910102057.GB1627@linux-mips.org>
References: <3F5E0566.4E0DD26C@mvista.com> <3F5E85DD.1010700@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5E85DD.1010700@realitydiluted.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 09, 2003 at 10:01:01PM -0400, Steven J. Hill wrote:

> Hi Michael.
> 
> May I ask why you are using 38400 for the baud rate and not
> the maximum 57600?

His patch removes the hardwired options - good thing - but anyway, I
still think shipping anything but 9600 8N1 as default is wrong in most
cases - there are still plenty of terminal servers and ancient hardware
terminals in use that just don't support anything else or anything faster.

  Ralf
