Received:  by oss.sgi.com id <S305155AbPKKXZT>;
	Thu, 11 Nov 1999 15:25:19 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:20077 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305154AbPKKXZB>;
	Thu, 11 Nov 1999 15:25:01 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA1281153
	for <linuxmips@oss.sgi.com>; Thu, 11 Nov 1999 15:29:56 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA90444
	for linux-list;
	Thu, 11 Nov 1999 14:59:58 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA31131
	for <linux@engr.sgi.com>;
	Thu, 11 Nov 1999 14:59:40 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980305.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA1148100
	for <linux@engr.sgi.com>; Thu, 11 Nov 1999 14:59:28 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
Received: from cacc-27.uni-koblenz.de (cacc-27.uni-koblenz.de [141.26.131.27])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA10684;
	Thu, 11 Nov 1999 23:59:09 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPKKKyh>;
	Thu, 11 Nov 1999 11:54:37 +0100
Date:   Thu, 11 Nov 1999 11:54:37 +0100
From:   Ralf Baechle <ralf@uni-koblenz.de>
To:     Ian Lance Taylor <ian@zembu.com>
Cc:     macro@ds2.pg.gda.pl, binutils@sourceware.cygnus.com, hjl@lucon.org,
        aj@suse.de, flo@rfc822.org, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: Symbol merging for MIPS*/ELF
Message-ID: <19991111115437.A19641@uni-koblenz.de>
References: <Pine.GSO.3.96.991110115952.9984B-100000@delta.ds2> <19991110155546.14856.qmail@daffy.airs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <19991110155546.14856.qmail@daffy.airs.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Nov 10, 1999 at 10:55:46AM -0500, Ian Lance Taylor wrote:

> Those patches were from Kazumoto Kojima
> <kkojima@info.kanagawa-u.ac.jp>, and were intended to support dynamic
> linking for MIPS GNU/Linux.  It may be that we should not be
> generating SHN_MIPS_TEXT and SHN_MIPS_DATA in output files.  This may
> be an Irix specific thing.  I don't know.

I just checked this in the blue books from AT&T.  It defines SHN_MIPS_ACOMMON
(0xff00), SHN_MIPS_SCOMMON (0xff03), SHN_MIPS_SUNDEFINED (0xff04).  0xff01
and 0xff02 are reserved values.  I guess the blue books are equivalent to
ABI version 1.0.

The current MIPS ABI 3.0 then defines SHM_MIPS_TEXT as 0xff01 and
SHM_MIPS_DATA as 0xff02 with the following explanation:

  Symbols defined relative to these two sections are only present after a
  program has been rewritten by the pixie code profiling program.  Such
  rewritten programs are not ABI-compliant.  Symbols defined relative to
  these sections will never occur in an ABI-compliant program.

I cc this to the various Linux/MIPS mailing lists.  A number of the people
who did work on the MIPS ABI and it's implementations are reading there.
Maybe somebody can bring more light into this, especially the reasons for
this SHN_MIPS_* magic.

  Ralf
