Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g483FHwJ019959
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 20:15:17 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g483FHex019957
	for linux-mips-outgoing; Tue, 7 May 2002 20:15:17 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g483FEwJ019954
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 20:15:14 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g483Gbs13784;
	Tue, 7 May 2002 20:16:37 -0700
Date: Tue, 7 May 2002 20:16:37 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: what is the right behavior of copy_to_user(0x0, ..., ...)?
Message-ID: <20020507201637.B13717@dea.linux-mips.net>
References: <3CD3052B.1050400@mvista.com> <20020503162337.A27366@dea.linux-mips.net> <3CD32044.9040109@mvista.com> <20020503184000.A1238@dea.linux-mips.net> <3CD6C8EA.9060807@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3CD6C8EA.9060807@mvista.com>; from jsun@mvista.com on Mon, May 06, 2002 at 11:18:18AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 06, 2002 at 11:18:18AM -0700, Jun Sun wrote:

> It would help if not for the gross typo. :-)  See the attachment.

Never noticed that because I already had a slightly more elegant solution
in my tree.  It's already in CVS, check it out.

  Ralf
