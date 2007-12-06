Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2007 18:27:14 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:27071 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026788AbXLFS1M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Dec 2007 18:27:12 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB6IQehZ026729;
	Thu, 6 Dec 2007 18:26:40 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB6IQdNx026728;
	Thu, 6 Dec 2007 18:26:39 GMT
Date:	Thu, 6 Dec 2007 18:26:39 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Alchemy: fix PCI resource conflict
Message-ID: <20071206182639.GB24263@linux-mips.org>
References: <200712062056.06326.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200712062056.06326.sshtylyov@ru.mvista.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 06, 2007 at 08:56:06PM +0300, Sergei Shtylyov wrote:
> From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Date: Thu, 6 Dec 2007 20:56:06 +0300
> To: ralf@linux-mips.org
> Cc: linux-mips@linux-mips.org
> Subject: [PATCH] Alchemy: fix PCI resource conflict
> Content-Type: text/plain;
> 	charset="us-ascii"
> 
> ... by getting the PCI resources back into the 32-bit range -- there's no need
> therefore for CONFIG_RESOURCES_64BIT either. This makes Alchemy PCI work again
> while currently the kernel skips the bus scan.

So now you're using the numeric overflow to get things to "work"?

  Ralf
