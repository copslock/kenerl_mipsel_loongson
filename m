Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1Q6TXG02692
	for linux-mips-outgoing; Mon, 25 Feb 2002 22:29:33 -0800
Received: from chmls18.ne.ipsvc.net (chmls18.ne.ipsvc.net [24.147.1.153])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1Q6TS902688;
	Mon, 25 Feb 2002 22:29:28 -0800
Received: from localhost (h00a0cc39f081.ne.mediaone.net [65.96.250.215])
	by chmls18.ne.ipsvc.net (8.11.6/8.11.6) with ESMTP id g1Q5Sx806553;
	Tue, 26 Feb 2002 00:29:00 -0500 (EST)
Date: Tue, 26 Feb 2002 00:28:52 -0500
Subject: Re: Problems compiling . soft-float
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: Jay Carlson <nop@nop.com>, mad-dev@lists.mars.org,
   Carlo Agostini <carlo.agostini@yacme.com>, linux-mips@oss.sgi.com
To: Ralf Baechle <ralf@oss.sgi.com>
From: Jay Carlson <nop@nop.com>
In-Reply-To: <20020226060236.A5293@dea.linux-mips.net>
Message-Id: <B843E153-2A79-11D6-AB38-0030658AB11E@nop.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.481)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On Tuesday, February 26, 2002, at 12:02 AM, Ralf Baechle wrote:

> Something for the binutils to-do list - ld should make mixing hard-fp
> and soft-fp binaries impossible.

Agreed.  So do we need a special flag/directive for gas to say "I'm 
using soft float"?

Jay
