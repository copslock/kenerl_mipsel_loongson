Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2005 11:14:42 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:36103 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226014AbVDDKO1>; Mon, 4 Apr 2005 11:14:27 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j34AEIXd003795;
	Mon, 4 Apr 2005 11:14:18 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j346L6Lh007225;
	Mon, 4 Apr 2005 07:21:06 +0100
Date:	Mon, 4 Apr 2005 07:21:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: conflicting declaration of prom_getcmdline()
Message-ID: <20050404062105.GA4975@linux-mips.org>
References: <200504011028.04244.eckhardt@satorlaser.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504011028.04244.eckhardt@satorlaser.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 01, 2005 at 10:28:04AM +0200, Ulrich Eckhardt wrote:

> I just stumbled over arch/mips/au1000/common/prom.c, which contains a function 
> defined like this:
>   char* prom_getcmdline(void);
>   EXPORT_SYMBOL(prom_getcmdline);
> while there are implementations that define the function as
>   char* __init prom_getcmdline();
> Further, there are several declarations throughout sourcefiles and in 
> include/asm-mips/mips-boards/prom.h and include/asm-mips/sgialib.h. Just grep 
> for it and you'll see the mess.
> 
> If anyone tells me which one is right and cares to explain why I hereby 
> volunteer to create a patch. ;)

__init was introduced long after prom_getcmdline() and not all definitions
ever got updated.  For prototypes where __init doesn't server any useful
purpose other than for the human reader so we generally don't use it.

You've herewith been volunteered ;-)

  Ralf
