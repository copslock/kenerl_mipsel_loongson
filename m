Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 18:19:30 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:19409 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225425AbTIRRT2>; Thu, 18 Sep 2003 18:19:28 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id TAA21725;
	Thu, 18 Sep 2003 19:19:22 +0200 (MET DST)
X-Authentication-Warning: delta.ds2.pg.gda.pl: macro owned process doing -bs
Date: Thu, 18 Sep 2003 19:19:21 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Daniel Jacobowitz <dan@debian.org>
cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: ddb5477 fixes for 2.6
In-Reply-To: <20030918170642.GA22753@nevyn.them.org>
Message-ID: <Pine.GSO.3.96.1030918191604.20533C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 18 Sep 2003, Daniel Jacobowitz wrote:

> >  Is it OK for other PCI systems?
> 
> Yes, I think so.  Those two functions seem to have migrated in from
> pci-hplj.c; they can't possibly compile, since they use constants only
> defined in that file.

 Then the snippet should probably get removed altogether.

> >  Why do you want these suffixes?  They don't work for assembly sources.
> 
> Because otherwise uses of XKPHYS in a 32-bit kernel generate noisy
> warnings.  I don't remember where it was offhand.  Wrap it in
> __ASSEMBLY__ if you like.

 Hmm, but is there any use for XKPHYS, etc. in a 32-bit kernel at all? 
The address cannot effectively be used anyway. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
