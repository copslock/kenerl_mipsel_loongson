Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2005 10:09:15 +0100 (BST)
Received: from p549F5CB2.dip.t-dialin.net ([84.159.92.178]:13995 "EHLO
	p549F5CB2.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133426AbVJZJIi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Oct 2005 10:08:38 +0100
Received: from [IPv6:::ffff:213.161.0.31] ([IPv6:::ffff:213.161.0.31]:24242
	"HELO deliver-1.mx.triera.net") by linux-mips.net with SMTP
	id <S869888AbVJYL0t>; Tue, 25 Oct 2005 13:26:49 +0200
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 47B58C035;
	Tue, 25 Oct 2005 13:26:01 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id 934261BC090;
	Tue, 25 Oct 2005 13:26:03 +0200 (CEST)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 4C24B1A18C3;
	Tue, 25 Oct 2005 13:26:02 +0200 (CEST)
Subject: Re: Where is op_model_mipsxx.c ?
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
In-Reply-To: <20051005104437.GG2699@linux-mips.org>
References: <4343525A.6080605@avtrex.com>
	 <20051005104437.GG2699@linux-mips.org>
Content-Type: text/plain
Date:	Tue, 25 Oct 2005 13:25:59 +0200
Message-Id: <1130239559.25742.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> I've got oprofile support for MIPS32 / MIPS64 style counters in the queue.
> It still needs some debugging to become actually useful but anyway, I'm
> going to check those patches into git in a few minutes.

Can these be used on the AMD AU1200 core?
(I don't see Register 25 on Coprocessor 0)

If OProfile cannot be used, what can I use to profile the kernel?

BR,
Matej
