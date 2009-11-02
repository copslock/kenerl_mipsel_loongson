Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 12:28:39 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:36055 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493849AbZKBL2g (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 12:28:36 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA2BTvjt003267;
	Mon, 2 Nov 2009 12:29:58 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA2BTtVO003265;
	Mon, 2 Nov 2009 12:29:55 +0100
Date:	Mon, 2 Nov 2009 12:29:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] alchemy: fix warnings in db1x00/pb1000/pb1550
	board setup code
Message-ID: <20091102112955.GA2821@linux-mips.org>
References: <200910181604.11732.florian@openwrt.org> <f861ec6f0910190412i3910246dgcdf6b8b56a8ed5b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f861ec6f0910190412i3910246dgcdf6b8b56a8ed5b3@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 19, 2009 at 01:12:15PM +0200, Manuel Lauss wrote:

> I like it, thank you!

Except that it a) does things the comments don't mention and b) doesn't
apply on top of master or -queue ...

  Ralf
