Received:  by oss.sgi.com id <S305157AbQCQSgI>;
	Fri, 17 Mar 2000 10:36:08 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:7545 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCQSfh>; Fri, 17 Mar 2000 10:35:37 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA05715; Fri, 17 Mar 2000 10:39:02 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA24444
	for linux-list;
	Fri, 17 Mar 2000 10:25:20 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA76791;
	Fri, 17 Mar 2000 10:25:17 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA00351; Fri, 17 Mar 2000 10:25:17 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id KAA12859;
	Fri, 17 Mar 2000 10:25:15 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id KAA15321;
	Fri, 17 Mar 2000 10:25:14 -0800 (PST)
Message-ID: <000e01bf903e$a0e864a0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "William J. Earl" <wje@cthulhu.engr.sgi.com>
Cc:     "SGI Linux Alias" <linux@cthulhu.engr.sgi.com>
Subject: Re: Include coherency problem, sigaction and otherwise
Date:   Fri, 17 Mar 2000 19:28:38 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

William J. Earl writes:
>Kevin D. Kissell writes:
...
> > I have the impresson that the /usr/include stuff in the 
> > "Hard Hat" distribution for MIPS is keyed to a 2.0.x kernel, 
> > and that an update of /usr/include (as opposed to a downgrade 
> > of the kernel headers) may be in order.
...
>
>      As near as I can tell, at least for glibc-2.1.1-7, there
>is not machine-dependent <bits/sigaction.h> for mips, so the
>generic one is used, and the definitions are incompatible with the
>MIPS ABI.  The Linux kernel, on the other hand, is compatible with the
>MIPS ABI.  The cure is to supply a MIPS-specific <bits/sigaction.h>.

It's worse than that - the "Hard Hat" 5.1 distribution that serves
as the reference userland for most SGI/MIPS/Linux platforms
doesn't even have a /usr/include/bits directory, which seems
to have been a more recent invention.

            Regards,

            Kevin K.
