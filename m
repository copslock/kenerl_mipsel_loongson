Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2007 15:10:29 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:44480 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573971AbXJ2PK1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Oct 2007 15:10:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9TFALDI004327;
	Mon, 29 Oct 2007 15:10:21 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9TFAAhN004326;
	Mon, 29 Oct 2007 15:10:10 GMT
Date:	Mon, 29 Oct 2007 15:10:10 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][au1000] Remove useless EXTRA_CFLAGS
Message-ID: <20071029151010.GA3953@linux-mips.org>
References: <200710252108.43357.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200710252108.43357.florian.fainelli@telecomint.eu>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 25, 2007 at 09:08:42PM +0200, Florian Fainelli wrote:

> Remove the EXTRA_CFLAGS because it is useless (code compiles without warnings).

And to ensure it will stay that way I'll keep -Werror.  It seems only
little PITAs like this keep everybody on their toes :-)

  Ralf
