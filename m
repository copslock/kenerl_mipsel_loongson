Received:  by oss.sgi.com id <S553967AbQKMHT2>;
	Sun, 12 Nov 2000 23:19:28 -0800
Received: from rotor.chem.unr.edu ([134.197.32.176]:32007 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S553961AbQKMHTN>;
	Sun, 12 Nov 2000 23:19:13 -0800
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id XAA16929;
	Sun, 12 Nov 2000 23:16:38 -0800
Date:   Sun, 12 Nov 2000 23:16:38 -0800
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Zheng Baojian <bjzheng@ict.ac.cn>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Can you help me?
Message-ID: <20001112231638.A16609@chem.unr.edu>
References: <002801c04d1b$c1adc320$a727e29f@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <002801c04d1b$c1adc320$a727e29f@ict.ac.cn>; from bjzheng@ict.ac.cn on Mon, Nov 13, 2000 at 10:45:17AM +0800
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Nov 13, 2000 at 10:45:17AM +0800, Zheng Baojian wrote:

>      I'm a Chinese student,i want to run linux on SGI O2 workstation.
> I see that O2 not support linux now on your web,can you tell me the
> reason?As series of SGI workstations,O2,Indy,Onyx ,Origin,they have same
> architecture,same cpu,why others support linux,O2 not support.

Harald Koerfgen and I (at least) have done some work on O2 and I can
verify that it has at one point booted to userland (I no longer have
the machine and thus do not know the status).  To say that an O2 has
the same architecture as the other machines you mention, however, is
an oversimplification at best; these machines have numerous
differences (no two use the same bus type/controller), and afaik Onyx
is not and never has been supported.  In fact, these machines don't
even have the same CPUs; the r5ks used in O2 have different caches
than those used in Indys, and the r10k O2s are another mess
altogether.  Welcome to the wonderful world of MIPS; 86 million
machines, no two remotely similar.

The NetBSD people have also done some work in this area.  Between
their work, the Irix headers - look but don't copy, and the existing
Linux work - for which you might ask Harald if you are interested in
improving it - it's possible to get a reasonably working kernel for
r5k O2.  More advanced work such as accelerated X and a driver for the
built-in ethernet will most likely require additional documentation.

The short answer, of course, is that nobody has ever had concurrent
interest, free time, and access to hardware for a sufficient length of
time.

Please use plain text in the future.  I recommend non-Microsoft mailers.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
