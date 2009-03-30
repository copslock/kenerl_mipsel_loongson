Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2009 09:55:19 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:65449 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20035733AbZC3IzR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Mar 2009 09:55:17 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2U8tF24013243;
	Mon, 30 Mar 2009 10:55:15 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2U8tDIV013241;
	Mon, 30 Mar 2009 10:55:13 +0200
Date:	Mon, 30 Mar 2009 10:55:13 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	=?utf-8?B?5p6X5bu65a6J?= <colin@realtek.com.tw>
Cc:	linux-mips@linux-mips.org
Subject: Re: The impact to change page size to 16k for cache alias
Message-ID: <20090330085512.GA10301@linux-mips.org>
References: <9BDA961341E843F29C1C1ECDB54FD0CF@realtek.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9BDA961341E843F29C1C1ECDB54FD0CF@realtek.com.tw>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 30, 2009 at 12:06:51PM +0800, 林建安 wrote:

> Hi all,
> We are willing to use 16k page size to avoid cache alias problem.
> The Linux version we use is 2.6.12. If we just upgrade mm system to 
> support 16k page size, what else problems will happen?
> There is already one thing we know that applications of ELF format  
> applications should be transformed to be 16k alignment.
> Another one, we think, highly suspected to be problematic is that many  
> drivers will be ok for 4k page size but fails for 16k.
> That is because 4k page size had been seemed to be natural for a very 
> long long time.
> Any other problem that shall happen for 16k page size?

Most drivers are agnostic of the page size so no problems due to increased
page size are to be expected.

You will have to upgrade your kernel though.  There were some important
fixes for larger page size applied to later kernels.

  Ralf
