Received:  by oss.sgi.com id <S305256AbQCaVB7>;
	Fri, 31 Mar 2000 13:01:59 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:9326 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305239AbQCaVBb>;
	Fri, 31 Mar 2000 13:01:31 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA20139; Fri, 31 Mar 2000 12:56:49 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id NAA49833; Fri, 31 Mar 2000 13:00:59 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA96243
	for linux-list;
	Fri, 31 Mar 2000 12:48:24 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA87384
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 31 Mar 2000 12:48:22 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAB05960
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 12:48:16 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6E6A37F5; Fri, 31 Mar 2000 22:48:06 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 8C07F8FC3; Fri, 31 Mar 2000 22:38:16 +0200 (CEST)
Date:   Fri, 31 Mar 2000 22:38:16 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Mike Hill <mikehill@hgeng.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: kernel for indigo2
Message-ID: <20000331223816.A25241@paradigm.rfc822.org>
References: <E138DB347D10D3119C630008C79F5DEC2B9D6B@BART>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <E138DB347D10D3119C630008C79F5DEC2B9D6B@BART>; from Mike Hill on Fri, Mar 31, 2000 at 02:21:56PM -0500
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Mar 31, 2000 at 02:21:56PM -0500, Mike Hill wrote:
> Hi Florian,
> 
> Is the 2.2 CVS branch still accessible?  I had a measure of success with
> 2.2.13 and 2.3.21 cross-compiled circa December.  I'd have to test them
> again to tell you which, but with at least one of them, I can boot into a
> working system.  The tricky bit is by the time it's finished booting, the
> serial console output is lost; at this point I'd like to be able to telnet
> in, but my setup.rpm (from hardhat) lacks the necessary securettys.
> 
> I can send you something if you need it.

If you have a binary kernel image with nfsroot that would be great - I could
begin installing this machine - You could dump it into
ftp://ftp.rfc822.org/incoming - Or otherwise a 2.3.21 source tree - I am 
not having much luck getting that relase/tag but this might be due to
my little experience with cvs ...

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
