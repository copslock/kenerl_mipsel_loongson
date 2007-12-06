Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2007 11:45:18 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:44765 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022993AbXLFLpO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Dec 2007 11:45:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB6BilI9006837;
	Thu, 6 Dec 2007 11:44:47 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB6Bikq7006836;
	Thu, 6 Dec 2007 11:44:46 GMT
Date:	Thu, 6 Dec 2007 11:44:46 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	peter fuerst <pf@pfrst.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
Message-ID: <20071206114446.GC6498@linux-mips.org>
References: <Pine.LNX.4.21.0712051841520.1354@Opal.Peter> <47570C27.9050901@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47570C27.9050901@avtrex.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 05, 2007 at 12:37:59PM -0800, David Daney wrote:

>> There was no answer to .../2006-05/msg01446.html. Perhaps i should just
>> put together an updated patch,
>
> That would be helpful.  It would have to be against GCC's svn trunk. 
> Currently 4.3 is in regression fix only mode.  The earliest the patch could 
> appear in an official GCC release would probably be version 4.4

Many distributions have the policy of applying only patches that are
upstream, even if they're upstream only for a newer version.  As such
getting them into the FSF 4.4 tree would also be tremendously useful as
an icebreaker.

  Ralf
