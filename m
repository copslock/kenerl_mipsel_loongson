Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Nov 2005 08:32:53 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:28609 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133399AbVK3Icf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 30 Nov 2005 08:32:35 +0000
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 11F43C02D;
	Wed, 30 Nov 2005 09:35:51 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id 8D7381BC08F;
	Wed, 30 Nov 2005 09:35:52 +0100 (CET)
Received: from [172.18.1.53] (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id CE5451A18CB;
	Wed, 30 Nov 2005 09:35:52 +0100 (CET)
Subject: Re: [PATCH] Fix board type in db1x00
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20051129165148.GA20402@linux-mips.org>
References: <20051122221526.GZ18119@cosmic.amd.com>
	 <6dabaec28e238ccc915f20f51ee28327@embeddedalley.com>
	 <20051129165148.GA20402@linux-mips.org>
Content-Type: text/plain
Date:	Wed, 30 Nov 2005 09:35:27 +0100
Message-Id: <1133339727.24526.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> But we don't have a nice space for this in header files either right now.
> So I'll apply this one but if you come up with something better I'll
> certainly appreciate it.

You forgot DBAU1200.

BR,
Matej
