Received:  by oss.sgi.com id <S42223AbQGYQMI>;
	Tue, 25 Jul 2000 09:12:08 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:12551 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42210AbQGYQLp>;
	Tue, 25 Jul 2000 09:11:45 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id JAA04293;
	Tue, 25 Jul 2000 09:11:08 -0700
Date:   Tue, 25 Jul 2000 09:11:08 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Diablero <poinde_t@epita.fr>
Cc:     linux-mips@oss.sgi.com
Subject: Re: I can't cross compile kernel
Message-ID: <20000725091108.A3455@chem.unr.edu>
References: <20000725000108.A12611@purple42.epx.epita.fr> <20000724154724.C14657@chem.unr.edu> <20000725011604.A13576@purple42.epx.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20000725011604.A13576@purple42.epx.epita.fr>; from poinde_t@epita.fr on Tue, Jul 25, 2000 at 01:16:04AM +0200
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jul 25, 2000 at 01:16:04AM +0200, Diablero wrote:

> I use binutils 2.10 and gcc 2.95.2
> I attach my .config

With a current toolchain, I can't duplicate your problem. There is a
bug in the sonic.c driver that causes compilation to abort (it's not
been softnetted) but I don't see the error you do. At a glance, it
looks like the problem is with the definition of u_quad_t. You might
try running the file in question through the preprocessor to see
what's going on.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
