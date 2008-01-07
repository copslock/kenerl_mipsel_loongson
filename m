Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 15:53:14 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:486 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20027231AbYAGPxG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jan 2008 15:53:06 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 9038C311BBD;
	Mon,  7 Jan 2008 15:53:03 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Mon,  7 Jan 2008 15:53:03 +0000 (UTC)
Received: from [192.168.7.229] ([192.168.7.229]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 7 Jan 2008 07:52:50 -0800
Message-ID: <47824ACF.7050003@avtrex.com>
Date:	Mon, 07 Jan 2008 07:52:47 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	Jorgen Lundman <lundman@lundman.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS 4KEc with 2.6.15
References: <478174C1.2090708@lundman.net>
In-Reply-To: <478174C1.2090708@lundman.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jan 2008 15:52:51.0879 (UTC) FILETIME=[5C09AB70:01C85145]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Jorgen Lundman wrote:
>
> Hello list,
>
> I have an embedded device running 2.6.15 kernel on a MIPS 4KEc 300MHz
> CPU. It was configured for Sigma's tango2 board, which I know nothing
> about, so I picked a mips-board by random, "atlas", and found I can
> produce working kernel module compiles.
>
> However, when I compiled FUSE kernel module, it behaves erratically in
> a way making the FUSE developer think I may have come across the cache
> coherency bug in arm and mips, fixed sometime around 2.6.17.
>
> Since I can not change the kernel that is running, I was looking for
> alternate solutions. FUSE itself has a work around, that calls
> flush_cache_page(), but I found that mips-board atlas does not have
> this defined:
>
> fuse: Unknown symbol flush_cache_page

There are cache coherency issues on the 8634.  You should be using the
vendor's very most recent kernels.  For me they seem to have resolved
the cache issues.

Also as noted by others, you need the exact kernel sources if you are
going to build working modules.

David Daney
