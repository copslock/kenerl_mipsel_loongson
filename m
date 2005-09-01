Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2005 17:46:43 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:6670 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225398AbVIAQq1>; Thu, 1 Sep 2005 17:46:27 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j81GqakJ017648;
	Thu, 1 Sep 2005 17:52:36 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j81GqZiN017647;
	Thu, 1 Sep 2005 17:52:35 +0100
Date:	Thu, 1 Sep 2005 17:52:35 +0100
From:	Ralf Baechle DL5RB <ralf@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: custom ide driver causes "Badness in smp_call_function"
Message-ID: <20050901165235.GI2876@linux-mips.org>
References: <20050826141047.GA8777@linux-mips.org> <20050901161023Z8225398-3678+8096@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901161023Z8225398-3678+8096@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 01, 2005 at 12:15:31PM -0400, Bryan Althouse wrote:

> I've done more testing with your patch.  When I use it with my non-SMP
> kernel, disk access will cause a panic with a cache error message.  Is this
> patch only intended for SMP, or is this a legitimate problem?

There is a real problem but it only hits on SMP.

(The implementation is a hack though, it makes assumptions about the IDE
code's internal workings)

  Ralf
