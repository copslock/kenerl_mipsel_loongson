Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 05:07:30 +0200 (CEST)
Received: from dns1.mips.com ([63.167.95.197]:52187 "EHLO dns1.mips.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491807AbZGJDHX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 05:07:23 +0200
Received: from MTVEXCHANGE.mips.com ([192.168.36.200])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id n6A37DvS019853;
	Thu, 9 Jul 2009 20:07:13 -0700
Received: from [192.168.65.41] ([192.168.65.41]) by MTVEXCHANGE.mips.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 9 Jul 2009 20:07:12 -0700
Message-ID: <4A56B060.7090106@mips.com>
Date:	Thu, 09 Jul 2009 20:07:12 -0700
From:	Chris Dearman <chris@mips.com>
Organization: MIPS Technologies
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
MIME-Version: 1.0
To:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
CC:	yuasa@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: What's happening with vr41xx_giu.c?
References: <4A5680B5.2090405@necel.com>
In-Reply-To: <4A5680B5.2090405@necel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2009 03:07:12.0626 (UTC) FILETIME=[854E7520:01CA010B]
Return-Path: <chris@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chris@mips.com
Precedence: bulk
X-list: linux-mips

Shinya Kuribayashi wrote:

> skuribay@ubuntu:linux.git$ make distclean
> skuribay@ubuntu:linux.git$
> skuribay@ubuntu:linux.git$
> skuribay@ubuntu:linux.git$ git status
> # On branch master
> # Changed but not updated:
> #   (use "git add/rm <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working 
> directory)
> #
> #       deleted:    drivers/char/vr41xx_giu.c
> #
> no changes added to commit (use "git add" and/or "git commit -a")
> skuribay@ubuntu:linux.git$
> 

Commit 27fdd325dace4a1ebfa10e93ba6f3d25f25df674 turned 
drivers/char/vr41xx_giu.c into an empty file instead of deleting it when 
the file was moved to drivers/gpio

"make distclean" deletes any 0 length .c files that it finds.

Leaving drivers/char/vr41xx_giu.c as a zero length file may have been a 
git bug but was probably just an oversight. I'll send a patch to clean 
it up as a followup.

Chris

-- 
Chris Dearman
MIPS Technologies Inc            955 East Arques Ave, Sunnyvale CA 94085
