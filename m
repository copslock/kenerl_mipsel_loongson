Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jun 2006 12:22:56 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:60119 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133833AbWFVLWr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Jun 2006 12:22:47 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5MBMllv006758;
	Thu, 22 Jun 2006 12:22:47 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5MBMkgZ006757;
	Thu, 22 Jun 2006 12:22:46 +0100
Date:	Thu, 22 Jun 2006 12:22:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	ankur maheshwari <ankur_maheshwari@procsys.com>
Cc:	Jean Delvare <khali@linux-fr.org>,
	Pete Popov <ppopov@embeddedalley.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: i2c-algo-ite and i2c-ite planned for removal
Message-ID: <20060622112246.GB4032@linux-mips.org>
References: <20060620120836.628ddc79.khali@linux-fr.org> <110701c694f4$f1412fb0$f301a8c0@procsys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <110701c694f4$f1412fb0$f301a8c0@procsys>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 21, 2006 at 11:08:34AM +0530, ankur maheshwari wrote:

> I have used once i2c-adap-ite and i2c-algo-ite for ite-8712 chip and it
> worked fine for me in MV 2.4.25.

The fact that is used to work in some vendor kernel is irrelevant.  And
2.4 hardly indicates anyway.

> Its been an year ago, I asked on same forum if some one has used it
> before but I didn't got any reply.

You see how amazingly popular the board was.  On April 2 just after
2.6.16 was out I announced my intension to remove the board in

  http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060402194822.GA26358%40linux-mips.org

Nobody raised hand to take care of the maintenance of any of these boards,
thus http://www.linux-mips.org/wiki/ITE-8172G also marks the board as
to be deleted.

> It's just an info on ite-chip works, to remove it from kernel tree .....
> decision is up to you : ).

There is more that just that wrong with the board support.  And if the
fact that it is was broken does not even result bug reports this is
another indicator the board a board should go.

The usual reminder: patches to fix the issues will be accepted.

  Ralf
