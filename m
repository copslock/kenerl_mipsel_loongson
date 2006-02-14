Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2006 13:40:06 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:61099 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133495AbWBNNj4
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Feb 2006 13:39:56 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k1EDk9rX013520;
	Tue, 14 Feb 2006 05:46:10 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k1EDk689013611;
	Tue, 14 Feb 2006 05:46:07 -0800 (PST)
Message-ID: <43F1DFB7.1060106@mips.com>
Date:	Tue, 14 Feb 2006 14:48:39 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
References: <200602140707.k1E77Tah013064@mbox00.po.2iij.net>	<20060214.164216.48797359.nemoto@toshiba-tops.co.jp>	<200602140856.k1E8uvm1021728@mbox03.po.2iij.net> <20060214.191215.115641299.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060214.191215.115641299.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
>>>>>> On Tue, 14 Feb 2006 17:56:57 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> said:
> yuasa> This patch fixed the boot problem, but the kernel still has
> yuasa> cache coherency problem.
> 
> yuasa> ~# ./cachetest 
> yuasa> Test separation: 4096 bytes: FAIL - cache not coherent
> 
> Thank you for testing.
> 
> As for the cachetest program, I think the test program is wrong.
> 
> It try to mmap offset 0 of a shared file to odd address page with
> MAP_FIXED.  It means "I want non-coherent mapping if dcache alias
> exists".  Currently the kernel surely gives what the program want.
> 
> The kernel might have to return EINVAL in such case, but I'm not sure
> which is the right behavior.  Please look at David S. Miller's
> comments, for example, http://lkml.org/lkml/2003/9/1/48

I've been maintaining for years that EINVAL is the correct
thing to do when the kernel detects that a user is requesting
a mapping that the kernel knows will create aliasing problems,
but this ran counter to the "serves the user right" philosophy
that seemed to dominate the Linux kernel community.  I'm
pleased to see that the tide seems to be shifting.  As an old-time
BSD/SysV hacker from the 1980s, I view system calls as a
contract with the user: if the kernel says it's OK, it's
supposed to work, period.

But I better get down off my soapbox before I launch into
my rant about the OOM killer being proof of a failed paradigm... ;o)

		Regards,

		Kevin K.
