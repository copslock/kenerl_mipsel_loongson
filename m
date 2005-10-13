Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2005 13:00:12 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:35334 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3458542AbVJML75 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Oct 2005 12:59:57 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9DBxjPn005185;
	Thu, 13 Oct 2005 12:59:45 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9DBwAt5005092;
	Thu, 13 Oct 2005 12:58:10 +0100
Date:	Thu, 13 Oct 2005 12:58:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kyle Unice <unixe@comcast.net>
Cc:	"'Ilya A. Volynets-Evenbakh'" <ilya@total-knowledge.com>,
	"'David Daney'" <ddaney@avtrex.com>, ppopov@embeddedalley.com,
	"'Brett Foster'" <fosterb@uoguelph.ca>, linux-mips@linux-mips.org
Subject: Re: Cross-compiling Linux problem
Message-ID: <20051013115809.GA2654@linux-mips.org>
References: <4346FD34.8000100@total-knowledge.com> <003c01c5cc0f$83a19e30$0400a8c0@buzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003c01c5cc0f$83a19e30$0400a8c0@buzz>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Oct 08, 2005 at 07:52:24AM -0600, Kyle Unice wrote:

> It appears that the function __fixup_bigphys_addr is not inline anymore but 
> A callable function.  I removed the "inline " qualifier from the extern
> declaration in
> Ioremap.h (if CONFIG_64BIT_PHYS_ADDR is declared) and linux built ok.

Thanks for noting; fixed that in git.

  Ralf
