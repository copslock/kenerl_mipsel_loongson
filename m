Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jan 2009 18:58:10 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35544 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21103358AbZA0S6H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Jan 2009 18:58:07 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0RIw3Xu005155;
	Tue, 27 Jan 2009 18:58:04 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0RIvxAp005151;
	Tue, 27 Jan 2009 18:57:59 GMT
Date:	Tue, 27 Jan 2009 18:57:59 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Laurent GUERBY <laurent@guerby.net>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>,
	Debian MIPS <debian-mips@lists.debian.org>
Subject: Re: IP35 Origin 300/3000 support?
Message-ID: <20090127185759.GA2234@linux-mips.org>
References: <1233078550.17541.573.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1233078550.17541.573.camel@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 27, 2009 at 06:49:10PM +0100, Laurent GUERBY wrote:

> The wiki page:
> 
> http://www.linux-mips.org/wiki/IP35
> 
> states "IP35 is not yet supported by Linux. A port initially targeting
> only the Origin 300 has been started".
> 
> The last edit of the wiki was in 2007, does anyone know if it is now
> supported by Linux/Debian?

No; the page accurately reflects the status of kernel development where I
stopped.

> Would access to hardware help?

Only to a limited degree - the project has currently not yet reached the
stage where access to more hardware would really be useful.  But before
somebody dumps the hardware I can be convinced to give it a good home :-)
At some point having access to more configurations will be essential -
dealing with different configurations on Origin class hardware is very
complex.  My current hardware is a single module, Origin 300 with
4 R10000 CPUs.

  Ralf
