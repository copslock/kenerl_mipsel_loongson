Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Mar 2005 17:29:31 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:1301 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224936AbVCJR3N>; Thu, 10 Mar 2005 17:29:13 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2AHSeZV027704;
	Thu, 10 Mar 2005 17:28:40 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2AHSeae027703;
	Thu, 10 Mar 2005 17:28:40 GMT
Date:	Thu, 10 Mar 2005 17:28:40 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] qtronix missing failure handling
Message-ID: <20050310172840.GD26269@linux-mips.org>
References: <20050305150844.GA7544@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305150844.GA7544@mech.kuleuven.ac.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Mar 05, 2005 at 04:08:44PM +0100, Panagiotis Issaris wrote:

> Hi,
> 
> The Qtronix keyboard driver doesn't handle the possible failure of memory
> allocation.

Thanks, applied.

Please copy Linux/MIPS-specific patches to me or linux-mips@linux-mips.org;
it was more a coincidence that I noticed your patch on this list.

Thanks,

  Ralf
