Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Feb 2003 16:51:17 +0000 (GMT)
Received: from p508B6FDE.dip.t-dialin.net ([IPv6:::ffff:80.139.111.222]:31701
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225211AbTBEQvQ>; Wed, 5 Feb 2003 16:51:16 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h15GpCf16192;
	Wed, 5 Feb 2003 17:51:12 +0100
Date: Wed, 5 Feb 2003 17:51:12 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Gilad Benjamini <yaelgilad@myrealbox.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Porting an application to mips-linux
Message-ID: <20030205175112.A14089@linux-mips.org>
References: <1044428825.ae2319a0yaelgilad@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1044428825.ae2319a0yaelgilad@myrealbox.com>; from yaelgilad@myrealbox.com on Wed, Feb 05, 2003 at 07:07:05AM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1337
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 05, 2003 at 07:07:05AM +0000, Gilad Benjamini wrote:

> I have a source level application, ~10 c files, standard stuff, mostly sockets.
> I'd like it to run on my mips-linux platform.
> I guess my changes should mostly be in the Makefile.
> What should they be ?
> Any simple example I can use ?

A normal application simply needs to be recompiled; if you're crosscompiling
the application you just have to set the CC,LD etc. variables to the
crosscompiler tools instead of the native tools.  If you're doing
native builds no changes at all should be necessary.  At least that's the
general procedure.

  Ralf
