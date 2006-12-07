Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2006 09:46:51 +0000 (GMT)
Received: from verein.lst.de ([213.95.11.210]:932 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S20038860AbWLGJqr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2006 09:46:47 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id kB79kesi030447
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Dec 2006 10:46:40 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id kB79kdbj030445;
	Thu, 7 Dec 2006 10:46:39 +0100
Date:	Thu, 7 Dec 2006 10:46:39 +0100
From:	Christoph Hellwig <hch@lst.de>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	mingo@elte.hu
Subject: Re: [MIPS] Import updates from i386's i8259.c
Message-ID: <20061207094639.GA30260@lst.de>
References: <S20037871AbWLFUPw/20061206201552Z+14601@ftp.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <S20037871AbWLFUPw/20061206201552Z+14601@ftp.linux-mips.org>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Wed, Dec 06, 2006 at 08:15:47PM +0000, linux-mips@linux-mips.org wrote:
> Author: Atsushi Nemoto <anemo@mba.ocn.ne.jp> Thu Dec 7 02:04:17 2006 +0900
> Comitter: Ralf Baechle <ralf@linux-mips.org> Wed Dec 6 20:10:54 2006 +0000
> Commit: bf8cfe1360932f191a3ea8d47c773c008ec32cd7
> Gitweb: http://www.linux-mips.org/g/linux/bf8cfe13
> Branch: master
> 
> Import many updates from i386's i8259.c, especially genirq transitions.

Shouldn't we try to share i8259.c over the various architectures that
use this controller?  With the generic hardirq framework that should be
possible.
