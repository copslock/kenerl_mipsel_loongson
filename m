Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2002 19:21:49 +0200 (CEST)
Received: from [129.21.60.9] ([129.21.60.9]:20460 "EHLO mcp.csh.rit.edu")
	by linux-mips.org with ESMTP id <S1122958AbSIDRVs>;
	Wed, 4 Sep 2002 19:21:48 +0200
Received: from csh.rit.edu (unknown [129.21.61.133])
	by mcp.csh.rit.edu (Postfix) with ESMTP
	id 4B31A4376; Wed,  4 Sep 2002 13:21:28 -0400 (EDT)
Message-ID: <3D7678C8.3020505@csh.rit.edu>
Date: Wed, 04 Sep 2002 17:19:04 -0400
From: George Gensure <werkt@csh.rit.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	linux-mips@linux-mips.org
Subject: Re: root-nfs hang and error
References: <Pine.SOL.4.31.0209021634320.24635-100000@fury.csh.rit.edu>	<20020903.163711.104027127.nemoto@toshiba-tops.co.jp>	<3D752698.5040907@csh.rit.edu> <20020904.103601.74754748.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <werkt@csh.rit.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 83
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: werkt@csh.rit.edu
Precedence: bulk
X-list: linux-mips

>
>
>So "ip=" and "nfsroot=" options may be
>required on diskless boot.
>
I'm actually good for that, I'm using nfsroot=<server ip>:<path> and the 
errors that come back correspond to the right host.  I know the ramdisk 
is used on the install, but I'm wondering if your nolock solution 
corresponds to the problem with the kernel mounting the nfsroot (i.e. it 
doesn't use it).  BTW, the root mounted flawlessly onto target, thanks 
for the nolock option.

-George
