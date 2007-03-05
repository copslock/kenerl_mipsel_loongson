Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 16:22:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:30151 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037605AbXCEQWU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Mar 2007 16:22:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l25GKSi9001831;
	Mon, 5 Mar 2007 16:20:28 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l25GKS0W001829;
	Mon, 5 Mar 2007 16:20:28 GMT
Date:	Mon, 5 Mar 2007 16:20:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Alexander Sirotkin <demiourgos@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: 0 function size
Message-ID: <20070305162028.GA786@linux-mips.org>
References: <c4357ccd0703050619r6b5a7452j6b582687bf1794d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4357ccd0703050619r6b5a7452j6b582687bf1794d3@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 05, 2007 at 04:19:18PM +0200, Alexander Sirotkin wrote:

> I'm trying to see the function sizes for some object file compiled for
> MIPS. On x86 one can use objdump  or readelf to see the sizes, however
> for same weird reason on MIPS these routines show 0 for all functions.
> 
> Any idea what I'm missing ?

Works fine here:

801f3f10 l     F .text  00000074 rekey_seq_generator
80327f2c l     O .data  00000028 rekey_work
80345dd0 l     F .init.text     00000020 seqgen_init
801f3fd0 l     F .text  000000f4 uuid_strategy
801f40c4 l     F .text  0000012c proc_do_uuid
801f42e0 l     F .text  0000012c extract_entropy_user
801f440c l     F .text  0000000c urandom_read
801f4418 l     F .text  000000fc random_write
801f4514 l     F .text  000001f4 random_ioctl
801f484c l     F .text  00000090 random_poll
801f4ac8 l     F .text  00000190 random_read
80327f64 l     O .data  00000004 sysctl_poolsize

So seems to be a defect with your particular toolchain or objdump or readelf.

  Ralf
