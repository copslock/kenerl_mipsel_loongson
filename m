Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 13:03:28 +0100 (BST)
Received: from p508B5981.dip.t-dialin.net ([IPv6:::ffff:80.139.89.129]:2779
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225219AbTDXMD1>; Thu, 24 Apr 2003 13:03:27 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3OC3L524051;
	Thu, 24 Apr 2003 14:03:21 +0200
Date: Thu, 24 Apr 2003 14:03:21 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] cpu-probe for VR41XX
Message-ID: <20030424140321.B23716@linux-mips.org>
References: <20030424123520.0dd54d5a.yuasa@hh.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424123520.0dd54d5a.yuasa@hh.iij4u.or.jp>; from yuasa@hh.iij4u.or.jp on Thu, Apr 24, 2003 at 12:35:20PM +0900
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 24, 2003 at 12:35:20PM +0900, Yoichi Yuasa wrote:

> I found a problem in cpu-probe.c .
> NEC VR4100 series do not have ll and sc.

(Please send only one patch per mail - there is no way to tell patch to
apply only one of several patches when piping an email into patch - Thanks)

Thanks for your patch; I've applied it,

  Ralf
