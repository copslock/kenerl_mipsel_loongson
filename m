Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DFAnM08600
	for linux-mips-outgoing; Thu, 13 Sep 2001 08:10:49 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DFAke08596
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 08:10:46 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 7DD10125C3; Thu, 13 Sep 2001 08:10:40 -0700 (PDT)
Date: Thu, 13 Sep 2001 08:10:40 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Kjeld Borch Egevang <kjelde@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Error in gcc version 2.96 20000731
Message-ID: <20010913081040.A24910@lucon.org>
References: <3BA0BF6E.2010300@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA0BF6E.2010300@mips.com>; from kjelde@mips.com on Thu, Sep 13, 2001 at 04:15:10PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Sep 13, 2001 at 04:15:10PM +0200, Kjeld Borch Egevang wrote:
> Hi all.
> 
> I discovered an optimization error in the current gcc for MIPS.
> 
> When I compile the code below with -O2 it clears the code-field just 
> after setting it. The instructions are mixed up. It works fine with -O1 
> and -O0.
> 
> If the "//" is removed in front of the first printf, it works too.
> 

The code isn't ISO C. You cannot declare something as short and then
access it as int. On x86:

# gcc alias.c -O
put_code after, code=5 5
gen_rtx, code=5
# gcc alias.c -O2
put_code after, code=5 0
gen_rtx, code=0

On mips,

# gcc alias.c -O
put_code after, code=5 5
gen_rtx, code=5
# gcc alias.c -O2
put_code after, code=5 5
gen_rtx, code=0

You can fix the code or add -fno-strict-aliasing

# gcc alias.c -O2 -fno-strict-aliasing
put_code after, code=5 5
gen_rtx, code=5



H.J.
