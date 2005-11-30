Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2005 11:28:19 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:11526 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133833AbVK3L2C (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Nov 2005 11:28:02 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAUBSM5E004564;
	Wed, 30 Nov 2005 11:28:22 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAUBSLRJ004563;
	Wed, 30 Nov 2005 11:28:21 GMT
Date:	Wed, 30 Nov 2005 11:28:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Matej Kupljen <matej.kupljen@ultra.si>
Cc:	linux-mips@linux-mips.org, Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: MIPS no FP patch
Message-ID: <20051130112821.GB2694@linux-mips.org>
References: <1133348852.24526.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133348852.24526.31.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 30, 2005 at 12:07:32PM +0100, Matej Kupljen wrote:

> This is a patch that makes FP emulation in kernel an option.
> I used this when I was looking why there are still some
> FP instruction in glibc, even though it was configured with
> --withot-fp. This seemed the best way to ensure this.
> 
> It is for the 2.6.14-rc2, but I think there is only a minimal
> work to use it on latest kernel.

We used to have this option but I eventually got rid of it because people
just don't grok that they must enable it in precense of an FPU.

  Ralf
