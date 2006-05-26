Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 21:15:39 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:24024 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133836AbWEZTPc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 May 2006 21:15:32 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4QJFV4s019153;
	Fri, 26 May 2006 20:15:31 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4QJFUND019152;
	Fri, 26 May 2006 20:15:30 +0100
Date:	Fri, 26 May 2006 20:15:30 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Damian Dimmich <djd20@kent.ac.uk>
Cc:	linux-mips@linux-mips.org
Subject: Re: eisa scsi controller on indigo2
Message-ID: <20060526191530.GA18055@linux-mips.org>
References: <200605261742.52372.djd20@kent.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605261742.52372.djd20@kent.ac.uk>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 26, 2006 at 05:42:52PM +0100, Damian Dimmich wrote:

> Does anyone know if the eisa based compaq (181132-001) Smart Array scsi
> Controller 2CH would work in an sgi system?  I have an indigo 2 at the
> moment and am looking to get a better scsi card into it.  I know the eisa
> bus is not fully supported/tested on the indigo2's, but i would be happy
> to see how far I can get it to work :).
> 
> A different compaq eisa scsi controller would be interesting too.  There seems 
> to be quite a few of those floating around on e-bay.

The EISA support for the Indigo 2 has never been more than rudimentary.
I think right now only PIO cards will work which will exclude about any
decent piece of hardware.

Yes, the driver for the onboard WD33C93 controller is _bad_ and extremly
slow.

  Ralf
