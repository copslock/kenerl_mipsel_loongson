Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jan 2008 19:58:30 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:48290 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20032267AbYANT62 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Jan 2008 19:58:28 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0EJvM3S030668;
	Mon, 14 Jan 2008 19:57:47 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0EJvMME030667;
	Mon, 14 Jan 2008 19:57:22 GMT
Date:	Mon, 14 Jan 2008 19:57:22 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Fainelli <florian.fainelli@telecomint.eu>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Kill Broadcom machine group
Message-ID: <20080114195722.GB29499@linux-mips.org>
References: <200801141900.02601.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200801141900.02601.florian.fainelli@telecomint.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18037
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 14, 2008 at 07:00:01PM +0100, Florian Fainelli wrote:

> This patch removes the remaining MACH_GROUP that
> was still present for Broadcom boards.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>

Patch good - but Yoichi Yuasa's patch "remove unused mips_machtype" from
October already cleaned that.

  Ralf
