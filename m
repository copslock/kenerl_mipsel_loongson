Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2002 19:19:42 +0200 (CEST)
Received: from mcp.csh.rit.edu ([129.21.60.9]:51869 "EHLO mcp.csh.rit.edu")
	by linux-mips.org with ESMTP id <S1122977AbSICRTl>;
	Tue, 3 Sep 2002 19:19:41 +0200
Received: from csh.rit.edu (unknown [129.21.61.133])
	by mcp.csh.rit.edu (Postfix) with ESMTP
	id 8B430437A; Tue,  3 Sep 2002 13:19:03 -0400 (EDT)
Message-ID: <3D752698.5040907@csh.rit.edu>
Date: Tue, 03 Sep 2002 17:16:08 -0400
From: George Gensure <werkt@csh.rit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	linux-mips@linux-mips.org
Subject: Re: root-nfs hang and error
References: <Pine.SOL.4.31.0209021634320.24635-100000@fury.csh.rit.edu> <20020903.163711.104027127.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <werkt@csh.rit.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 68
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: werkt@csh.rit.edu
Precedence: bulk
X-list: linux-mips

>
>
> # mount -o nolock server:/path /target
>
>  
>
gotcha.  That solves the install hang, but the bigger problem is this 
panic at boot, when all of my portmap calls return 128 (lockd, nfsd, and 
mountd) on the client.  I have no idea why this kernel is able to mount 
nfs partitions in the install, but not at boot time.

-George
werkt@csh.rit.edu
