Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Mar 2005 17:46:11 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:39690 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224907AbVCIRp5>; Wed, 9 Mar 2005 17:45:57 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j29HjcXo024643;
	Wed, 9 Mar 2005 17:45:38 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j29HjcKm024642;
	Wed, 9 Mar 2005 17:45:38 GMT
Date:	Wed, 9 Mar 2005 17:45:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	JP Foster <jp.foster@exterity.co.uk>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: clear_user_page in page.h
Message-ID: <20050309174537.GB18688@linux-mips.org>
References: <1110287573.30647.16.camel@localhost.localdomain> <20050308140747.GC9811@linux-mips.org> <1110294681.30647.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110294681.30647.44.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 08, 2005 at 03:11:20PM +0000, JP Foster wrote:

> Great, that's what I did here. 
> When you say the code in question do you mean the v4l stuff or page.h?

Linux mm.  The (brain-)damage goes beyond page.h.

  Ralf
