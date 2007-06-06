Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 20:11:29 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:3044 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027113AbXFFTL1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 20:11:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l56J4ZDL010964;
	Wed, 6 Jun 2007 20:04:35 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l56J4YU5010963;
	Wed, 6 Jun 2007 20:04:34 +0100
Date:	Wed, 6 Jun 2007 20:04:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tickless/dyntick kernel, highres timer and general time
	crapectomy
Message-ID: <20070606190434.GA10874@linux-mips.org>
References: <20070606185450.GA10511@linux-mips.org> <46670559.4000907@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46670559.4000907@ru.mvista.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 06, 2007 at 11:04:57PM +0400, Sergei Shtylyov wrote:

> >Particularly Alchemy (and any other system supporting clock scaling) will
> >need some work there since the cp0 count/compare timer are not useful on
> >such systems.
> 
>    Hm, why it's being used then? :-)

From a looks the whole Alchemy power managment code fishy.

  Ralf
