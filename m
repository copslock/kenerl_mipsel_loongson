Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 15:43:54 +0000 (GMT)
Received: from gateway-1237.mvista.com ([63.81.120.158]:15606 "EHLO
	gateway-1237.mvista.com") by ftp.linux-mips.org with ESMTP
	id S28579692AbYAKPnp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 11 Jan 2008 15:43:45 +0000
Received: from [10.0.4.38] (dwalker.mvista.com [10.0.4.38])
	by hermes.mvista.com (Postfix) with ESMTP
	id E464A240B4; Fri, 11 Jan 2008 07:43:33 -0800 (PST)
Subject: Re: [PATCH] mips: picvue: pvc_sem semaphore to mutex
From:	Daniel Walker <dwalker@mvista.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	brian@murphy.dk, mingo@elte.hu, linux-mips@linux-mips.org
In-Reply-To: <20080111123231.GB19900@linux-mips.org>
References: <20080111045321.274084894@mvista.com>
	 <20080111123231.GB19900@linux-mips.org>
Content-Type: text/plain
Date:	Fri, 11 Jan 2008 07:41:44 -0800
Message-Id: <1200066104.29897.84.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.2 (2.12.2-2.fc8) 
Content-Transfer-Encoding: 7bit
Return-Path: <dwalker@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwalker@mvista.com
Precedence: bulk
X-list: linux-mips


On Fri, 2008-01-11 at 12:32 +0000, Ralf Baechle wrote:
> On Thu, Jan 10, 2008 at 08:53:21PM -0800, Daniel Walker wrote:
> > From: Daniel Walker <dwalker@mvista.com>
> > Date: Thu, 10 Jan 2008 20:53:48 -0800
> > Date: Thu, 10 Jan 2008 20:53:21 -0800
> 
> Btw, your email headers are looking slightly odd ;-)

Hmm .. Not sure how that happened .. Must be something in my quilt tho,
thanks for noticing it.

Daniel
