Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 13:05:37 +0000 (GMT)
Received: from relay01.mx.bawue.net ([193.7.176.67]:33760 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20039490AbXKTNF3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Nov 2007 13:05:29 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 651DE48BD9;
	Tue, 20 Nov 2007 14:04:53 +0100 (CET)
Received: from ths by lagash with local (Exim 4.68)
	(envelope-from <ths@networkno.de>)
	id 1IuSmZ-00030Q-Vs; Tue, 20 Nov 2007 13:04:51 +0000
Date:	Tue, 20 Nov 2007 13:04:51 +0000
From:	Thiemo Seufer <ths@networkno.de>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: how to use memory before kernel load address?
Message-ID: <20071120130451.GI11996@networkno.de>
References: <50c9a2250711191706g40744ab2w2027124c4bc8dbbb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250711191706g40744ab2w2027124c4bc8dbbb@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

zhuzhenhua wrote:
> hello,all
>           i want to place my kernel loadaddr=0x81008000 and set
> EBASE=0x81000000, it workes.
>          but there is still some memory usable before 0x81000000, for
> example from 0x80100000 ~ 0x80200000

The obvious thing to do seems to set LOARADDR to 0x80208000.

>          i have try to pass param as mem=1M@1M mem=16M@16M  to the kernel,
> it seems only take the 0x8000000 ~ kernel_end as reserved.
>          is there any other options to set the memory useable? ( my kernel
> version is 2.6.14)
>          thanks for any hints

AFAIR the kernel assumes to occupy the lowest addresses of the usable RAM.


Thiemo
