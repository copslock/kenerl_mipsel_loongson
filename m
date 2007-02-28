Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2007 10:48:49 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:5323 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039296AbXB1Ksr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Feb 2007 10:48:47 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1S2lvOl023942;
	Wed, 28 Feb 2007 02:47:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1S2lusm023941;
	Wed, 28 Feb 2007 02:47:56 GMT
Date:	Wed, 28 Feb 2007 02:47:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	dejo <riamae@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: early_initcall replacement
Message-ID: <20070228024756.GA23519@linux-mips.org>
References: <d28769380702271755u675241b3vb8b265120a2c70ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d28769380702271755u675241b3vb8b265120a2c70ca@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 28, 2007 at 09:55:28AM +0800, dejo wrote:

> Hello! I would like to ask what replaced early_initcall in the 
> 2.6.18.4kernel.

What you need to change is

 o remove the early_initcall() line.
 o rename the function invoked by early_initcall to plat_mem_setup and
   change its prototype to: "void __init plat_mem_setup(void)".

  Ralf
