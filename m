Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6HKBqj30493
	for linux-mips-outgoing; Tue, 17 Jul 2001 13:11:52 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6HKBpV30490
	for <linux-mips@oss.sgi.com>; Tue, 17 Jul 2001 13:11:51 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 555D1125BC; Tue, 17 Jul 2001 13:11:46 -0700 (PDT)
Date: Tue, 17 Jul 2001 13:11:46 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ilya Volynets <ilya@theIlya.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Updates on RedHat 7.1/mips
Message-ID: <20010717131146.A24907@lucon.org>
References: <3B4573B8.9F89022B@mips.com> <20010717125027.A22672@nevyn.them.org> <20010717125718.A24725@lucon.org> <01071713090011.04620@gateway>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01071713090011.04620@gateway>; from ilya@theIlya.com on Tue, Jul 17, 2001 at 01:09:00PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 17, 2001 at 01:09:00PM -0700, Ilya Volynets wrote:
> 
> I was working on it a while ago, and here are few pointers:
> Some tools have to be run natively (i.e. xkbcomp), but also need to
> be installed on target. I din't find a rule that does both. I think new
> rule is needed.

I am aware of those. I want to delay it as much as I can.

> 
> gcc-3.0 crashes when compiling some parts of Xserver and Xlib,
> with very obscure bug. Minimal test case I came up with is
> ~45(!) lines long. Keith filed report to gcc team on my behalf,
> but there seems to be no responce. I do not know if your
> gcc has same problem, but someone mentioned similar problem
> with 2.9x.y series on this list not so long ago.
> 

Don't bother with gcc-3.0. I won't use it myself for building X.


H.J.
