Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 17:57:45 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:61866 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225197AbVDLQ5a>;
	Tue, 12 Apr 2005 17:57:30 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id j3CGvS6t022445
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 12 Apr 2005 18:57:28 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id j3CGvSFc022443;
	Tue, 12 Apr 2005 18:57:28 +0200
Date:	Tue, 12 Apr 2005 18:57:28 +0200
From:	Christoph Hellwig <hch@lst.de>
To:	linux-mips@linux-mips.org
Cc:	linux-cvs@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050412165728.GA22407@lst.de>
References: <20050412140045Z8224988-1340+5602@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412140045Z8224988-1340+5602@linux-mips.org>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Tue, Apr 12, 2005 at 03:00:38PM +0100, ths@linux-mips.org wrote:
> 
> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	ths@ftp.linux-mips.org	05/04/12 15:00:38
> 
> Modified files:
> 	drivers/scsi   : sgiwd93.c 
> Removed files:
> 	drivers/scsi   : sgiwd93.h 
> 
> Log message:
> 	Enable proc support, minor code cleanup.

Haven't seen the diffs, but please don't add new ->proc_info methods.
It's deprecated and will go away in the not very distant future.
