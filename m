Received:  by oss.sgi.com id <S42202AbQF3FKW>;
	Thu, 29 Jun 2000 22:10:22 -0700
Received: from rotor.chem.unr.edu ([134.197.32.176]:53001 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S42194AbQF3FKI>;
	Thu, 29 Jun 2000 22:10:08 -0700
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id WAA27108;
	Thu, 29 Jun 2000 22:10:05 -0700
Date:   Thu, 29 Jun 2000 22:10:05 -0700
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     ralf@uni-koblenz.de
Cc:     linux-mips@oss.sgi.com
Subject: [PATCH] microsecond timers for IP22
Message-ID: <20000629221005.A26965@chem.unr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

As we discussed, this patch implements microsecond timers for IP22. It
is against current 2.3 CVS. Note that it is also safe to remove
arch/mips/sgi/indy_timer.c completely with this patch. This looks ok
to me but I'm certainly willing to accept that I've hosed it horribly.
The patch is a bit too large for mail so I've put it at
ftp://ftp.foobazco.org/pub/people/wesolows/mips-linux/testing/timers.diff.

It's interesting to note that on my Indy the first two timer
calibrations differ, triggering the third round, which works. I'm not
quite sure why this is, but the final value is correct.

Lmbench runs more quickly and even properly detects the clock
speed. There is still an unrelated problem in the lat_unix test
however.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
