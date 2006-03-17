Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Mar 2006 14:47:45 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2177 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133519AbWCQOrh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 17 Mar 2006 14:47:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2HEv0jl009573;
	Fri, 17 Mar 2006 14:57:00 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2HEuvuD009572;
	Fri, 17 Mar 2006 14:56:57 GMT
Date:	Fri, 17 Mar 2006 14:56:57 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Steve Lazaridis <slaz@fortresstech.com>
Cc:	oprofile-list@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: au1550 oprofile
Message-ID: <20060317145657.GD3771@linux-mips.org>
References: <441A1D53.6080305@fortresstech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441A1D53.6080305@fortresstech.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 16, 2006 at 09:22:11PM -0500, Steve Lazaridis wrote:

> Has anyone successfully ran oprofile on an au1550?
> If so, was it in BigEndian mode?
> 
> Are there any known issues with oprofile on au1xxx platforms?

Alchemy processors don't implement performance counters, so there are
by definition no issues ;-)  That unfortunately means you're stuck
with timer mode.

  Ralf
