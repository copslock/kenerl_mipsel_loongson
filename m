Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Feb 2008 12:59:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:9951 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030035AbYBTM7U (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Feb 2008 12:59:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1KCxJee025065;
	Wed, 20 Feb 2008 12:59:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1KCxJOK025064;
	Wed, 20 Feb 2008 12:59:19 GMT
Date:	Wed, 20 Feb 2008 12:59:19 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wolfgang Ocker <weo@reccoware.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fix ids in Alchemy db dma device table (Repost
	in hopefully correct format)
Message-ID: <20080220125919.GA24984@linux-mips.org>
References: <1202671893.3384.20.camel@galileo.recco.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1202671893.3384.20.camel@galileo.recco.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 10, 2008 at 08:31:33PM +0100, Wolfgang Ocker wrote:

> Subject: [PATCH] [MIPS] Fix ids in Alchemy db dma device table (Repost in
> 	hopefully correct format)
> Content-Type: text/plain
> 
> From: Wolfgang Ocker <weo@reccoware.de>

Kudos for resending in The Right Format (TM) before I had a chance to beg
for it :-)  It seems though you were generating an unclean or maybe simply
older version of the tree to generate this patch.  Git didn't like it and
patch only with fuzz.

Applied,

  Ralf
