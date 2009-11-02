Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 14:02:04 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:34913 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493878AbZKBNCB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 14:02:01 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA2D3Rxh021383;
	Mon, 2 Nov 2009 14:03:27 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA2D3RPA021381;
	Mon, 2 Nov 2009 14:03:27 +0100
Date:	Mon, 2 Nov 2009 14:03:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH 2/2] alchemy: turn on -Werror for devboards and xss1500
Message-ID: <20091102130327.GA6205@linux-mips.org>
References: <200910181604.42580.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200910181604.42580.florian@openwrt.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 18, 2009 at 04:04:41PM +0200, Florian Fainelli wrote:

> Warnings being suppressed, we can now turn on -Werror
> for boards which did not have it already (devboards and
> xss1500).
> 
> Signed-off-by: Florian Fainelli <florian@openwrt.org>

Applied as well.

  Ralf
