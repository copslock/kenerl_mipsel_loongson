Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2007 12:03:54 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:38105 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20044139AbXARMDw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Jan 2007 12:03:52 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0IC4rJo004851;
	Thu, 18 Jan 2007 12:04:53 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0IC4qmC004850;
	Thu, 18 Jan 2007 12:04:52 GMT
Date:	Thu, 18 Jan 2007 12:04:52 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	sathesh babu <sathesh_edara2003@yahoo.co.in>
Cc:	linux-mips@linux-mips.org
Subject: Re: Setting Write through mode in linux-2.6.18.2 kernel ( MIPS 24KE)
Message-ID: <20070118120452.GB4440@linux-mips.org>
References: <42504.24060.qm@web7902.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42504.24060.qm@web7902.mail.in.yahoo.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 18, 2007 at 02:33:31AM +0000, sathesh babu wrote:

>     I am porting linux-2.6.18.2 kernel on MIPS 24KE processor.

Strange, I though we already did that years ago ...

>   I would like to configure  write through cache mode.
>    
>   I checked the cache defines ( asm-mips/pgtable-bits.h) .
>    
>   Only write back mode is defined for MIPS32.
>    
>   Does the linux-2.6.18.2 kernel ( on MIPS 24KE) have support for write through mode?.
>   Could you please tell me write through mode is there in linux-2.6.18.2 kernel for MIPS 24KE.

Just set CONF_CM_DEFAULT to the cache mode of choice.

But why would you want to use a slower cache mode anyway ...

  Ralf
