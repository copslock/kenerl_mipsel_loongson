Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jan 2008 23:45:55 +0000 (GMT)
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:25290 "EHLO
	outbound5-sin-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S20033158AbYARXpp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 18 Jan 2008 23:45:45 +0000
Received: from outbound5-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound5-sin-R.bigfish.com (Postfix) with ESMTP id 33EDF1B28CD5;
	Fri, 18 Jan 2008 23:45:22 +0000 (UTC)
Received: from mail87-sin-R.bigfish.com (unknown [10.3.40.3])
	by outbound5-sin.bigfish.com (Postfix) with ESMTP id 13E768B8060;
	Fri, 18 Jan 2008 23:45:22 +0000 (UTC)
Received: from mail87-sin (localhost.localdomain [127.0.0.1])
	by mail87-sin-R.bigfish.com (Postfix) with ESMTP id CFE7FCE8100;
	Fri, 18 Jan 2008 23:45:21 +0000 (UTC)
X-BigFish: V
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 160.33.98.75;Service: EHS
Received: by mail87-sin (MessageSwitch) id 1200699920758599_22561; Fri, 18 Jan 2008 23:45:20 +0000 (UCT)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	by mail87-sin.bigfish.com (Postfix) with ESMTP id C86574A804D;
	Fri, 18 Jan 2008 23:45:19 +0000 (UTC)
Received: from mail1.bc.in.sel.sony.com (mail1.bc.in.sel.sony.com [43.144.65.111])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id m0INjI70004806;
	Fri, 18 Jan 2008 23:45:18 GMT
Received: from USBMAXIM02.am.sony.com ([43.145.108.26])
	by mail1.bc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id m0INjI72006003;
	Fri, 18 Jan 2008 23:45:18 GMT
Received: from usbmaxms05.am.sony.com ([43.145.108.36]) by USBMAXIM02.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 18 Jan 2008 18:45:18 -0500
Received: from [43.135.148.120] ([43.135.148.120]) by usbmaxms05.am.sony.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 18 Jan 2008 18:45:17 -0500
Subject: Re: [PATCH 3/4] serial_txx9 driver support
From:	Frank Rowand <frank.rowand@am.sony.com>
Reply-To: frank.rowand@am.sony.com
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1200436432.4092.38.camel@bx740>
References: <1200436139.4092.30.camel@bx740>
	 <1200436432.4092.38.camel@bx740>
Content-Type: text/plain
Date:	Fri, 18 Jan 2008 15:44:01 -0800
Message-Id: <1200699841.3570.6.camel@bx740>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 (2.12.1-3.fc8) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2008 23:45:17.0548 (UTC) FILETIME=[2DEAC2C0:01C85A2C]
Return-Path: <Frank_Rowand@sonyusa.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.rowand@am.sony.com
Precedence: bulk
X-list: linux-mips


On Tue, 2008-01-15 at 14:33 -0800, Frank Rowand wrote:
> From: Frank Rowand <frank.rowand@am.sony.com>
> 
> Add polled debug driver support to serial_txx9.c for kgdb, and initialize
> the driver for the Toshiba RBTX4927.
> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> ---
>  arch/mips/tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c |    6 	6 +	0 -	0 !
>  drivers/serial/serial_txx9.c                               |   90 	90 +	0 -	0 !
>  2 files changed, 96 insertions(+)

Just for the record...  original attribution is very important.

I meant to mention in the original email, but I overlooked it, that
the serial_txx9.c code is mostly from the kgdb patch version 2.4 at
http://kgdb.linsyssoft.com/downloads.htm with a few slight changes.  The
code is attributed to Ralf in the comments at the head of that patch
file.  I suspect that Ralf recognized his code when I first sent it to
him :-).

-Frank
