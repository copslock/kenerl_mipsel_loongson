Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2003 14:34:55 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:11259 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225294AbTDPNey>; Wed, 16 Apr 2003 14:34:54 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA02114;
	Wed, 16 Apr 2003 15:35:30 +0200 (MET DST)
Date: Wed, 16 Apr 2003 15:35:30 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Ashish anand <ashish.anand@inspiretech.com>,
	linux-mips@linux-mips.org
Subject: Re: vmalloc cached space..
In-Reply-To: <20030416135756.B29679@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030416152105.1322C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 16 Apr 2003, Ralf Baechle wrote:

> > 2. i should use vmalloc_prot (size, PAGE_KERNEL_UNCACHED) in umap.c.
> 
> Uncached memory access is rarely necessary and so _extremly_ slow that it
> should be avoided at almost any price.  Maybe you should describe what
> you're trying to achieve, then let's see if there's a better suggestion
> we can make.

 In particular using cached accesses for stores and then doing writebacks
(plus invalidates if necessary) is still faster with WB caches. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
