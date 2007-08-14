Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2007 20:30:57 +0100 (BST)
Received: from cantor2.suse.de ([195.135.220.15]:3047 "EHLO mx2.suse.de")
	by ftp.linux-mips.org with ESMTP id S20023290AbXHNTat (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2007 20:30:49 +0100
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5349B218CA;
	Tue, 14 Aug 2007 21:29:42 +0200 (CEST)
Date:	Tue, 14 Aug 2007 22:23:51 +0200
From:	Andi Kleen <ak@suse.de>
To:	Andy Isaacson <adi@hexapodia.org>
Cc:	Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Lameter <clameter@sgi.com>,
	Mel Gorman <mel@skynet.ie>, Lee.Schermerhorn@hp.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] Embed zone_id information within the zonelist->zones pointer
Message-ID: <20070814202350.GT3406@bingen.suse.de>
References: <20070813225841.GG3406@bingen.suse.de> <Pine.LNX.4.64.0708131506030.28502@schroedinger.engr.sgi.com> <20070813230801.GH3406@bingen.suse.de> <Pine.LNX.4.64.0708131536340.29946@schroedinger.engr.sgi.com> <20070813234322.GJ3406@bingen.suse.de> <Pine.LNX.4.64.0708131553050.30626@schroedinger.engr.sgi.com> <20070814000041.GL3406@bingen.suse.de> <20070814002223.2d8d42c5@the-village.bc.nu> <20070814001441.GN3406@bingen.suse.de> <20070814191158.GB14093@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070814191158.GB14093@hexapodia.org>
Return-Path: <ak@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ak@suse.de
Precedence: bulk
X-list: linux-mips

> bcm43xx hardware does show up on low-end MIPS boxes (wrt54g anybody?)
> that would be sorely hurt by excess copies.

Lowend boxes don't have more than 1GB of RAM. With <= 1GB you don't
need to copy on bcm43xx.

-Andi
