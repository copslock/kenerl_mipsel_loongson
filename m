Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2003 15:50:51 +0000 (GMT)
Received: from p508B5A9E.dip.t-dialin.net ([IPv6:::ffff:80.139.90.158]:58245
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225514AbTKLPuj>; Wed, 12 Nov 2003 15:50:39 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hACFobA0011500;
	Wed, 12 Nov 2003 16:50:37 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hACFoYc3011499;
	Wed, 12 Nov 2003 16:50:34 +0100
Date: Wed, 12 Nov 2003 16:50:34 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: ashish anand <ashish_ibm@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: is cli/sti pair interruptible..?
Message-ID: <20031112155034.GA11440@linux-mips.org>
References: <20031112145937.13188.qmail@webmail27.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031112145937.13188.qmail@webmail27.rediffmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 12, 2003 at 02:59:37PM -0000, ashish  anand wrote:

> what prevents cli/sti pair not to be interrupted during their operation..?

Nothing.

  Ralf
