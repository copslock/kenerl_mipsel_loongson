Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8R3QEb04204
	for linux-mips-outgoing; Wed, 26 Sep 2001 20:26:14 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8R3QDD04200
	for <linux-mips@oss.sgi.com>; Wed, 26 Sep 2001 20:26:13 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id E497B125C6; Wed, 26 Sep 2001 20:26:10 -0700 (PDT)
Date: Wed, 26 Sep 2001 20:26:10 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Jim Paris <jim@jtan.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: test machines; illegal instructions
Message-ID: <20010926202610.B7962@lucon.org>
References: <20010926221223.A17628@neurosis.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010926221223.A17628@neurosis.mit.edu>; from jim@jtan.com on Wed, Sep 26, 2001 at 10:12:23PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Sep 26, 2001 at 10:12:23PM -0400, Jim Paris wrote:
> seen anything similar?  It's quite possibly a buggy cross compiler
> just generating buggy binaries (GCC 3.0.1 on the PC, with glibc 2.2.4)
> but I thought others were using this compiler just fine.

I won't recommend gcc 3.0.1 for mips. My RedHat 7.1 port has everyting
you need for cross/native compiling.


H.J.
