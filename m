Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 16:12:19 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:24858 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465592AbWAWQL7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 16:11:59 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0NGGKbU023102;
	Mon, 23 Jan 2006 16:16:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0NGGKNj023101;
	Mon, 23 Jan 2006 16:16:20 GMT
Date:	Mon, 23 Jan 2006 16:16:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rojhalat Ibrahim <imr@rtschenk.de>
Cc:	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Fixes for uaccess.h with gcc >= 4.0.1
Message-ID: <20060123161620.GB22656@linux-mips.org>
References: <20060123150507.GA18665@linux-mips.org> <43D4FE76.1070805@rtschenk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D4FE76.1070805@rtschenk.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10075
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 23, 2006 at 05:04:06PM +0100, Rojhalat Ibrahim wrote:

> > I'd appreciate if somebody with gcc 4.0.1 could test this kernel patch
> > below.
> > 
> 
> Works for me. The compilation errors are gone and the kernel
> seems to be running fine.

Excellent, thanks for testing.  I pushed the patch to lmo's git repository.

  Ralf
