Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2009 00:06:31 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43240 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21365813AbZAOAG2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2009 00:06:28 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n0F06QUR004162;
	Thu, 15 Jan 2009 00:06:27 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n0F06PgS004160;
	Thu, 15 Jan 2009 00:06:25 GMT
Date:	Thu, 15 Jan 2009 00:06:25 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Huang Weiyi <weiyi.huang@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: MIPS: remove duplicated #include's
Message-ID: <20090115000625.GA4140@linux-mips.org>
References: <20090115065459.1F13.WEIYI.HUANG@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090115065459.1F13.WEIYI.HUANG@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 15, 2009 at 06:56:46AM +0800, Huang Weiyi wrote:

> Removed duplicated #include's in 
>   arch/mips/cavium-octeon/setup.c
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

Applied after fixing the rejects caused by your whitespace mangling
mail client ...

  Ralf
