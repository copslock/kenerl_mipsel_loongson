Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 14:05:40 +0000 (GMT)
Received: from smtp.nokia.com ([131.228.20.172]:20577 "EHLO
	mgw-ext13.nokia.com") by ftp.linux-mips.org with ESMTP
	id S20038495AbXBHOFg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Feb 2007 14:05:36 +0000
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-ext13.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l18DrH4D008003;
	Thu, 8 Feb 2007 15:53:24 +0200
Received: from esebh103.NOE.Nokia.com ([172.21.143.33]) by esebh106.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 8 Feb 2007 15:55:18 +0200
Received: from esebh102.NOE.Nokia.com ([172.21.138.183]) by esebh103.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 8 Feb 2007 15:55:41 +0200
Received: from [172.21.42.38] ([172.21.42.38]) by esebh102.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 8 Feb 2007 15:55:18 +0200
Subject: Re: [PATCH] eXcite nand flash driver
From:	Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1170942627.4884.89.camel@zod.rchland.ibm.com>
References: <200702080157.25432.thomas.koeller@baslerweb.com>
	 <1170942627.4884.89.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8
Date:	Thu, 08 Feb 2007 15:55:40 +0200
Message-Id: <1170942940.7984.5.camel@sauron>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 08 Feb 2007 13:55:18.0152 (UTC) FILETIME=[C4219880:01C74B88]
X-Nokia-AV: Clean
Return-Path: <dedekind@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind@infradead.org
Precedence: bulk
X-list: linux-mips

On Thu, 2007-02-08 at 07:50 -0600, Josh Boyer wrote:
> > +	/* free the common resources */
> > +	if (likely(this->regs)) {
> > +		iounmap(this->regs);
> > +		this->regs = NULL;
> > +	}
> 
> Same likely usage comment as above.

I agree, this function will be called one or very few times, so  this
hint is not reasonable in this case.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)
