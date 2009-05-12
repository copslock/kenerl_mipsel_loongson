Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2009 22:56:23 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:37727 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023495AbZELV4Q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2009 22:56:16 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 44856D8D1; Tue, 12 May 2009 21:56:09 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 3B3B31510BD; Tue, 12 May 2009 23:55:57 +0200 (CEST)
Date:	Tue, 12 May 2009 23:55:57 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] SIBYTE: fix locking in set_irq_affinity
Message-ID: <20090512215556.GA4774@deprecation.cyrius.com>
References: <20090504215155.461B2E31C1@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090504215155.461B2E31C1@solo.franken.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Thomas Bogendoerfer <tsbogend@alpha.franken.de> [2009-05-04 23:51]:
> Locking of irq_desc is now done in irq_set_affinity; Don't lock it
> again in chip specific set_affinity function.

SWARM boots with this patch, but dmesg shows:

[17179570.260000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179570.484000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179570.500000] attempted to set irq affinity for irq 8 to multiple CPUs

-- 
Martin Michlmayr
http://www.cyrius.com/
