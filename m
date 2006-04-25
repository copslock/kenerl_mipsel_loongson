Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2006 19:19:55 +0100 (BST)
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:60914 "EHLO
	mail8.fw-bc.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133813AbWDYSTp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Apr 2006 19:19:45 +0100
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k3PIWlqI010327;
	Tue, 25 Apr 2006 18:32:51 GMT
Received: from [192.168.1.10] ([43.134.85.105])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k3PIWkXI016585;
	Tue, 25 Apr 2006 18:32:47 GMT
Message-ID: <444E6B4E.5000608@am.sony.com>
Date:	Tue, 25 Apr 2006 11:32:46 -0700
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: CROSS_COMPILE in environment variable
References: <20060425.133944.88701465.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060425.133944.88701465.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <geoffrey.levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> In the toplevel Makefile, CROSS_COMPILE is described as:
> 
> # CROSS_COMPILE can be set on the command line
> # make CROSS_COMPILE=ia64-linux-
> # Alternatively CROSS_COMPILE can be set in the environment.
> # Default value for CROSS_COMPILE is not to prefix executables
> # Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
> 
> And currently, arch/mips/Makefile assigns CROSS_COMPILE as:
> 
> CROSS_COMPILE		:= $(tool-prefix)
> 
> This overrides environment variable's settings unconditionaly so we
> can no do the 'alternative' method described above (specify
> CROSS_COMPILE by shell environment variable).
> 
> If arch/mips/Makefile used "?=" assigment instead of ":=", we can
> specify CROSS_COMPILE by shell environment variable.
> 
> Is there any reason to using ":=" ?  If no, shouldn't we change
> arch/mips/Makefile corresponding to the description?
> 

In general this seems correct.

Another point is that the kernel has this:

ifdef CONFIG_CROSSCOMPILE
CROSS_COMPILE		:= $(tool-prefix)
endif

config CROSSCOMPILE
	bool "Are you using a crosscompiler"
	help
	  Say Y here if you are compiling the kernel on a different
	  architecture than the one it is intended to run on.


I think the Kconfig could be changed to say that CONFIG_CROSSCOMPILE
makes the build system use a built-in default tool prefix.

-Geoff
