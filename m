Received:  by oss.sgi.com id <S42251AbQGXWsb>;
	Mon, 24 Jul 2000 15:48:31 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:28933 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42245AbQGXWsC>;
	Mon, 24 Jul 2000 15:48:02 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id PAA16128;
	Mon, 24 Jul 2000 15:47:24 -0700
Date:   Mon, 24 Jul 2000 15:47:24 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Diablero <poinde_t@epita.fr>
Cc:     linux-mips@oss.sgi.com
Subject: Re: I can't cross compile kernel
Message-ID: <20000724154724.C14657@chem.unr.edu>
References: <20000725000108.A12611@purple42.epx.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20000725000108.A12611@purple42.epx.epita.fr>; from poinde_t@epita.fr on Tue, Jul 25, 2000 at 12:01:08AM +0200
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jul 25, 2000 at 12:01:08AM +0200, Diablero wrote:

> I have tried to cross-compile kernel but I always had the same errors.
> (last kernel from cvs - oss.sgi.com)

A few questions: what compiler version? What binutils version? Could
you please send me your .config? This doesn't happen for me with gcc,
binutils, and linux current CVS. If you are compiling with current CVS
gcc, you will need some of my patches as well, though they don't
address this problem.

Also, I now recommend that people wanting to build a cross-compiler by
a recipe use my make-cross script instead of typing everything
manually. It's available on oss.sgi.com. It's hackerware, but so are
cross-compilers.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
