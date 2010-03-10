Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2010 17:48:34 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60683 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492624Ab0CJQs3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Mar 2010 17:48:29 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o2AGmQ71018013;
        Wed, 10 Mar 2010 17:48:27 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o2AGmOF9018009;
        Wed, 10 Mar 2010 17:48:24 +0100
Date:   Wed, 10 Mar 2010 17:48:24 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: move MMC driver registration to board
 code.
Message-ID: <20100310164824.GC15118@linux-mips.org>
References: <1268076181-29642-1-git-send-email-manuel.lauss@gmail.com>
 <1268076181-29642-3-git-send-email-manuel.lauss@gmail.com>
 <4B963210.7030906@ru.mvista.com>
 <f861ec6f1003090345n53570102je68aef14e8b3f3fb@mail.gmail.com>
 <4B96364E.5050202@mvista.com>
 <f861ec6f1003090403j190d0ddbp7e245d0990a62a51@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f861ec6f1003090403j190d0ddbp7e245d0990a62a51@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 09, 2010 at 01:03:51PM +0100, Manuel Lauss wrote:

> And on a personal note, that file just bothers me.  It's messy, can
> cause merge conflicts,

Eye cancer.

> it references structures defined inside board-specific code. In short,
> it just plain annoys
> my sense of aesthetics.

Indeed - and I don't think Sergej disagrees with that.  I agree with him
that device registration code should primarily be done in the SOC code -
but you'll need to somehow get that code to communicate with the platform
code about what really needs to be done then register the remainder of
the truely platform-specific platform devices.  Something like that.

  Ralf
