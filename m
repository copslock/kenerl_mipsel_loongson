Received:  by oss.sgi.com id <S305163AbQBQQiI>;
	Thu, 17 Feb 2000 08:38:08 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:14152 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQBQQhu>;
	Thu, 17 Feb 2000 08:37:50 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA02491; Thu, 17 Feb 2000 08:33:19 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA90827
	for linux-list;
	Thu, 17 Feb 2000 08:27:12 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA16427
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 17 Feb 2000 08:27:10 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA03737
	for <linux@cthulhu.engr.sgi.com>; Thu, 17 Feb 2000 08:27:13 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-27.uni-koblenz.de (cacc-27.uni-koblenz.de [141.26.131.27])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id RAA24549;
	Thu, 17 Feb 2000 17:27:05 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407900AbQBQNZ3>;
	Thu, 17 Feb 2000 14:25:29 +0100
Date:   Thu, 17 Feb 2000 14:25:29 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Cc:     "Gleb O. Raiko" <raiko@niisi.msk.ru>, linux-mips@fnet.fr,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: -fno-strict-aliasing problem in the latest 2.3
Message-ID: <20000217142529.A5423@uni-koblenz.de>
References: <38A91E19.CE7A9890@niisi.msk.ru> <XFMail.000216190319.Harald.Koerfgen@home.ivm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <XFMail.000216190319.Harald.Koerfgen@home.ivm.de>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Feb 16, 2000 at 07:03:19PM +0100, Harald Koerfgen wrote:

> On 15-Feb-00 Gleb O. Raiko wrote:
> > There is a problem with the way main Makefile determines whether the
> > compiler suports -fno-strict-aliasing. Namely, Makefile blindly gets $CC
> > and tries to feed this option to it. Unfortunately, we set CC to proper
> > mips[el]-linux-gcc later in arch/mips/Makefile, so the main Makefile
> > just checks against native gcc. On RH6.1 with latest cross tool rpms
> > installed, I get cc1: Invalid option `-fno-strict-aliasing' during
> > comppilation, obviously.
> 
> I am not exactly shure if it has ill side effects or if this may not be wanted
> for some reason, but the attached patch fixes that for me.
> 
> OK to commit?

Yes, my solution is identical, so who commits first commits first :)

  Ralf
