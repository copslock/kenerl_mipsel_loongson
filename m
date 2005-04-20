Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2005 19:07:51 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:55577 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8224850AbVDTSHh>; Wed, 20 Apr 2005 19:07:37 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3KI7LcG026415;
	Wed, 20 Apr 2005 19:07:21 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3KI7Kwa026414;
	Wed, 20 Apr 2005 19:07:20 +0100
Date:	Wed, 20 Apr 2005 19:07:20 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Pete Popov <ppopov@embeddedalley.com>
Cc:	Clem Taylor <clem.taylor@gmail.com>, linux-mips@linux-mips.org
Subject: Re: mdelay() from board_setup() [is default value for loops_per_jiffy way off?]
Message-ID: <20050420180720.GK5212@linux-mips.org>
References: <ecb4efd10504201050a00f941@mail.gmail.com> <42669862.7000405@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42669862.7000405@embeddedalley.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 20, 2005 at 10:58:58AM -0700, Pete Popov wrote:

> It's too early in board_setup() to use the standard delay routines. You 
> can't use those until after calibrate_delay() runs. To do precise delays in 
> board_setup, you'll have to do something yourself where you read the cp0 
> timer periodically and wait a certain amount of time.

And make sure not to be trapped by wrap-arounds of that counter.  Also it
doesn't count the same speed on all processors ...

  Ralf
