Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2005 16:40:46 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:58133 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225288AbVBUQkb>; Mon, 21 Feb 2005 16:40:31 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j1LGXond020523;
	Mon, 21 Feb 2005 16:33:50 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j1LGXopm020522;
	Mon, 21 Feb 2005 16:33:50 GMT
Date:	Mon, 21 Feb 2005 16:33:50 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] Cobalt fixes [5 of 6]
Message-ID: <20050221163350.GF14692@linux-mips.org>
References: <20050220150103.GF26582@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050220150103.GF26582@skeleton-jack>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 20, 2005 at 03:01:03PM +0000, Peter Horton wrote:

> Fix Qube/RaQ PIO IDE to prevent D-cache aliasing problems.

This really shouldn't be in machine-specific code.  A while ago somebody
did post a patch to the generic code which I had minor objections on.
Gotta dig it up and fix it ...

  Ralf
