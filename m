Received:  by oss.sgi.com id <S305157AbQCREbB>;
	Fri, 17 Mar 2000 20:31:01 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:9267 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCREaa>; Fri, 17 Mar 2000 20:30:30 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id UAA09161; Fri, 17 Mar 2000 20:33:56 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA36491
	for linux-list;
	Fri, 17 Mar 2000 20:09:24 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA05014;
	Fri, 17 Mar 2000 20:09:20 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from dial-2-116.cwb.matrix.com.br (dial-2-116.cwb.matrix.com.br [200.202.9.116]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA00820; Fri, 17 Mar 2000 20:08:55 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407911AbQCREIC>;
	Sat, 18 Mar 2000 01:08:02 -0300
Date:   Sat, 18 Mar 2000 01:08:01 -0300
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     "William J. Earl" <wje@cthulhu.engr.sgi.com>,
        SGI Linux Alias <linux@cthulhu.engr.sgi.com>
Subject: Re: Include coherency problem, sigaction and otherwise
Message-ID: <20000318010801.B811@uni-koblenz.de>
References: <000e01bf903e$a0e864a0$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <000e01bf903e$a0e864a0$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Mar 17, 2000 at 07:28:38PM +0100, Kevin D. Kissell wrote:

> > > I have the impresson that the /usr/include stuff in the 
> > > "Hard Hat" distribution for MIPS is keyed to a 2.0.x kernel, 
> > > and that an update of /usr/include (as opposed to a downgrade 
> > > of the kernel headers) may be in order.
> ...
> >
> >      As near as I can tell, at least for glibc-2.1.1-7, there
> >is not machine-dependent <bits/sigaction.h> for mips, so the
> >generic one is used, and the definitions are incompatible with the
> >MIPS ABI.  The Linux kernel, on the other hand, is compatible with the
> >MIPS ABI.  The cure is to supply a MIPS-specific <bits/sigaction.h>.
> 
> It's worse than that - the "Hard Hat" 5.1 distribution that serves
> as the reference userland for most SGI/MIPS/Linux platforms
> doesn't even have a /usr/include/bits directory, which seems
> to have been a more recent invention.

The whole inconsistence was a stupid accident.  Since apparently only very
little software was affected negativly (read: no known problems) we didn't
try to come up with some genious compatibility hacks but just fixed the
definitions the hard way.  Current glibc snapshots and Linux kernels have
been fixed to use the same definitions.  If not, mail me a brown paperbag.

The bits/ subdirectory was introduced for glibc 2.1.

  Ralf
