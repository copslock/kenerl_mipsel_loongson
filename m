Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2008 16:56:36 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:3242 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027001AbYBSQ4e (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 19 Feb 2008 16:56:34 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1JGuXfs015647;
	Tue, 19 Feb 2008 16:56:33 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1JGuWjU015646;
	Tue, 19 Feb 2008 16:56:32 GMT
Date:	Tue, 19 Feb 2008 16:56:32 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Add platform MTD support for the WGT634U machine
Message-ID: <20080219165632.GA15639@linux-mips.org>
References: <20080207021716.GA3350@volta.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080207021716.GA3350@volta.aurel32.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 07, 2008 at 03:17:16AM +0100, Aurelien Jarno wrote:

> The patch below adds MTD support for the WGT634U machine by defining a
> new platform_device for the flash.

I think this one should still go into 2.6.25, applied.

  Ralf
