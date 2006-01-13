Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 12:05:46 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:55058 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465570AbWAQMF1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 12:05:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0HC90aR009524;
	Tue, 17 Jan 2006 12:09:00 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0DKBESs003578;
	Fri, 13 Jan 2006 20:11:14 GMT
Date:	Fri, 13 Jan 2006 20:11:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alex Gonzalez <langabe@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Compiling a non-pic glibc
Message-ID: <20060113201114.GA3516@linux-mips.org>
References: <c58a7a270601120218r77ec0d8drf2d14663138a13c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c58a7a270601120218r77ec0d8drf2d14663138a13c2@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 12, 2006 at 10:18:03AM +0000, Alex Gonzalez wrote:

> Hi,
> 
> What is the correct way of cross-compiling a non-pic static glibc?

Forget it.  The non-PIC support for glibc is rotting away since ages.

Why do you want a non-PIC glibc?

  Ralf
