Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA15877 for <linux-archive@neteng.engr.sgi.com>; Tue, 27 Oct 1998 07:36:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA79477
	for linux-list;
	Tue, 27 Oct 1998 07:36:38 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA30065
	for <linux@engr.sgi.com>;
	Tue, 27 Oct 1998 07:36:37 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA03004
	for <linux@engr.sgi.com>; Tue, 27 Oct 1998 07:36:35 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-15.uni-koblenz.de [141.26.249.15])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id QAA17933
	for <linux@engr.sgi.com>; Tue, 27 Oct 1998 16:36:32 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id FAA07441;
	Tue, 27 Oct 1998 05:54:34 +0100
Message-ID: <19981027055434.H5892@uni-koblenz.de>
Date: Tue, 27 Oct 1998 05:54:34 +0100
From: ralf@uni-koblenz.de
To: Eric Jorgensen <alhaz@xmission.com>, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu, linux@cthulhu.engr.sgi.com
Subject: Re: MIPS R3230?
References: <199810262335.QAA12729@harmony.village.org> <36350DB4.3CC01730@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <36350DB4.3CC01730@xmission.com>; from Eric Jorgensen on Mon, Oct 26, 1998 at 05:03:00PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Oct 26, 1998 at 05:03:00PM -0700, Eric Jorgensen wrote:

> 	On the other hand, I don't have a complete distribution of RISCos on
> either of them. They both mounted most of the /usr tree (or whatever it
> is on riscos) via NFS, some machine they can't talk to anymore. 

Linux and related software have become a tomb stone for several old network
stacks and apps which crash, lockup or do other funnies.

The bad things is that these old MIPS machines need to boot from network
via a MIPS proprietary protocol named BFS of which no implementation is
floating around anymore.  Except David Monroe's implementation, that is.
If anybody still got his bfsd 1.01 source archive around, please drop me
a note.

  Ralf
