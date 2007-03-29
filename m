Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2007 23:06:54 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:12191 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021389AbXC2WGx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Mar 2007 23:06:53 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2TM6i23029728;
	Thu, 29 Mar 2007 23:06:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2TM6fHW029727;
	Thu, 29 Mar 2007 23:06:41 +0100
Date:	Thu, 29 Mar 2007 23:06:41 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mark Mason <mmason@upwardaccess.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] updated Sibyte headers
Message-ID: <20070329220641.GA27724@linux-mips.org>
References: <20070328214025.GA18413@upwardaccess.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070328214025.GA18413@upwardaccess.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 28, 2007 at 02:40:25PM -0700, Mark Mason wrote:

> This is an update to the earlier patch for the sibyte headers, and superceeds
> the previous patch.  Changes were necessary to get the tbprof driver working
> on the bcm1480.
> 
> Patch to update Sibyte header files to match master versions maintained
> at Broadcom.  This patch also corrects some whitespace problems, and
> (hopefully) shouldn't introduce any new ones.
> 
> Signed-off-by: Mark Mason <mason@broadcom.com>

Queued for 2.6.22 - with the usual pile of trailing whitespace stripped.

  Ralf
