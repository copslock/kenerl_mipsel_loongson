Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3U6QZt30036
	for linux-mips-outgoing; Sun, 29 Apr 2001 23:26:35 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3U6QYM30033
	for <linux-mips@oss.sgi.com>; Sun, 29 Apr 2001 23:26:34 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id 3B713F1A9; Sun, 29 Apr 2001 23:25:44 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id B455A1F42A; Sun, 29 Apr 2001 23:26:15 -0700 (PDT)
Date: Sun, 29 Apr 2001 23:26:15 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Deepak Shenoy <deepak@ishoni.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: user accessing kernel physical pages?
Message-ID: <20010429232615.B5595@foobazco.org>
References: <E0FDC90A9031D511915D00C04F0CCD256765@leonoid.in.ishoni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E0FDC90A9031D511915D00C04F0CCD256765@leonoid.in.ishoni.com>; from deepak@ishoni.com on Mon, Apr 30, 2001 at 11:35:00AM +0530
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Apr 30, 2001 at 11:35:00AM +0530, Deepak Shenoy wrote:

> I am new to MIPS MMU architecture. I wanted to know if a user application be
> able to access physical pages of the kerenel; if appropriate page table
> entries are setup?. Is it possible?

mem(4), mmap(2), rtfm(0)

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
