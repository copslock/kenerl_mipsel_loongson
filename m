Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 May 2006 22:17:24 +0100 (BST)
Received: from mail8.fw-sd.sony.com ([160.33.66.75]:44976 "EHLO
	mail8.fw-sd.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133786AbWEDVRN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 May 2006 22:17:13 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-sd.sony.com (8.12.11/8.12.11) with ESMTP id k44LH6Lw019953;
	Thu, 4 May 2006 21:17:06 GMT
Received: from [43.134.85.135] ([43.134.85.135])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k44LH58T016983;
	Thu, 4 May 2006 21:17:05 GMT
Message-ID: <445A6F51.90308@am.sony.com>
Date:	Thu, 04 May 2006 14:17:05 -0700
From:	Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix mips/Makefile to support CROSS_COMPILE from environment
 var
References: <445A577D.7090507@am.sony.com> <20060504205517.GF18218@networkno.de>
In-Reply-To: <20060504205517.GF18218@networkno.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <tim.bird@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tim.bird@am.sony.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> It looks like the other arch-specific Makefiles also override the
> environment.

4 other arches I work with don't.

> To work around the problem, you can disable
> CONFIG_CROSSCOMPILE and define CROSS_COMPILE in the environment.

I thought that might be the case, but that's pretty broken IMHO.
It's counterintuitive and undocumented.

> 
> Strangely enough, the help for CONFIG_CROSSCOMPILE already explains
> that.

Here's the help from my Kconfig.debug:

          Say Y here if you are compiling the kernel on a different
          architecture than the one it is intended to run on.

Am I missing something?
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
