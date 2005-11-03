Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Nov 2005 16:32:44 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:28431 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133860AbVKCQc1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 3 Nov 2005 16:32:27 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jA3GXBVM026798;
	Thu, 3 Nov 2005 16:33:11 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jA3GX6Jt026786;
	Thu, 3 Nov 2005 16:33:06 GMT
Date:	Thu, 3 Nov 2005 16:33:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Stuart Anderson <anderson@netsweng.com>
Cc:	David Daney <ddaney@avtrex.com>, crossgcc@sources.redhat.com,
	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: linux kernel building for mips malta target board
Message-ID: <20051103163306.GC3149@linux-mips.org>
References: <E1EXLJV-0005R4-K3@real.realitydiluted.com> <43695DB4.7060708@avtrex.com> <Pine.LNX.4.61.0511022000410.3511@trantor.stuart.netsweng.com> <436965B7.3000606@avtrex.com> <Pine.LNX.4.61.0511022057140.3511@trantor.stuart.netsweng.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511022057140.3511@trantor.stuart.netsweng.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

> I shamed myself into sitting down and doing this. 8-)
> 
> The attached patch seems to work, or at least doesn't seem to cause
> things to blow up. An o32 userspace on a 64-bit kernel comes up
> multi-user and can build a kernel, and run a quick subset of LTP.
> 
> There was a comment on IRC that there was a register allocation issue which
> lead to the current code. I'm not sure of the exact details, but I _think_
> this change ends up being equivilent to the code it replaces.

It's correct - but triggers plenty of extra warnings and you forgot about
get_user() which has the same kind of issue.  Also you don't have the
guarantee that <linux/types.h> has been included, so in order to avoid a
yet another header file dependency I changed s8, s16 etc. to char, short,
int, long long.  Working on it but as usual uaccess.h is quite a quiz.

  Ralf
