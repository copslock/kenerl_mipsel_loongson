Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2006 20:07:58 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:38565 "EHLO
	bluesmobile.corp.specifix.com") by ftp.linux-mips.org with ESMTP
	id S20027678AbWITTHy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Sep 2006 20:07:54 +0100
Received: from localhost.localdomain (bluesmobile.specifix.com [64.220.152.99])
	by bluesmobile.corp.specifix.com (Postfix) with ESMTP id 4C1173B896;
	Wed, 20 Sep 2006 12:02:48 -0700 (PDT)
Subject: Re: linux-libc-headers-2.6.17
From:	Jim Wilson <wilson@specifix.com>
To:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060920091846.29617.qmail@web7909.mail.in.yahoo.com>
References: <20060920091846.29617.qmail@web7909.mail.in.yahoo.com>
Content-Type: text/plain
Date:	Wed, 20 Sep 2006 12:07:09 -0700
Message-Id: <1158779230.2519.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Wed, 2006-09-20 at 10:18 +0100, sathesh babu wrote:
>     Can you please tell me where can i get
> linux-libc-headers-2.6.17.0 

There is probably no such package.  The linux headers are part of the
linux kernel sources, and the glibc headers are part of the glibc
sources.  Both have convenient makefile targets so that you can install
the headers when starting a build.

Some distro vendors may extract out these headers into a separate
package for convenience.  In that case, you either get the package from
the distro vendor, or if they don't have the package you are looking
for, you make it yourself.

I'd suggest looking at Dan Kegel's crosstool package, which provides
scripts showing how to do a build from scratch.  There is a pointer to
it on the www.linux-mips.org wiki.  See
    http://www.linux-mips.org/wiki/Toolchains
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
