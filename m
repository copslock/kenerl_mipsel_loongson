Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fACLo4v12581
	for linux-mips-outgoing; Mon, 12 Nov 2001 13:50:04 -0800
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fACLo1012578;
	Mon, 12 Nov 2001 13:50:01 -0800
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fACLnWjV031721;
	Mon, 12 Nov 2001 13:49:32 -0800
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id fACLnU37031713;
	Mon, 12 Nov 2001 13:49:30 -0800
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Mon, 12 Nov 2001 13:49:28 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Jun Sun <jsun@mvista.com>, Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
   linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: [Linux-mips-kernel]Re: i8259.c in big endian
In-Reply-To: <20011112231528.D3949@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.10.10111121349030.26939-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > isa_slot_offset is an obselete garbage.  Can someone do Ralf's a favor and
> > send him a patch to get rid of it (as if he can't do it himself :-0) ?
> 
> Nope.  Somebody could fix isa_{read,write}[bwl] to use isa_slot_offset.
> Right now all the ISA functions are broken.  So in case you're ISA drivers
> seem to work that's the proof that they're broken *evil grin* :-)

I see you fixed this. Thank you :-)  
