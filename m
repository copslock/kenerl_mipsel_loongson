Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 21:12:42 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:23445 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225216AbVAaVMY>; Mon, 31 Jan 2005 21:12:24 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j0VL8Ng3012081;
	Mon, 31 Jan 2005 21:08:23 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j0VL8Jo2012080;
	Mon, 31 Jan 2005 21:08:19 GMT
Date:	Mon, 31 Jan 2005 21:08:19 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Joseph Chiu <joseph@omnilux.net>
Cc:	Clem Taylor <clem.taylor@gmail.com>, linux-mips@linux-mips.org
Subject: Re: initial bootstrap and jtag
Message-ID: <20050131210819.GB11238@linux-mips.org>
References: <BBB228F72FF00E4390479AC295FF4B350DE863@FOOTHILL.iad.idealab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BBB228F72FF00E4390479AC295FF4B350DE863@FOOTHILL.iad.idealab.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7088
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 31, 2005 at 12:42:07PM -0800, Joseph Chiu wrote:

> Do people still use ROM emulators?  I think the turnaround time for getting the machine bootstrapped would have been faster with a ROMulator (at least for the stuff I was doing)...

It's a while since then but the PromICE has been extremly valuable for
some development a few years ago.  A good JTAG probe is more universal
so may be a better investment though.

  Ralf
