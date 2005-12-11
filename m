Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Dec 2005 16:53:43 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:32775 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133553AbVLKQx0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Dec 2005 16:53:26 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jBBGrWX2006370;
	Sun, 11 Dec 2005 16:53:32 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jBBGrVrS006369;
	Sun, 11 Dec 2005 16:53:31 GMT
Date:	Sun, 11 Dec 2005 16:53:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylylov <sshtylyov@ru.mvista.com>
Cc:	Linux MIPS <linux-mips@linux-mips.org>,
	Manish Lachwani <mlachwani@mvista.com>,
	Konstantin Baidarov <kbaidarov@ru.mvista.com>
Subject: Re: [PATCH] SiMotion VoyagerGX framebuffer: blue stripped background
Message-ID: <20051211165331.GB3164@linux-mips.org>
References: <4399C8AB.4080403@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4399C8AB.4080403@ru.mvista.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 09, 2005 at 09:10:51PM +0300, Sergei Shtylylov wrote:

>    This driver was using an incorrect typecast when setting pseudopalette,
> hence were the blue strips on the black char background. As this driver
> happens to be maintaned by Linux/MIPS, here's the patch (I've also noticed a

Framebuffer stuff to it's maintainer "Antonino A. Daplas" <adaplas@gmail.com>
and linux-fbdev-devel@lists.sourceforge.net, please.

  Ralf
