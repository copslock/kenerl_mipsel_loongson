Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KGQWEC032375
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 09:26:32 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KGQW2b032374
	for linux-mips-outgoing; Tue, 20 Aug 2002 09:26:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from clearcore.com (clrsrv@[208.141.182.168])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KGQSEC032362
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 09:26:28 -0700
Received: (qmail 10472 invoked from network); 20 Aug 2002 16:29:21 -0000
Received: from clrsrv.clearcore.com (HELO clearcore.net) (192.168.1.1)
  by clrsrv.clearcore.com with SMTP; 20 Aug 2002 16:29:21 -0000
Message-ID: <3D626E61.3010505@clearcore.net>
Date: Tue, 20 Aug 2002 10:29:21 -0600
From: Joe George <joeg@clearcore.net>
Organization: ClearCore
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Lyle Bainbridge <lyle@zevion.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Mips cross toolchain
References: <NCBBKGDBOEEBDOELAFOFKEGGCPAA.lyle@zevion.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I don't know of anyone using big endian with Alchemy at this point.
There may be some and I'd like to hear from them.

The OSS tree is actually not that far out of date now.  I have been
submitting patches and the basics work now (at least on my board).
I am currently working on the 36-bit support.  The 36-bit support only
works for little endian currently afaics.  I'm working to solve the endian
problems now.

Check out the howto at http://www.linux-mips.org/.  There are 3 of
us doing Alchemy work who hang out on the #mipslinux irc channel
on irc.openprojects.net you're welcome to join us.

Joe
