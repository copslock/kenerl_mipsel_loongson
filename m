Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Dec 2003 15:17:23 +0000 (GMT)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:1988 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225269AbTL3PRV>;
	Tue, 30 Dec 2003 15:17:21 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id AAA23432;
	Wed, 31 Dec 2003 00:17:08 +0900 (JST)
Received: 4UMDO01 id hBUFH8V00636; Wed, 31 Dec 2003 00:17:08 +0900 (JST)
Received: 4UMRO00 id hBUFH4x24770; Wed, 31 Dec 2003 00:17:07 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Wed, 31 Dec 2003 00:17:01 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Dimitri Torfs <dimitri@sonycom.com>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: supported systems running on 2.6 ?
Message-Id: <20031231001701.4c43637b.yuasa@hh.iij4u.or.jp>
In-Reply-To: <20031230144904.GA10358@sonycom.com>
References: <20031230144904.GA10358@sonycom.com>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Tue, 30 Dec 2003 15:49:04 +0100
Dimitri Torfs <dimitri@sonycom.com> wrote:

> Hi,
> 
>   are there already MIPS systems running on 2.6.0 ? If so, which ones
>   ? I'm currently porting a VR41xx based configuration from 2.4.24 to
>   2.6.0: boot sequence seems to be OK, but the init process doesn't
>   come up (it looks like its not properly laid out in memory, thus
>   continuously generating exceptions (do_signal()) ...). Is it too
>   soon to expect it to work ?

Which Vr41xx's configuration did you use?

Yoichi
