Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Mar 2007 23:29:23 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:2206 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038411AbXCDX3W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 4 Mar 2007 23:29:22 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l24NRWXs025650;
	Sun, 4 Mar 2007 23:27:32 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l24NRVuI025649;
	Sun, 4 Mar 2007 23:27:31 GMT
Date:	Sun, 4 Mar 2007 23:27:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building 64 bit kernel on Cobalt
Message-ID: <20070304232731.GA25039@linux-mips.org>
References: <45EB53D5.8060007@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45EB53D5.8060007@jg555.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 04, 2007 at 03:18:45PM -0800, Jim Gifford wrote:

> Last working Kernel was 2.6.19 series.
> 
> Some changes from 2.6.19 and the 2.6.20 make it impossible to build a 64 
> bit kernel to boot on the cobalt. Ya, I know why, building a N32 
> actually but need a 64 bit kernel in order to do that. Anyone got any 
> suggestions. Looking through the difference between the kernels to 
> figure this out, but it's like looking for a needle in a haystack. Any 
> suggestions as to a starting point?

Try git-bisect to track down the changeset that broke things.

  Ralf
