Received:  by oss.sgi.com id <S553852AbRBXCBw>;
	Fri, 23 Feb 2001 18:01:52 -0800
Received: from [203.101.127.117] ([203.101.127.117]:39040 "EHLO eris.xware.cx")
	by oss.sgi.com with ESMTP id <S553746AbRBXCBf>;
	Fri, 23 Feb 2001 18:01:35 -0800
Received: (from chris@localhost)
	by eris.xware.cx (8.11.0/8.11.0) id f1O228H21210
	for linux-mips@oss.sgi.com; Sat, 24 Feb 2001 13:02:08 +1100
Date:   Sat, 24 Feb 2001 13:02:08 +1100
From:   Crossfire <xfire@xware.cx>
To:     linux-mips@oss.sgi.com
Subject: troubles with Indy
Message-ID: <20010224130208.B21094@eris.xware.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Face: 1_cwV#-Eyv`RXe|JgLID]fWI-xnk962I)$LufLo.W'Y;S-B<P]U'$*^!=\RU3]^If:nE;RO
 8tb)CB{E"ErEo7Qv-%^j.tFbto}`2ClPpS5yXT6[Ig|o?iJg1vK7;:XQP#F>8jl#<,n-@'~7WHtl;J
 DJ&RiZA
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi All.

I've just acquired a R4600 Indy which I've proceed to attempt to seed
a debian installation on.

I've crosscompiled a linux-2.4.1 kernel from CVS [after a little code
patching] to find that the kernel boots fine, and can do most things,
except run tar, and a few other binaries from the debian image.

If I use the linux-2.4.1-test2 kernel from test, I can run tar, but it
can't read filesystems correctly, and the init process fails.  Also,
other operations become extremely unreliable.

Is there a 'known working' kernel image floating about somewhere? or
are things generally at this silghtly flaky point?

Or is something else completely different to blame?

TIA

C.
-- 
--==============================================--
  Crossfire      | This email was brought to you
  xfire@xware.cx | on 100% Recycled Electrons
--==============================================--
