Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 16:00:36 +0200 (CEST)
Received: from [198.163.180.7] ([198.163.180.7]:35282 "HELO
	snog.front.onramp.ca") by linux-mips.org with SMTP
	id <S1122987AbSIQOAf>; Tue, 17 Sep 2002 16:00:35 +0200
Received: (qmail 16186 invoked from network); 17 Sep 2002 14:00:08 -0000
Received: from gateway.hgeng.com (HELO shadowfax.hgeng.com) (199.246.74.82)
  by 0 with SMTP; 17 Sep 2002 14:00:08 -0000
Received: from [192.168.1.6] (dilbert.hgeng.com [192.168.1.6])
	by shadowfax.hgeng.com (8.12.5/8.12.5/Debian-1) with ESMTP id g8HDxnOK003562
	for <linux-mips@linux-mips.org>; Tue, 17 Sep 2002 09:59:49 -0400
Subject: Re: [PATCH] ip22 console selection fixes
From: Michael Hill <mikehill@hgeng.com>
To: linux-mips@linux-mips.org
In-Reply-To: <Pine.SOL.4.30.0209170504320.23947-100000@rocky.oswego.edu>
References: <Pine.SOL.4.30.0209170504320.23947-100000@rocky.oswego.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1032271189.29089.63.camel@dilbert.hgeng.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 17 Sep 2002 09:59:49 -0400
Content-Transfer-Encoding: 7bit
Return-Path: <mikehill@hgeng.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikehill@hgeng.com
Precedence: bulk
X-list: linux-mips

On Tue, 2002-09-17 at 05:11, William Jhun wrote:

> This patch fixes some problems in selecting which console to use on the
> ip22s.

Will's patch restores the missing kernel boot messages in place of the
stationary (friendly but not very descriptive) Tux graphic.

Mike
