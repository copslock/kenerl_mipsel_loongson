Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 13:40:26 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:35870 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465586AbWAQNkJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 13:40:09 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0HDhf2Q016076;
	Tue, 17 Jan 2006 13:43:41 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0HDhfno016075;
	Tue, 17 Jan 2006 13:43:41 GMT
Date:	Tue, 17 Jan 2006 13:43:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Kishore K <hellokishore@gmail.com>, linux-mips@linux-mips.org
Subject: Re: gcc -3.4.4 and linux-2.4.32
Message-ID: <20060117134341.GD3336@linux-mips.org>
References: <f07e6e0601160423h5ce1c0d7lcb7e38f8509c4116@mail.gmail.com> <43CBD91B.4020607@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CBD91B.4020607@avtrex.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 16, 2006 at 09:34:19AM -0800, David Daney wrote:

> Not exactly.  It has to do with -funit-at-a-time.  In the 2.4.x kernel 
> it is assumed that gcc will not reorder top level asm statements and 
> functions.  For gcc-3.3.x and earlier this was a valid assumption.  With 
> 3.4.x and later it is not.

This is not the only gcc 3.4 related issue.  Building the 2.4 defconfig
for example will fail.

  Ralf
