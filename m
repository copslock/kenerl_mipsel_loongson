Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 19:47:19 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:27154 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133554AbVJFSrC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 19:47:02 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j96IkufU012201;
	Thu, 6 Oct 2005 19:46:56 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j96IkuB9012200;
	Thu, 6 Oct 2005 19:46:56 +0100
Date:	Thu, 6 Oct 2005 19:46:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org, "Cooper, John" <john.cooper@timesys.com>
Subject: Re: PREEMPT
Message-ID: <20051006184656.GA12173@linux-mips.org>
References: <43456EA9.8020209@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43456EA9.8020209@timesys.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 06, 2005 at 02:36:25PM -0400, Greg Weeks wrote:

> Does anyone know of any current problems with CONFIG_PREEMPT on a 4kc 
> malta board? We're seeing some oddness in the floating point emulator 
> with PREEMPT_RT and wondered if it was in our RT code, or if it's from 
> the base kernel code.

No known problem in current problems in that area.

  Ralf
