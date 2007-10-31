Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2007 16:32:04 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:44980 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28576009AbXJaQcC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Oct 2007 16:32:02 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9VGVif6023345;
	Wed, 31 Oct 2007 16:31:44 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9VGViIq023344;
	Wed, 31 Oct 2007 16:31:44 GMT
Date:	Wed, 31 Oct 2007 16:31:44 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix SWARM build failure
Message-ID: <20071031163144.GA22433@linux-mips.org>
References: <20071031162656.GJ7712@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071031162656.GJ7712@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 31, 2007 at 04:26:56PM +0000, Thiemo Seufer wrote:

> This fixes a typo, the warning lets the build fail.

Well, there is difference between a pointer and it's address after all.
So it's good if gcc makes loud noise about it.

  Ralf
