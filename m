Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2004 21:36:58 +0100 (BST)
Received: from verein.lst.de ([IPv6:::ffff:213.95.11.210]:35542 "EHLO
	mail.lst.de") by linux-mips.org with ESMTP id <S8225208AbUHKUgy>;
	Wed, 11 Aug 2004 21:36:54 +0100
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-6.6) with ESMTP id i7BKar95005708
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 11 Aug 2004 22:36:53 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id i7BKar6d005706;
	Wed, 11 Aug 2004 22:36:53 +0200
Date: Wed, 11 Aug 2004 22:36:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux-mips@linux-mips.org
Cc: linux-cvs@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20040811203652.GA5680@lst.de>
References: <20040811202903Z8225206-1530+8297@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811202903Z8225206-1530+8297@linux-mips.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Wed, Aug 11, 2004 at 09:28:58PM +0100, ralf@linux-mips.org wrote:
> 
> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	ralf@ftp.linux-mips.org	04/08/11 21:28:58
> 
> Modified files:
> 	fs/partitions  : sgi.c 
> 
> Log message:
> 	Handle MD array auto-detection in disk volume headers.

Note that adding more autodetection has been rejected for mainline
multiple times.
