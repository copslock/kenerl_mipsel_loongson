Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 09:58:49 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:1294 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224902AbVDGI6a>; Thu, 7 Apr 2005 09:58:30 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j378wIAr003730;
	Thu, 7 Apr 2005 09:58:19 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j36K2t3D005005;
	Wed, 6 Apr 2005 21:02:55 +0100
Date:	Wed, 6 Apr 2005 21:02:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 4kc machine check
Message-ID: <20050406200255.GA4978@linux-mips.org>
References: <4254181A.9000301@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4254181A.9000301@timesys.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 06, 2005 at 01:10:50PM -0400, Greg Weeks wrote:

> I noticed there was a recent checkin for 4000 series tlb code. It still 
> seems to be a problem on the 4kc malta.

4K is not R4000 series ...   Anyway, the 4K code you were sent aren't yet
in because they've only empirically proven to be correct; we'd like to
look into the case a little further before comitting the patches into CVS.

  Ralf
