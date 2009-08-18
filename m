Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Aug 2009 16:31:43 +0200 (CEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:35124 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493024AbZHRObh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Aug 2009 16:31:37 +0200
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id BDC7AE080D4;
	Tue, 18 Aug 2009 16:31:30 +0200 (CEST)
Received: from [213.228.1.107] (sakura.staff.proxad.net [213.228.1.107])
	by smtp6-g21.free.fr (Postfix) with ESMTP id D345CE080AB;
	Tue, 18 Aug 2009 16:31:27 +0200 (CEST)
Subject: Re: More updates to bcm63xx
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
In-Reply-To: <20090818122427.GA21399@linux-mips.org>
References: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
	 <20090818122427.GA21399@linux-mips.org>
Content-Type: text/plain
Organization: Freebox
Date:	Tue, 18 Aug 2009 16:31:27 +0200
Message-Id: <1250605887.23717.188.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23911
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Tue, 2009-08-18 at 13:24 +0100, Ralf Baechle wrote:

Hi Ralf,

> I folded all 8 patches into the existing patches for the linux-bcm63xx
> tree

The bcm63xx tree seems wrong.

The patch from Florian that adds support for 6338 & 6345 is merged with
commit BCM63XX: Add integrated ethernet mac support.

The final patch that adds the board code is gone.

-- 
Maxime
