Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 00:39:45 +0000 (GMT)
Received: from mail.lundman.net ([210.172.146.197]:35985 "EHLO
	mail.lundman.net") by ftp.linux-mips.org with ESMTP
	id S20027277AbYAGAjh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jan 2008 00:39:37 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.lundman.net (Postfix) with ESMTP id E1BC4299F3
	for <linux-mips@linux-mips.org>; Mon,  7 Jan 2008 09:39:30 +0900 (JST)
X-Virus-Scanned: amavisd-new at lundman.net
Received: from mail.lundman.net ([127.0.0.1])
	by localhost (eyot.interq.or.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IpV-6fnZIlvi for <linux-mips@linux-mips.org>;
	Mon,  7 Jan 2008 09:39:29 +0900 (JST)
Received: from shinken.interq.or.jp (shinken.interq.or.jp [210.172.146.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lundman.net (Postfix) with ESMTP id A8D56299E7
	for <linux-mips@linux-mips.org>; Mon,  7 Jan 2008 09:39:29 +0900 (JST)
Message-ID: <478174C1.2090708@lundman.net>
Date:	Mon, 07 Jan 2008 09:39:29 +0900
From:	Jorgen Lundman <lundman@lundman.net>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.5) Gecko/20070725 SeaMonkey/1.1.3
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: MIPS 4KEc with 2.6.15
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lundman@lundman.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lundman@lundman.net
Precedence: bulk
X-list: linux-mips


Hello list,

I have an embedded device running 2.6.15 kernel on a MIPS 4KEc 300MHz 
CPU. It was configured for Sigma's tango2 board, which I know nothing 
about, so I picked a mips-board by random, "atlas", and found I can 
produce working kernel module compiles.

However, when I compiled FUSE kernel module, it behaves erratically in a 
way making the FUSE developer think I may have come across the cache 
coherency bug in arm and mips, fixed sometime around 2.6.17.

Since I can not change the kernel that is running, I was looking for 
alternate solutions. FUSE itself has a work around, that calls 
flush_cache_page(), but I found that mips-board atlas does not have this 
defined:

fuse: Unknown symbol flush_cache_page

Should I try other mips-boards that may have this function call defined? 
Do I have other ways to avoid the cache coherence bug?

The /proc/ksyms is gone, so I do not think I am able to check what 
symbols their kernel has.

Lund


-- 
Jorgen Lundman       | <lundman@lundman.net>
Unix Administrator   | +81 (0)3 -5456-2687 ext 1017 (work)
Shibuya-ku, Tokyo    | +81 (0)90-5578-8500          (cell)
Japan                | +81 (0)3 -3375-1767          (home)
