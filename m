Received:  by oss.sgi.com id <S42243AbQGRECO>;
	Mon, 17 Jul 2000 21:02:14 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:62471 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42245AbQGREBf>;
	Mon, 17 Jul 2000 21:01:35 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id VAA25385;
	Mon, 17 Jul 2000 21:00:35 -0700
Date:   Mon, 17 Jul 2000 21:00:35 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     wrasman@cs.utk.edu
Cc:     linux-mips@oss.sgi.com
Subject: Re: Okay, lost
Message-ID: <20000717210035.B25185@chem.unr.edu>
References: <20000717205303.A14220@enchanted.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20000717205303.A14220@enchanted.net>; from awrasman@enchanted.net on Mon, Jul 17, 2000 at 08:53:03PM -0500
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jul 17, 2000 at 08:53:03PM -0500, A. Wrasman wrote:

> Okay, I can't seem to get any of the pre-compiled linux kernels  after the 2.2.14 one on oss.sgi.com to boot on my Indy.
> I get this type of error:
> Exception: <vector=Normal>

I've no idea what kernels you're using. Try
/pub/linux/mips/mips-linux/simple/kernels/vmlinux-000717-38400 if you
want to try a post-2.2 kernel. It really should work.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
