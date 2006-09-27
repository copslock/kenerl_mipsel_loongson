Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 22:49:50 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:46288 "EHLO
	bluesmobile.corp.specifix.com") by ftp.linux-mips.org with ESMTP
	id S20039031AbWI0Vtt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Sep 2006 22:49:49 +0100
Received: from localhost.localdomain (bluesmobile.specifix.com [64.220.152.99])
	by bluesmobile.corp.specifix.com (Postfix) with ESMTP id 5791B3B82F;
	Wed, 27 Sep 2006 14:44:41 -0700 (PDT)
Subject: Re: oprofile configure?
From:	Jim Wilson <wilson@specifix.com>
To:	"Azer, William" <Bill.Azer@drs-ss.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <DEB94D90ABFC8240851346CFD4ACFF149E1C7F@gamd-ex-001.ss.drs.master>
References: <DEB94D90ABFC8240851346CFD4ACFF149E1C7F@gamd-ex-001.ss.drs.master>
Content-Type: text/plain
Date:	Wed, 27 Sep 2006 14:49:18 -0700
Message-Id: <1159393758.3181.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Tue, 2006-09-26 at 10:34 -0400, Azer, William wrote:
> i have natively built oprofile for sb1 platform and i get a lot of
> warnings from the compiler.  i had to use --disable-werror in order to
> build.  has anyone encountered this?  am i doing something wrong?

You didn't mention the oprofile version, the gcc version, or the kernel
version, which are the important bits here.  I can see from the error
messages that you have gcc-3.4.3, and a montavista kernel.
> 
I tried oprofile-0.9.2.  I was unable to get -Werror used in the
compiler.  Looking at the configure script, I see that -Werror is
disabled unless you have a snapshot from the cvs tree.  Not even
--enable-werror can turn it on.  I'm guessing that you are using the cvs
tree.

This looks like a bug in the gcc that you are using.  I can't reproduce
it on other systems, but I can reproduce it on a similar MontaVista
system.  I can't reproduce it with later FSF gcc releases on the same
MontaVista system.  It isn't immediately obvious what changed to fix
this.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
