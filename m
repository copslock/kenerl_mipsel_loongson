Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 19:32:59 +0100 (BST)
Received: from post1.wesleyan.edu ([129.133.6.131]:18898 "EHLO
	post1.wesleyan.edu") by ftp.linux-mips.org with ESMTP
	id S20023581AbXIYSc4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 19:32:56 +0100
Received: from webmail.wesleyan.edu (pony2.wesleyan.edu [129.133.6.193])
	by courier1.wesleyan.edu (8.13.6/8.13.6) with ESMTP id l8PIWl5g026827
	for <linux-mips@linux-mips.org>; Tue, 25 Sep 2007 14:32:47 -0400
Received: from 69.183.163.198
        (SquirrelMail authenticated user sknauert)
        by webmail.wesleyan.edu with HTTP;
        Tue, 25 Sep 2007 11:32:47 -0700 (PDT)
Message-ID: <57307.69.183.163.198.1190745167.squirrel@webmail.wesleyan.edu>
In-Reply-To: <20070925181353.GA15412@deprecation.cyrius.com>
References: <20070925181353.GA15412@deprecation.cyrius.com>
Date:	Tue, 25 Sep 2007 11:32:47 -0700 (PDT)
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
From:	sknauert@wesleyan.edu
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.10a
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Wesleyan-MailScanner-Information: Please contact the ISP for more information
X-Wesleyan-MailScanner:	Found to be clean
X-MailScanner-From: sknauert@wesleyan.edu
Return-Path: <sknauert@wesleyan.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sknauert@wesleyan.edu
Precedence: bulk
X-list: linux-mips

> IP32 kernels that are built with CONFIG_BUILD_ELF64=y only produce an
> exception when booted.  This worked with 2.6.19 and before.  I haven't
> had a chance to dig deep yet but it seems both Franck Bui-Huu and
> Atsushi Nemoto had patches in 2.6.20 that might have caused this.
> This still happens with 2.6.22.  I cannot boot current git for other
> reasons.
>
> If anyone has an idea which specific patch might have caused this,
> please let me know.  Otherwise I'll try to find time in the next few
> days to revert various patches.
> --
> Martin Michlmayr
> http://www.cyrius.com/
>

Nice to know someone's still working on Linux on the O2. I can confirm
that its been broken, and I had believed I was even told why by Kumba
http://www.nabble.com/Re:-Cross-Compile-difficulties-p10769217.html:

> One, make sure you're doing "make vmlinux.32", and two, CONFIG_BUILD_ELF64
> is
> _not_ enabled. For 2.6.20, I had to cram in a patch from Frank to get
> these
> things to not PROM crash (due to the elimination of CPHYSADDY and
> replacement by
> __pa()), but on 2.6.21, this patch was unnecessary.  Unsure about
> 2.6.22-rcX.

Anyway... sad to say this is a little beyond my understanding, but maybe
it can help you start hacking. For what its worth, I'll gladly test
patches on my O2s as I have an R5K 200 and RM7K 600.
