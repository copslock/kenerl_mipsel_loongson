Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f46Nap716460
	for linux-mips-outgoing; Sun, 6 May 2001 16:36:51 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f46NaoF16457
	for <linux-mips@oss.sgi.com>; Sun, 6 May 2001 16:36:50 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 7223BF1A9; Sun,  6 May 2001 16:35:51 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 7D60E1F429; Sun,  6 May 2001 16:36:24 -0700 (PDT)
Date: Sun, 6 May 2001 16:36:24 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: "Yoshi.-K" <ykida@yk.rim.or.jp>
Cc: linux-mips@oss.sgi.com
Subject: Re: install in the first hard disk
Message-ID: <20010506163624.A871@foobazco.org>
References: <Pine.SOL.4.31.0105061221330.1956-100000@fury.csh.rit.edu> <MBECLJKHNDHFIBCEPBGLGEMGCKAA.ykida@yk.rim.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <MBECLJKHNDHFIBCEPBGLGEMGCKAA.ykida@yk.rim.or.jp>; from ykida@yk.rim.or.jp on Mon, May 07, 2001 at 08:26:25AM +0900
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 07, 2001 at 08:26:25AM +0900, Yoshi.-K wrote:

> Hello. my name is Yoshi. from Japan.

Hello.

> SGI O2 is used. 
> I will install hardhat-sgi-5.1.tar.gz. 

No, you won't.  No linux kernel in common distribution will even load
on that box.

> will be able to install in the first hard disk. 
> I want to use on one hard disk . Is it possible?

Ask me again in a few days; I've just managed to get linux to see the
disks on that machine.  Check the archives for my post indicating
where my CVS tree is kept; it has as much O2 support as any tree I
know about.  Maybe you'd like to download it and tell me why it
doesn't work.

If this is r10k/r12k O2, you have an even longer wait as I haven't got
such a system and there are extra problems supporting it.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
