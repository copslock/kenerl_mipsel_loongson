Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Jun 2003 00:23:32 +0100 (BST)
Received: from p508B7C8B.dip.t-dialin.net ([IPv6:::ffff:80.139.124.139]:50133
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225196AbTFMXX3>; Sat, 14 Jun 2003 00:23:29 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5DNNHbY023835;
	Fri, 13 Jun 2003 16:23:17 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5DNNFnE023834;
	Sat, 14 Jun 2003 01:23:15 +0200
Date: Sat, 14 Jun 2003 01:23:15 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: Dan Malek <dan@embeddededge.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20030613232315.GB22949@linux-mips.org>
References: <Pine.GSO.3.96.1030613221736.20506C-100000@delta.ds2.pg.gda.pl> <3EEA3B5C.2000201@embeddededge.com> <20030613144425.E14458@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613144425.E14458@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 13, 2003 at 02:44:25PM -0700, Jun Sun wrote:

> Congradualtions!  You will have roughly about 950 files under that
> directory.
> 
> Even with good effort to combine files and promote sharing, I think
> you will still have quite some.
> 
> I think having another directory layer under arch/mips/platforms
> shouldn't be too bad, (although I like arch/mips/machines better).  
> 
> We can use some scheme like Geert was proposing, i.e., named after
> boards and chipsets.  Hack, I think even naming after board vendor
> is acceptable.

Chipsets are a too coarse granularity to structure things these days.
Modern chipsets integrate a large number of logically independant
functionality.  Frequently such chipsets are ASICs which consist of
various logically independant functions licensed from several sources
and possibly multiple chipset / ASICs are being used in a single
system.  The world just isn't that simple ...

  Ralf
