Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2005 17:10:17 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:47119 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225472AbVIUQKA>; Wed, 21 Sep 2005 17:10:00 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8LG9rgI015841;
	Wed, 21 Sep 2005 17:09:53 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8LG9nGH015840;
	Wed, 21 Sep 2005 17:09:49 +0100
Date:	Wed, 21 Sep 2005 17:09:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: sparse for mips
Message-ID: <20050921160949.GA6150@linux-mips.org>
References: <20050922.004327.74753021.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922.004327.74753021.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 22, 2005 at 12:43:27AM +0900, Atsushi Nemoto wrote:

> It seems sparse can not handle '-G 0' option correctly.  I'm using
> this snapshot:
> 
> http://www.codemonkey.org.uk/projects/git-snapshots/sparse/sparse-2005-09-21.tar.gz
> 
> Is there any trick to run sparse on mips?

Sparse used to work fine for MIPS out of the box, so this is a new bug.

  Ralf
