Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 13:32:09 +0100 (BST)
Received: from tenor.i-cable.com ([203.83.115.107]:46239 "HELO
	tenor.i-cable.com") by ftp.linux-mips.org with SMTP
	id S20029597AbYGWMcH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Jul 2008 13:32:07 +0100
Received: (qmail 16328 invoked by uid 508); 23 Jul 2008 12:31:55 -0000
Received: from 203.83.114.122 by tenor (envelope-from <robert.zhangle@gmail.com>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.90.3/7687.  
 Clear:RC:1(203.83.114.122):. 
 Processed in 0.196779 secs); 23 Jul 2008 12:31:55 -0000
Received: from ip114122.hkicable.com (HELO xenon.i-cable.com) (203.83.114.122)
  by 0 with SMTP; 23 Jul 2008 12:31:54 -0000
Received: from localhost (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by xenon.i-cable.com (8.13.5/8.13.5) with ESMTP id m6NCVgO8024617;
	Wed, 23 Jul 2008 20:31:43 +0800 (CST)
Date:	Wed, 23 Jul 2008 20:31:10 +0800
From:	Zhang Le <r0bertz@gentoo.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	Naresh Bhat <nareshgbhat@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Kernel is Hanging for page size 16KB.
Message-ID: <20080723123109.GC28815@adriano.hkcable.com.hk>
Mail-Followup-To: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>,
	Naresh Bhat <nareshgbhat@gmail.com>, linux-mips@linux-mips.org
References: <cf9b3c760807230016j6c1acc32qd1e54f3a9fa60403@mail.gmail.com> <4886E380.6060300@movial.fi> <cf9b3c760807230113x1194f6b3j692a2cb0867b7885@mail.gmail.com> <4886EECA.7060009@movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4886EECA.7060009@movial.fi>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <robert.zhangle@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

On 11:41 Wed 23 Jul     , Dmitri Vorobiev wrote:
> Naresh Bhat wrote:
> > Hi Dmitri,
> > 
> > I would like to know regarding the support of 16 KB
> > page size option in the linux 2.6.10 for MIPS architectures.
> 
> Normally the page size is 4KiB for all architectures except DEC Alpha, AFAIR. Most probably you simply do not want to change the page size at all. Could you please explain why do you need 16KiB pages?

Hi, AFAIK, Loongson-2E/2F is using 16Kib pages, too.
This is required to solve cache alias problem on Loongson.

Zhang Le
