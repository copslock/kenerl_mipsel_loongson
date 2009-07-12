Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Jul 2009 12:39:24 +0200 (CEST)
Received: from gate.ebshome.net ([208.106.21.240]:48082 "EHLO gate.ebshome.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492344AbZGLKjQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 12 Jul 2009 12:39:16 +0200
Received: (qmail 6267 invoked by uid 1000); 12 Jul 2009 03:39:06 -0700
Date:	Sun, 12 Jul 2009 03:39:06 -0700
From:	Eugene Surovegin <ebs@ebshome.net>
To:	joe seb <joe.seb8@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux port failing on MIPS32 24Kc
Message-ID: <20090712103906.GA4019@gate.ebshome.net>
References: <4f9abdc70907080107t28fdac03h86b834a60806fb10@mail.gmail.com> <20090708103756.GB22308@linux-mips.org> <4f9abdc70907080547l501128bg7c920e206e0068c3@mail.gmail.com> <20090708182906.GB31285@cuplxvomd02.corp.sa.net> <4f9abdc70907090405l4cd75251jbee5fbe123690e90@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f9abdc70907090405l4cd75251jbee5fbe123690e90@mail.gmail.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <ebs@ebshome.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebs@ebshome.net
Precedence: bulk
X-list: linux-mips

On Thu, Jul 09, 2009 at 04:35:30PM +0530, joe seb wrote:
> This is a new FPGA based platform which has MIPS 24k core and we are trying
> to bring up linux on this. MIPS cpu is running at 50MHz.

One thing to check is that your FPGA guys used correct memory models 
for caches, etc. We had very "funny" Liux failures when 24K FPGA 
emulation build was using async memories for caches insted of sync 
ones.

-- 
Eugene
