Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 13:25:56 +0000 (GMT)
Received: from mail.lundman.net ([210.172.146.197]:32132 "EHLO
	mail.lundman.net") by ftp.linux-mips.org with ESMTP
	id S20025497AbYAGNZs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jan 2008 13:25:48 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.lundman.net (Postfix) with ESMTP id DFE34299F3
	for <linux-mips@linux-mips.org>; Mon,  7 Jan 2008 22:25:45 +0900 (JST)
X-Virus-Scanned: amavisd-new at lundman.net
Received: from mail.lundman.net ([127.0.0.1])
	by localhost (eyot.interq.or.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MkMz3L9h7np0 for <linux-mips@linux-mips.org>;
	Mon,  7 Jan 2008 22:25:40 +0900 (JST)
Received: from shinken.interq.or.jp (shinken.interq.or.jp [210.172.146.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lundman.net (Postfix) with ESMTP id 8ED43299E7
	for <linux-mips@linux-mips.org>; Mon,  7 Jan 2008 22:25:40 +0900 (JST)
Message-ID: <47822854.1010108@lundman.net>
Date:	Mon, 07 Jan 2008 22:25:40 +0900
From:	Jorgen Lundman <lundman@lundman.net>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.5) Gecko/20070725 SeaMonkey/1.1.3
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: MIPS 4KEc with 2.6.15
References: <478174C1.2090708@lundman.net> <20080107120852.GA24700@linux-mips.org>
In-Reply-To: <20080107120852.GA24700@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lundman@lundman.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lundman@lundman.net
Precedence: bulk
X-list: linux-mips

Sorry, I should have said, I grabbed 2.6.15.7 to use. And after the 
issues, I even tried the exact 2.6.15 tarball off Sigmas FTP with the 
same results. It does not define flush_cache_pages for Atlas board, only 
SGI IPxx from what I can tell.

Ralf Baechle wrote:
> On Mon, Jan 07, 2008 at 09:39:29AM +0900, Jorgen Lundman wrote:
> 
>> I have an embedded device running 2.6.15 kernel on a MIPS 4KEc 300MHz CPU. 
>> It was configured for Sigma's tango2 board, which I know nothing about, so 
>> I picked a mips-board by random, "atlas", and found I can produce working 
>> kernel module compiles.
>>
>> However, when I compiled FUSE kernel module, it behaves erratically in a 
>> way making the FUSE developer think I may have come across the cache 
>> coherency bug in arm and mips, fixed sometime around 2.6.17.
>>
>> Since I can not change the kernel that is running, I was looking for 
>> alternate solutions. FUSE itself has a work around, that calls 
>> flush_cache_page(), but I found that mips-board atlas does not have this 
>> defined:
> 
> While you may not be able to change the kernel running on your board,
> you should be building any modules against kernel headers of the exact
> kernel running and configured for the platform and CPU you're using.
> 
> Mixing and matching different versions and configurations may work but
> frequently it will fail silently.
> 
>   Ralf
> 

-- 
Jorgen Lundman       | <lundman@lundman.net>
Unix Administrator   | +81 (0)3 -5456-2687 ext 1017 (work)
Shibuya-ku, Tokyo    | +81 (0)90-5578-8500          (cell)
Japan                | +81 (0)3 -3375-1767          (home)
