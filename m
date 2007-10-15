Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 12:08:08 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:59828 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20035348AbXJOLIG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 12:08:06 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9FB84UY012656;
	Mon, 15 Oct 2007 12:08:05 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9FB84rB012655;
	Mon, 15 Oct 2007 12:08:04 +0100
Date:	Mon, 15 Oct 2007 12:08:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix MIPSsim booting from NFS root
Message-ID: <20071015110804.GA12611@linux-mips.org>
References: <20071014161106.GS3379@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071014161106.GS3379@networkno.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 14, 2007 at 05:11:06PM +0100, Thiemo Seufer wrote:

> MIPSsim probably doesn't have any sort of environment, but writing
> a zero in it kills even the compiled in command line. This prevents
> booting via NFS root.

Thanks, applied.

   Ralf
