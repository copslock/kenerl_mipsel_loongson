Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2006 23:33:50 +0100 (BST)
Received: from w099.z064220152.sjc-ca.dsl.cnc.net ([64.220.152.99]:23696 "HELO
	duck.specifix.com") by ftp.linux-mips.org with SMTP
	id S8134021AbWFPWdl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 16 Jun 2006 23:33:41 +0100
Received: from [127.0.0.1] (duck.corp.specifix.com [192.168.1.1])
	by duck.specifix.com (Postfix) with ESMTP
	id 28171FC7E; Fri, 16 Jun 2006 15:33:15 -0700 (PDT)
Subject: Re: gcc-4.1.0 cross-compile for MIPS
From:	James E Wilson <wilson@specifix.com>
To:	kernel coder <lhrkernelcoder@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <f69849430606160522i12050d00n9a4a39810f13b8a0@mail.gmail.com>
References: <f69849430606160522i12050d00n9a4a39810f13b8a0@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1150497195.17820.4.camel@aretha.corp.specifix.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date:	Fri, 16 Jun 2006 15:33:15 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <wilson@specifix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilson@specifix.com
Precedence: bulk
X-list: linux-mips

On Fri, 2006-06-16 at 05:22, kernel coder wrote:
> /home/shahzad/install//mipsel/sys-include -DHAVE_CONFIG_H -I.
> -I../../../gcc-4.1.0/libssp -I. -Wall -O2 -g -O2 -MT ssp.lo -MD -MP
> -MF .deps/ssp.Tpo -c ../../../gcc-4.1.0/libssp/ssp.c -o ssp.o
> ../../../gcc-4.1.0/libssp/ssp.c:46:20: error: fcntl.h: No such file or directory

You can't build target libraries like libssp in a --without-headers
build.  It was luck that this happened to work with earlier gcc
releases, because previously we didn't have C language target libraries
in gcc.  The solution is to do
  make all-gcc
  make install-gcc
instead of just
  make all
  make install

Please see Dan Kegel's crosstools package, which already knows how to do
this.
-- 
Jim Wilson, GNU Tools Support, http://www.specifix.com
