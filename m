Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2005 13:02:28 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:4893 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226340AbVGHMCH>; Fri, 8 Jul 2005 13:02:07 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j68C2cPK002964;
	Fri, 8 Jul 2005 13:02:38 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j68C2cXh002963;
	Fri, 8 Jul 2005 13:02:38 +0100
Date:	Fri, 8 Jul 2005 13:02:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Cc:	linux-cvs@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050708120238.GA2816@linux-mips.org>
References: <20050708091711Z8226352-3678+1954@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050708091711Z8226352-3678+1954@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 08, 2005 at 10:17:05AM +0100, ths@linux-mips.org wrote:

> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	ths@ftp.linux-mips.org	05/07/08 10:17:05
> 
> Modified files:
> 	include/asm-mips: checksum.h 
> 
> Log message:
> 	Protect noat assembly with .set push/pop and make it somewhat readable.

It doesn't need protction.

 Ralf
