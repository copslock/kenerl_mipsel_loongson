Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2009 23:56:10 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:62929 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21367134AbZBMX4I (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 13 Feb 2009 23:56:08 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n1DNu479032299;
	Fri, 13 Feb 2009 23:56:05 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n1DNu3cH032297;
	Fri, 13 Feb 2009 23:56:03 GMT
Date:	Fri, 13 Feb 2009 23:56:03 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	peter fuerst <post@pfrst.de>
Cc:	naresh kamboju <naresh.kernel@gmail.com>, linux-mips@linux-mips.org
Subject: Re: cacheflush system call-MIPS
Message-ID: <20090213235603.GA32274@linux-mips.org>
References: <f5a7b3810902100716t2658ce95t2dcc7f85634522@mail.gmail.com> <20090211131649.GA1365@linux-mips.org> <Pine.LNX.4.58.0902140002180.408@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0902140002180.408@Indigo2.Peter>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Feb 14, 2009 at 12:50:46AM +0100, peter fuerst wrote:

> there is one more good reason to ... : the Impact Xserver needs to do
> a cacheflush(a,w,DCACHE) as part of the refresh-sequence.
> And hence requires a sys_cacheflush, let's say, more conforming to the
> man-page (or some disgusting new ioctl in the Impact kernel-driver to
> do an equivalent operation ;-)

Why does it need that flush?

  Ralf
