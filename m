Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2005 19:37:58 +0100 (BST)
Received: from alg138.algor.co.uk ([62.254.210.138]:64676 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133576AbVI1Shn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Sep 2005 19:37:43 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8SIbWQA018887;
	Wed, 28 Sep 2005 20:37:32 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8SIbVEU018886;
	Wed, 28 Sep 2005 19:37:31 +0100
Date:	Wed, 28 Sep 2005 19:37:31 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	oski <oski2001@hotmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Compiling a kernel for ibm z50
Message-ID: <20050928183731.GA18480@linux-mips.org>
References: <BAY101-DAV76EF721B0CFCE85875AC3D28A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY101-DAV76EF721B0CFCE85875AC3D28A0@phx.gbl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 27, 2005 at 06:19:51PM +0100, oski wrote:

> This is my set up:
> -An old Pentium II box with Redhat 8
> -Downloaded linux-2.6.13.mipscvs-20050904 from www.longlandclan...and bzip2
> and tar into /usr/src.
> -Installed the mipsel crosscompiler from MIPS SDE
> -After make config, when trying to make dep, I get a warning: make dep is
> unnecessary now.
> -Doing a ls arch/mips/boot I get a file called "compressed" with only a
> folder called "CVS" .

That's because who made that tarball didn't know his way around CVS enough
to supply a -P option.  Nothing to worry, just extra clutter.

  Ralf
