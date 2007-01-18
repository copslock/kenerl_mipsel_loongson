Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 23:18:01 +0000 (GMT)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:44418 "EHLO
	bluesmobile.corp.specifix.com") by ftp.linux-mips.org with ESMTP
	id S28575036AbXARXR5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Jan 2007 23:17:57 +0000
Received: from localhost.localdomain (bluesmobile.specifix.com [64.220.152.99])
	by bluesmobile.corp.specifix.com (Postfix) with ESMTP id 171EF3B830;
	Thu, 18 Jan 2007 15:17:47 -0800 (PST)
Subject: Re: crt0.s for mips
From:	Jim Wilson <wilson@specifix.com>
To:	Anders Brogestam <anders.brogestam@avegasystems.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1169094906.14832.3.camel@localhost>
References: <1169094906.14832.3.camel@localhost>
Content-Type: text/plain
Date:	Thu, 18 Jan 2007 15:17:47 -0800
Message-Id: <1169162267.2542.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Thu, 2007-01-18 at 15:35 +1100, Anders Brogestam wrote:
> I am looking for a crt0.s file for the MIPS architecture. Included in
> all the Linux kernels that I downloaded and looked in there are only
> source for the PPC.

You can find some example embedded target crt0.s files in the libgloss
directory of the newlib package.  The newlib package can be found on the
sourceware.org web site.  This stuff has nothing to do with linux or the
linux kernel though.  It is meant for running code on bare hardware.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
