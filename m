Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jan 2008 23:47:42 +0000 (GMT)
Received: from outbound-va3.frontbridge.com ([216.32.180.16]:48270 "EHLO
	outbound4-va3-R.bigfish.com") by ftp.linux-mips.org with ESMTP
	id S28580976AbYAPXrd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jan 2008 23:47:33 +0000
Received: from outbound4-va3.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-va3-R.bigfish.com (Postfix) with ESMTP id CB6A6167B6EF;
	Wed, 16 Jan 2008 23:47:26 +0000 (UTC)
Received: from mail166-va3-R.bigfish.com (si1-va3 [10.7.14.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by outbound4-va3.bigfish.com (Postfix) with ESMTP id C9FF71138067;
	Wed, 16 Jan 2008 23:47:26 +0000 (UTC)
Received: from mail166-va3 (localhost.localdomain [127.0.0.1])
	by mail166-va3-R.bigfish.com (Postfix) with ESMTP id B23CB9819A;
	Wed, 16 Jan 2008 23:47:26 +0000 (UTC)
X-BigFish: V
X-MS-Exchange-Organization-Antispam-Report: OrigIP: 160.33.98.75;Service: EHS
Received: by mail166-va3 (MessageSwitch) id 1200527246716183_29304; Wed, 16 Jan 2008 23:47:26 +0000 (UCT)
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	by mail166-va3.bigfish.com (Postfix) with ESMTP id A48B54005E;
	Wed, 16 Jan 2008 23:47:26 +0000 (UTC)
Received: from mail1.bc.in.sel.sony.com (mail1.bc.in.sel.sony.com [43.144.65.111])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id m0GNlQMw010734;
	Wed, 16 Jan 2008 23:47:26 GMT
Received: from USBMAXIM02.am.sony.com ([43.145.108.26])
	by mail1.bc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id m0GNlQAV009437;
	Wed, 16 Jan 2008 23:47:26 GMT
Received: from usbmaxms05.am.sony.com ([43.145.108.36]) by USBMAXIM02.am.sony.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 16 Jan 2008 18:47:25 -0500
Received: from [43.135.148.120] ([43.135.148.120]) by usbmaxms05.am.sony.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 16 Jan 2008 18:47:25 -0500
Subject: Re: [PATCH 3/4] serial_txx9 driver support
From:	Frank Rowand <frank.rowand@am.sony.com>
Reply-To: frank.rowand@am.sony.com
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20080117.004716.59650985.anemo@mba.ocn.ne.jp>
References: <1200436139.4092.30.camel@bx740>
	 <1200436432.4092.38.camel@bx740>
	 <20080117.004716.59650985.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Date:	Wed, 16 Jan 2008 15:46:21 -0800
Message-Id: <1200527181.3939.12.camel@bx740>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.1 (2.12.1-3.fc8) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jan 2008 23:47:25.0582 (UTC) FILETIME=[2567B2E0:01C8589A]
Return-Path: <Frank_Rowand@sonyusa.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frank.rowand@am.sony.com
Precedence: bulk
X-list: linux-mips


On Thu, 2008-01-17 at 00:47 +0900, Atsushi Nemoto wrote:
> On Tue, 15 Jan 2008 14:33:52 -0800, Frank Rowand <frank.rowand@am.sony.com> wrote:
> > Add polled debug driver support to serial_txx9.c for kgdb, and initialize
> > the driver for the Toshiba RBTX4927.
> 
> I think Jason Wessel's kgdb patchset is a way to go.


Somehow I overlooked Jason's patchset.  Yes, I agree that is the way to go,
so my four patches should not be applied.  Thanks for bringing that to my
attention.

-Frank
