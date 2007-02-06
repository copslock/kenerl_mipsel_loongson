Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2007 11:04:05 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:18097 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037836AbXBFLEE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Feb 2007 11:04:04 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l16B3wJL006734;
	Tue, 6 Feb 2007 11:03:58 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l16B3wFn006733;
	Tue, 6 Feb 2007 11:03:58 GMT
Date:	Tue, 6 Feb 2007 11:03:58 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Koeller, T." <Thomas.Koeller@baslerweb.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Remove Basler Excite support
Message-ID: <20070206110358.GA29286@linux-mips.org>
References: <C5A8FDEFF7647F4C9CB927D7DEB3077303FCF2C9@ahr075s.basler.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5A8FDEFF7647F4C9CB927D7DEB3077303FCF2C9@ahr075s.basler.corp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 05, 2007 at 11:35:55AM +0100, Koeller, T. wrote:

> the last time I worked on it (which is three days ago, while working to make the excite nand flash driver ready for submission), it built and ran just fine, so I really wonder why you are removing it. I now notice that it has been made depending on BROKEN some time ago, which escaped my attention when it happened.

It was marked broken because in the incomplete merge state it did not
build.

My last emails did not receive any answer and the patch to remove it has
actually been sitting in the queue tree for well over a month mostly as
hint by waiving with a tree trunk so I did interpret this as a loss of
communication.

> The reason I did not encounter any build problems is that I always built the code with the yet-to-be-submitted drivers. The compilation error you get when building the excite platform is caused by a dependency upon the rm9k_serial driver, on which the platform depends for serial console support. I haven't yet managed to submit that driver, although I made several attempts. If serial console support were disabled, the code could trivially be fixed to compile without errors.

2.6.21 has just opened so now is an excellent time to submit all the
remaining driver bits.

> Can you revert the removal?

Sure, I can undo the deletion at any time.  And to generalize that, while
I'm eager to remove code for which nobody has shown any interest this by
no means is a one way road.

  Ralf
