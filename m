Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 14:04:38 +0100 (BST)
Received: from web25813.mail.ukl.yahoo.com ([217.146.176.246]:62043 "HELO
	web25813.mail.ukl.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133420AbWD1NEa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Apr 2006 14:04:30 +0100
Received: (qmail 71287 invoked by uid 60001); 28 Apr 2006 13:04:17 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=jb5UEwLG8jfBFRHJwIwND+VA7e+Bb7vhhQOgBjF7MNzeR45zasrjaTEr6inZB4keQtf4ip6y1TTqe+HRhTHlxiANwo/55FpAUrx9YNSNhPoGnx3ByXFCK4+yFuFBEAB/wKFvLzR0BQen0+5vko9EiX8MUXa5Cov5ieo/Cmr6T3k=  ;
Message-ID: <20060428130417.71285.qmail@web25813.mail.ukl.yahoo.com>
Date:	Fri, 28 Apr 2006 13:04:17 +0000 (GMT)
From:	moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: module allocation
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <francis_moreau2000@yahoo.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: francis_moreau2000@yahoo.fr
Precedence: bulk
X-list: linux-mips

Hi

Maybe a silly question...why do we use mapped memory (allocated by
vmalloc) for inserting a module into the kernel ?

I can see only drawbacks:

  - It consumes TLB entries,

  - When accessing to the module's code, we use TLB entries which can
    be bad for interrupt latencies. For instance: if the module has an
    interrupt handler and the module's code in still not mapped in the
    TLB, we got a page fault...

  - Modules are usually loaded at startup, at this time the memory
    should not be fragmented.

Thanks
