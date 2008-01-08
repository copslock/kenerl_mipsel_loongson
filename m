Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2008 23:00:43 +0000 (GMT)
Received: from mail.lundman.net ([210.172.146.197]:54699 "EHLO
	mail.lundman.net") by ftp.linux-mips.org with ESMTP
	id S20026956AbYAHXAe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Jan 2008 23:00:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.lundman.net (Postfix) with ESMTP id BF992299F3;
	Wed,  9 Jan 2008 08:00:27 +0900 (JST)
X-Virus-Scanned: amavisd-new at lundman.net
Received: from mail.lundman.net ([127.0.0.1])
	by localhost (eyot.interq.or.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HiiM1QWmbz4b; Wed,  9 Jan 2008 08:00:26 +0900 (JST)
Received: from shinken.interq.or.jp (shinken.interq.or.jp [210.172.146.228])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lundman.net (Postfix) with ESMTP id 83A16299E7;
	Wed,  9 Jan 2008 08:00:26 +0900 (JST)
Message-ID: <4784008A.1020106@lundman.net>
Date:	Wed, 09 Jan 2008 08:00:26 +0900
From:	Jorgen Lundman <lundman@lundman.net>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.5) Gecko/20070725 SeaMonkey/1.1.3
MIME-Version: 1.0
To:	Mark Lin <lin.mark@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: MIPS 4KEc with 2.6.15
References: <478174C1.2090708@lundman.net> <47824ACF.7050003@avtrex.com> <24f397b0801081402j24f7000cr841090ba5ab9bcc1@mail.gmail.com>
In-Reply-To: <24f397b0801081402j24f7000cr841090ba5ab9bcc1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lundman@lundman.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lundman@lundman.net
Precedence: bulk
X-list: linux-mips

Yeha I would love to use tangox, but there is none with Linux, at least 
no tarball of the kernel I have found?

Where can I get tangox?

Lund


Mark Lin wrote:
> Jorgen,
> 
> You should not be using the atlas definition.  Try the tangox one instead.
> 
> With the flush_cache_page changes, FUSE works fine for me using 2.6.15
> and Sigma's tango2 board.
> 
> Mark Lin
> 
> On Jan 7, 2008 10:52 AM, David Daney <ddaney@avtrex.com> wrote:
>> Jorgen Lundman wrote:
>>> Hello list,
>>>
>>> I have an embedded device running 2.6.15 kernel on a MIPS 4KEc 300MHz
>>> CPU. It was configured for Sigma's tango2 board, which I know nothing
>>> about, so I picked a mips-board by random, "atlas", and found I can
>>> produce working kernel module compiles.
>>>
>>> However, when I compiled FUSE kernel module, it behaves erratically in
>>> a way making the FUSE developer think I may have come across the cache
>>> coherency bug in arm and mips, fixed sometime around 2.6.17.
>>>
>>> Since I can not change the kernel that is running, I was looking for
>>> alternate solutions. FUSE itself has a work around, that calls
>>> flush_cache_page(), but I found that mips-board atlas does not have
>>> this defined:
>>>
>>> fuse: Unknown symbol flush_cache_page
>> There are cache coherency issues on the 8634.  You should be using the
>> vendor's very most recent kernels.  For me they seem to have resolved
>> the cache issues.
>>
>> Also as noted by others, you need the exact kernel sources if you are
>> going to build working modules.
>>
>> David Daney
>>
>>
> 

-- 
Jorgen Lundman       | <lundman@lundman.net>
Unix Administrator   | +81 (0)3 -5456-2687 ext 1017 (work)
Shibuya-ku, Tokyo    | +81 (0)90-5578-8500          (cell)
Japan                | +81 (0)3 -3375-1767          (home)
