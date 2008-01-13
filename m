Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jan 2008 04:56:03 +0000 (GMT)
Received: from mail.lundman.net ([210.172.146.197]:48001 "EHLO
	mail.lundman.net") by ftp.linux-mips.org with ESMTP
	id S20021941AbYAMEzo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 13 Jan 2008 04:55:44 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.lundman.net (Postfix) with ESMTP id A4BD7299F0
	for <linux-mips@linux-mips.org>; Sun, 13 Jan 2008 13:55:37 +0900 (JST)
X-Virus-Scanned: amavisd-new at lundman.net
Received: from mail.lundman.net ([127.0.0.1])
	by localhost (eyot.interq.or.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eT-cMpL4D6iK for <linux-mips@linux-mips.org>;
	Sun, 13 Jan 2008 13:55:36 +0900 (JST)
Received: from shinken.interq.or.jp (shinken.interq.or.jp [210.172.146.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lundman.net (Postfix) with ESMTP id B6E20299E7
	for <linux-mips@linux-mips.org>; Sun, 13 Jan 2008 13:55:36 +0900 (JST)
Message-ID: <478999C4.3040708@lundman.net>
Date:	Sun, 13 Jan 2008 13:55:32 +0900
From:	Jorgen Lundman <lundman@lundman.net>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.5) Gecko/20070725 SeaMonkey/1.1.3
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: flush_cache_page
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lundman@lundman.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lundman@lundman.net
Precedence: bulk
X-list: linux-mips


Due to cache coherence bugs, Fuse has an extra call to work around it;

         flush_cache_page(vma, cs->addr, page_to_pfn(cs->pg));


But my kernel (2.6.15 for mips 4KEc Tangox board) does not have a 
flush_cache_page().

If I use kangox_flush_all() Fuse works rather well, but the performance 
is abysmal. Can I simulate this call using one of the calls I do have;

__flush_dcache_page
flush_data_cache_page
tangox_flush_cache_all
cache_flush
kc_flush_cache

Or alternatively, does anyone have the source for flush_cache_page() for 
said CPU?



-- 
Jorgen Lundman       | <lundman@lundman.net>
Unix Administrator   | +81 (0)3 -5456-2687 ext 1017 (work)
Shibuya-ku, Tokyo    | +81 (0)90-5578-8500          (cell)
Japan                | +81 (0)3 -3375-1767          (home)
