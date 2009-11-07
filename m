Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Nov 2009 20:14:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:46960 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493345AbZKGTOW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Nov 2009 20:14:22 +0100
Date:	Sat, 7 Nov 2009 19:14:22 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Make local arrays with CL_SIZE static __initdata
In-Reply-To: <90edad820911071016v70e6e68bia8f0c3b6f09ceb3c@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.0911071913370.9725@eddie.linux-mips.org>
References: <1257614437-8632-1-git-send-email-anemo@mba.ocn.ne.jp> <90edad820911071016v70e6e68bia8f0c3b6f09ceb3c@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 7 Nov 2009, Dmitri Vorobiev wrote:

> Also, I think it's more common to place __initdata before the variable
> name, not after it, although tastes do differ. :)

 Well, <linux/init.h> disagrees.

  Maciej
