Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2006 09:24:05 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:38098 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133443AbWFWIX4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Jun 2006 09:23:56 +0100
Received: from localhost (in-1.mx.triera.net [213.161.0.25])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 1075EC03A;
	Fri, 23 Jun 2006 10:23:46 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-1.mx.triera.net (Postfix) with SMTP id 980261BC09B;
	Fri, 23 Jun 2006 10:23:47 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 3D3CD1A18BF;
	Fri, 23 Jun 2006 10:23:46 +0200 (CEST)
Date:	Fri, 23 Jun 2006 10:23:48 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: u-boot problem: Au1xx0: fix prom_getenv() to handle YAMON style environment
Message-ID: <20060623082348.GB18607@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

Hi.

I need to revert $SUBJECT patch for kernel to boot on au1200,
u-boot 1.1.3.

And I could swear it worked booted yesterday without reverting (??)

Could we support yamon and u-boot style environment?


	Domen
