Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Dec 2005 03:51:59 +0000 (GMT)
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:48609 "EHLO
	ylpvm12.prodigy.net") by ftp.linux-mips.org with ESMTP
	id S8133917AbVLADvk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Dec 2005 03:51:40 +0000
Received: from ylpvm01.prodigy.net (ylpvm01-int.prodigy.net [207.115.5.207])
	by ylpvm12.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id jB13tTv4030788;
	Wed, 30 Nov 2005 22:55:30 -0500
X-ORBL:	[70.132.51.62]
Received: from stupidest.org ([70.132.51.62])
	by ylpvm01.prodigy.net (8.13.4 dk-milter linux/8.13.4) with ESMTP id jB13xGZv028324;
	Wed, 30 Nov 2005 22:59:17 -0500
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 2CE0B4FE060; Wed, 30 Nov 2005 19:55:07 -0800 (PST)
Date:	Wed, 30 Nov 2005 19:55:07 -0800
From:	Chris Wedgwood <cw@f00f.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Matej Kupljen <matej.kupljen@ultra.si>, linux-mips@linux-mips.org,
	Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: MIPS no FP patch
Message-ID: <20051201035507.GA32133@taniwha.stupidest.org>
References: <1133348852.24526.31.camel@localhost.localdomain> <20051130112821.GB2694@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051130112821.GB2694@linux-mips.org>
Return-Path: <cw@f00f.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cw@f00f.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 30, 2005 at 11:28:21AM +0000, Ralf Baechle wrote:

> We used to have this option but I eventually got rid of it because
> people just don't grok that they must enable it in precense of an
> FPU.

For cores that have FPUs you could have Kconfig "select" it
automatically.
