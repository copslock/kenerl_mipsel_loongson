Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Sep 2011 04:00:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54378 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491773Ab1IQCAj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 17 Sep 2011 04:00:39 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p8H20YHj025084;
        Sat, 17 Sep 2011 04:00:34 +0200
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p8H20W2a025081;
        Sat, 17 Sep 2011 04:00:32 +0200
Date:   Sat, 17 Sep 2011 04:00:32 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        "Kevin D. Kissell" <kevink@paralogos.com>
Subject: Re: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
Message-ID: <20110917020032.GA24974@linux-mips.org>
References: <20110829232029.GA15763@zapo>
 <4E5C2490.6040203@cavium.com>
 <20110915160054.GA10622@linux-mips.org>
 <20110917012315.GG20455@zapo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110917012315.GG20455@zapo>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8906

On Sat, Sep 17, 2011 at 03:23:15AM +0200, Edgar E. Iglesias wrote:

> I agree, thanks!

You're welcome.

> BTW, in case anyone is intersted, it is now possible to boot malta
> boards with SMP with the latest QEMU. The neat thing is that if you
> debug the kernel with GDB, you'll see the different cores execution
> contexts as differten threads and can singletep them individually.

Very interesting.  What type of SMP system does it emulate?

  Ralf
