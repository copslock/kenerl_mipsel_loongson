Received:  by oss.sgi.com id <S305163AbQEPO2Y>;
	Tue, 16 May 2000 14:28:24 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:33093 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305161AbQEPO2H>;
	Tue, 16 May 2000 14:28:07 +0000
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA03536; Tue, 16 May 2000 07:23:16 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA74983
	for linux-list;
	Tue, 16 May 2000 07:19:14 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA84729
	for <linux@engr.sgi.com>;
	Tue, 16 May 2000 07:19:13 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA03133
	for <linux@engr.sgi.com>; Tue, 16 May 2000 07:19:11 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-10.uni-koblenz.de (cacc-10.uni-koblenz.de [141.26.131.10])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id QAA18261;
	Tue, 16 May 2000 16:19:12 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1403838AbQEPLXO>;
	Tue, 16 May 2000 13:23:14 +0200
Date:   Tue, 16 May 2000 13:23:14 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: Re: dumb question - where is the latest linux/mips kernel source?
Message-ID: <20000516132314.B4561@uni-koblenz.de>
References: <39209F64.83638479@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39209F64.83638479@mvista.com>; from jsun@mvista.com on Mon, May 15, 2000 at 06:07:49PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, May 15, 2000 at 06:07:49PM -0700, Jun Sun wrote:

> I found 
> ftp://oss.sgi.com/pub/linux/mips/src/kernel/v2.3/linux-19991209.tar.gz,
> but that is version 2.3.21.  Have all the patches been taken into the
> latest standard linux release?  Just to make sure ...

We only occasionally generate snapshots.  If you want a current source
tree then please see the MIPS FAQ at http://oss.sgi.com/mips/ for how to
use anonymous CVS.  CVS is currently at version 2.3.99-pre8.

  Ralf
