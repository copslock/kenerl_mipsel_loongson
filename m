Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Aug 2007 21:00:11 +0100 (BST)
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:14313 "EHLO
	relay.sgi.com") by ftp.linux-mips.org with ESMTP id S20021575AbXHOUAI
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Aug 2007 21:00:08 +0100
Received: from schroedinger.engr.sgi.com (schroedinger.engr.sgi.com [150.166.1.51])
	by netops-testserver-3.corp.sgi.com (Postfix) with ESMTP id 21A57908A7;
	Wed, 15 Aug 2007 12:59:32 -0700 (PDT)
Received: from clameter (helo=localhost)
	by schroedinger.engr.sgi.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1ILP1g-0001ud-00; Wed, 15 Aug 2007 12:59:32 -0700
Date:	Wed, 15 Aug 2007 12:59:32 -0700 (PDT)
From:	Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To:	Andi Kleen <ak@suse.de>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mel Gorman <mel@skynet.ie>, Lee.Schermerhorn@hp.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] Embed zone_id information within the zonelist->zones
 pointer
In-Reply-To: <20070815125920.GD3406@bingen.suse.de>
Message-ID: <Pine.LNX.4.64.0708151259230.7326@schroedinger.engr.sgi.com>
References: <20070813225841.GG3406@bingen.suse.de>
 <Pine.LNX.4.64.0708131506030.28502@schroedinger.engr.sgi.com>
 <20070813230801.GH3406@bingen.suse.de> <Pine.LNX.4.64.0708131536340.29946@schroedinger.engr.sgi.com>
 <20070813234322.GJ3406@bingen.suse.de> <Pine.LNX.4.64.0708131553050.30626@schroedinger.engr.sgi.com>
 <20070814000041.GL3406@bingen.suse.de> <20070814002223.2d8d42c5@the-village.bc.nu>
 <20070814001441.GN3406@bingen.suse.de> <20070815113749.GA5862@linux-mips.org>
 <20070815125920.GD3406@bingen.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <clameter@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clameter@sgi.com
Precedence: bulk
X-list: linux-mips

On Wed, 15 Aug 2007, Andi Kleen wrote:

> BTW I suspect this is true for some other GFP_DMA usages too.
> Some driver writers seem to confuse it with the PCI DMA
> APIs or believe it is always needed for them.

See especially ARM.
