Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5A3wq211009
	for linux-mips-outgoing; Sat, 9 Jun 2001 20:58:52 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5A3wqV11006
	for <linux-mips@oss.sgi.com>; Sat, 9 Jun 2001 20:58:52 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP id 5F3D63E90
	for <linux-mips@oss.sgi.com>; Sat,  9 Jun 2001 20:55:39 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id 7F23114181; Sat,  9 Jun 2001 20:56:42 -0700 (PDT)
Date: Sat, 9 Jun 2001 20:56:41 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: linux-mips@oss.sgi.com
Subject: gcc 3.0 sig11
Message-ID: <20010609205641.A27425@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

For the past few weeks (0422 is ok, 0528 and 0609 are not) gcc built
for mips-linux takes sig11 during build.  Specifically at
/s/crossdev-build/src/gcc-3.0-20010609/gcc/unwind-dw2-fde.c:1001:
Internal error: Segmentation fault.

I know at least one other person has seen this.  Anybody produced a
patch or done any debugging on this?

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
