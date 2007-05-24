Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2007 20:44:29 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:63980 "EHLO
	bluesmobile.specifix.com") by ftp.linux-mips.org with ESMTP
	id S20022038AbXEXTo1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 May 2007 20:44:27 +0100
Received: from localhost.localdomain (bluesmobile.specifix.com [64.220.152.99])
	by bluesmobile.specifix.com (Postfix) with ESMTP id C068A3B938;
	Thu, 24 May 2007 12:44:14 -0700 (PDT)
Subject: Re: toolchain procedure for AU1200
From:	Jim Wilson <wilson@specifix.com>
To:	saravanan sar <sar_van81@yahoo.co.in>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <243199.27594.qm@web94304.mail.in2.yahoo.com>
References: <243199.27594.qm@web94304.mail.in2.yahoo.com>
Content-Type: text/plain
Date:	Thu, 24 May 2007 12:44:39 -0700
Message-Id: <1180035880.23076.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-2.fc5) 
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Mon, 2007-05-21 at 08:54 +0100, saravanan sar wrote:
> checking version of gcc... 4.1.0, bad

Here is your problem.  It looks like you are compiling glibc, and your
glibc version doesn't work with the gcc version you are using.  You
didn't mention the glibc sources version.  You can try looking at the
glibc configure file to see what gcc version it wants.  Just search for
the string "checking version of gcc" and look a few lines down for the
regexp that matches the expected gcc versions.  You will likely either
need to use a different glibc version or a different gcc version.  Since
you are probably using a RMI gcc port with non-public patches, changing
the gcc version may not be possible.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
