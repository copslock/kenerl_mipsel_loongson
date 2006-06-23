Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 20:01:51 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:28852 "EHLO
	duck.specifix.com") by ftp.linux-mips.org with ESMTP
	id S8133591AbWFWTBl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 20:01:41 +0100
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id DFEFDFC50; Fri, 23 Jun 2006 12:01:21 -0700 (PDT)
Subject: Re: gcc-4.1.0 cross-compile for MIPS
From:	James E Wilson <wilson@specifix.com>
To:	kernel coder <lhrkernelcoder@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <f69849430606182340t72ed5a68l95a724ea933faf12@mail.gmail.com>
References: <f69849430606160522i12050d00n9a4a39810f13b8a0@mail.gmail.com>
	 <1150497195.17820.4.camel@aretha.corp.specifix.com>
	 <f69849430606182340t72ed5a68l95a724ea933faf12@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1151089281.25695.11.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Fri, 23 Jun 2006 12:01:21 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Sun, 2006-06-18 at 23:40, kernel coder wrote:
> ../glibc-2.3.6/configure --host=mipsel-linux --prefix="/usr"
> --enable-add-ons --with-headers=/home/shahzad/install/mipsel/include
> "misc/sys/uio.h"'; } |                 \ gcc -mabi=32 -E -dM -MD -MP
> cc1: error: unrecognized command line option "-mabi=32"

It failed, because it tries to give mips compiler options to the native
(x86?) compiler, which obviously won't work.  And you got this failure
because you configured glibc wrong.

As always, the answer to this problem can be found in Dan Kegel's
crosstools package, which knows how to correctly configure glibc.  Since
you apparently haven't taken my previous hints, instead of giving you
the answer, I'm just going to point you at the crosstools package, and
ask you to look it up yourself.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
