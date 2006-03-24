Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2006 08:21:46 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:58526 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133529AbWCXIVh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2006 08:21:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k2O8VhZ1031758;
	Fri, 24 Mar 2006 08:31:43 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k2O8VfhK031755;
	Fri, 24 Mar 2006 08:31:41 GMT
Date:	Fri, 24 Mar 2006 08:31:41 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	dhunjukrishna@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Compilation problem with kernel 2.4.16
Message-ID: <20060324083141.GB3170@linux-mips.org>
References: <20060324074521.53361.qmail@web53506.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060324074521.53361.qmail@web53506.mail.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 23, 2006 at 11:45:21PM -0800, Krishna wrote:

>   I have been trying to cross compile Linux/MIPS kernel verison 2.4.16 with the specifix's sibyte cross compiler (sb1-elf cross compilers for x86 linux hosts) for BCM 1480 Broadcom board. I have set the path for cross compiler properly in make file even then the compilation failed. Then we tried adding parameter " -Tcfe.ld" (which is must for compilation) in compilation command (as has been suggested by broadcom) still unble to get it done correctly. Wondering what else we need to change in make file. Or else is there any other cross compiler for BCM 1480 (than specifix one) that we can use. Anyone suggest me the proper way for compiling the kernel with the above cross compiler. 

As posted nobody can help you because you forgot to mention what kind of
error you're seeing, what compiler you're using etc.

Aside of that, 2.4.16 is The Jurassic Kernel.  The thing is now almost
5 years old and I recommend ritually burrying of a hardcopy on the compost
pile in the garden.  Make sure no kernel hacker is watching ;-)

  Ralf
