Received:  by oss.sgi.com id <S42228AbQGJOlS>;
	Mon, 10 Jul 2000 07:41:18 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:46340 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42185AbQGJOlE>;
	Mon, 10 Jul 2000 07:41:04 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id HAA21365;
	Mon, 10 Jul 2000 07:41:01 -0700
Date:   Mon, 10 Jul 2000 07:41:01 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     linux-mips@oss.sgi.com
Subject: Re: GDB question.
Message-ID: <20000710074101.A21121@chem.unr.edu>
References: <20000707083452.A9987@chem.unr.edu> <Pine.SGI.4.10.10007100957010.13038-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.SGI.4.10.10007100957010.13038-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Mon, Jul 10, 2000 at 10:00:13AM -0300
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jul 10, 2000 at 10:00:13AM -0300, J. Scott Kasten wrote:

> Was not able to native compile any GDB from 4.16 to 5.0.  The ./configure
> script always complains "arch not supported".  It looks like I'll have to
> try the version at the URL you mention above.
> 
> Note: detected arch was "mips-unknown-linux-gnu" which would seem correct.

For 4.1x you should get it from CVS on oss.sgi.com. For 5.0 you will
need the Maciej patches (see mailing list archives); you can get them
at
ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/userland-0.2a/src/gdb*,
or originals at http://www.ds2.pg.gda.pl/~macro/.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
