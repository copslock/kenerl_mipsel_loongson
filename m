Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2005 13:16:08 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:37912 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133443AbVJZMPv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Oct 2005 13:15:51 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9QCFkJg010603;
	Wed, 26 Oct 2005 13:15:46 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9QCFi5Q010602;
	Wed, 26 Oct 2005 13:15:44 +0100
Date:	Wed, 26 Oct 2005 13:15:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Matej Kupljen <matej.kupljen@ultra.si>
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
Subject: Re: Where is op_model_mipsxx.c ?
Message-ID: <20051026121544.GA9755@linux-mips.org>
References: <4343525A.6080605@avtrex.com> <20051005104437.GG2699@linux-mips.org> <1130239559.25742.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130239559.25742.19.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 25, 2005 at 01:25:59PM +0200, Matej Kupljen wrote:

> > I've got oprofile support for MIPS32 / MIPS64 style counters in the queue.
> > It still needs some debugging to become actually useful but anyway, I'm
> > going to check those patches into git in a few minutes.
> 
> Can these be used on the AMD AU1200 core?
> (I don't see Register 25 on Coprocessor 0)
> 
> If OProfile cannot be used, what can I use to profile the kernel?

You can still use oprofile in timer interrupt mode then.

  Ralf
