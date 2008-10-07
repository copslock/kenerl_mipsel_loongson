Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2008 14:36:54 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:13007 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20830355AbYJGNgt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Oct 2008 14:36:49 +0100
Received: (qmail 13677 invoked by uid 1000); 7 Oct 2008 15:36:45 +0200
Date:	Tue, 7 Oct 2008 15:36:45 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	linux-mips <linux-mips@linux-mips.org>, alsa-devel@vger.kernel.org
Subject: Re: 2 Au1xxx (Alchemy) AC97 drivers
Message-ID: <20081007133645.GA13668@roarinelk.homelinux.net>
References: <1223386106.31477.3.camel@kh-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1223386106.31477.3.camel@kh-ubuntu>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

On Tue, Oct 07, 2008 at 08:28:26AM -0500, Kevin Hickey wrote:
> There appear to be 2 AC97 drivers for Alchemy in the latest Linux tree.
> One is in sound/mips and the other is in sound/soc.  Are both going to
> be maintained going forward?  If not, which one will be?  

The one in sound/soc is for Au1200/Au1550; I think the sound/mips one only
works on Au1000/Au1500.

	Manuel Lauss
