Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Mar 2009 19:39:07 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:9916 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21367141AbZCITjE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Mar 2009 19:39:04 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n29Jd3u6014514;
	Mon, 9 Mar 2009 20:39:03 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n29Jd2e1014504;
	Mon, 9 Mar 2009 20:39:02 +0100
Date:	Mon, 9 Mar 2009 20:39:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Marian Jancar <m.jancar@satca.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: gcc: mips32 vs mips3
Message-ID: <20090309193902.GA993@linux-mips.org>
References: <49B1556E.3030903@satca.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49B1556E.3030903@satca.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 06, 2009 at 05:55:10PM +0100, Marian Jancar wrote:

> which option is supposed to compile faster code, -mips3 or -mips32?

That question doesn't quite make sense.   A MIPS32 processor can't execute
MIPS III code and a MIPS III processor can't execute MIPS32 code.  Only a
MIPS64 processor could execute code compiled for either MIPS32 or MIPS III.
So choose the option to match the architecture of your processor.

  Ralf
