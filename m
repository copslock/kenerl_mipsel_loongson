Received:  by oss.sgi.com id <S553691AbQJQPVE>;
	Tue, 17 Oct 2000 08:21:04 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:8710 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S553651AbQJQPUl>;
	Tue, 17 Oct 2000 08:20:41 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id IAA19493;
	Tue, 17 Oct 2000 08:20:08 -0700
Date:   Tue, 17 Oct 2000 08:20:08 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Steve Kranz <skranz@ridgerun.com>
Cc:     Nicu Popovici <octavp@isratech.ro>, linux-mips@oss.sgi.com
Subject: Re: CrossCompiler.
Message-ID: <20001017082008.A19317@chem.unr.edu>
References: <39EC5A4A.DFE3EAD7@isratech.ro> <39EC628D.43431069@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <39EC628D.43431069@ridgerun.com>; from skranz@ridgerun.com on Tue, Oct 17, 2000 at 08:30:37AM -0600
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 17, 2000 at 08:30:37AM -0600, Steve Kranz wrote:

> Try downloading the make-cross... package located at the
> following site:

>   "This is the "standard" toolchain. It may not be
>   perfect, but it at least builds a working kernel and
>   some userland packages. It will be updated as major

Unfortunately the standard toolchain itself is out of date. I would
recommend instead getting current CVS binutils and gcc, and patching
appropriately. With any luck we'll soon have a new standard toolchain.
make-cross, otoh, is still 100% useful; I use it all the time and it
works with arbitrary versions.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
