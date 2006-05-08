Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 May 2006 19:23:21 +0100 (BST)
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:30419 "EHLO
	mail8.fw-sd.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133504AbWEHSXF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 May 2006 19:23:05 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id k48IMvTU025933;
	Mon, 8 May 2006 18:22:57 GMT
Received: from [43.134.85.135] ([43.134.85.135])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k48IMvJj002065;
	Mon, 8 May 2006 18:22:57 GMT
Message-ID: <445F8C81.4070406@am.sony.com>
Date:	Mon, 08 May 2006 11:22:57 -0700
From:	Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from environment
 var
References: <445A577D.7090507@am.sony.com> <20060504205517.GF18218@networkno.de> <445A6F51.90308@am.sony.com> <20060504223539.GG18218@networkno.de>
In-Reply-To: <20060504223539.GG18218@networkno.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <tim.bird@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tim.bird@am.sony.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> Update to a newer version:

Of what?  I'm using a 2.6.16 kernel here.

> config CROSSCOMPILE
> 	bool "Are you using a crosscompiler"
> 	help
> 	  Say Y here if you are compiling the kernel on a different
> 	  architecture than the one it is intended to run on.  This is just a
> 	  convenience option which will select the appropriate value for
> 	  the CROSS_COMPILE make variable which otherwise has to be passed on
> 	  the command line from mips-linux-, mipsel-linux-, mips64-linux- and
> 	  mips64el-linux- as appropriate for a particular kernel configuration.
> 	  You will have to pass the value for CROSS_COMPILE manually if the
> 	  name prefix for your tools is different.

Hmmm.  Well, I would say that this should be pushed to mainline,
but I still think it could be improved a bit.

IMHO, the config question should be something like:
"Use cross-compiler defined by Makefile", instead of "Are you
using a crosscompiler".

My recommendation would be to apply my patch and drop the
last sentence.  Then you get the best of all worlds:
 - support for command line specification, if you use it
 - support for env. var specification, if you use it.
 - automatic prefix selection if you use this option

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
