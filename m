Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2003 07:18:36 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:43230 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8224847AbTAWHSg>;
	Thu, 23 Jan 2003 07:18:36 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h0N5IbG8031502
	for <@external-mail-relay.sgi.com:linux-mips@linux-mips.org>; Wed, 22 Jan 2003 21:18:37 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id SAA02259 for <linux-mips@linux-mips.org>; Thu, 23 Jan 2003 18:18:26 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h0N7Hsws001858
	for <linux-mips@linux-mips.org>; Thu, 23 Jan 2003 18:17:55 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h0N7Hrxf001856
	for linux-mips@linux-mips.org; Thu, 23 Jan 2003 18:17:53 +1100
Date: Thu, 23 Jan 2003 18:17:53 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: linux-mips@linux-mips.org
Subject: sigset_t32 broken?
Message-ID: <20030123071753.GA996@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Hi all,

Cut&paste from linux/asm/mips64/signal.h:

#define _NSIG           128
#define _NSIG_BPW       64
#define _NSIG_WORDS     (_NSIG / _NSIG_BPW)

typedef struct {
        long sig[_NSIG_WORDS];
} sigset_t;

#define _NSIG32         128
#define _NSIG_BPW32     32
#define _NSIG_WORDS32   (_NSIG32 / _NSIG_BPW32)

typedef struct {
        long sig[_NSIG_WORDS32];
} sigset_t32;



Shouldn't those two long's be replaced with u64 and u32
respectively?  Is the second struct really meant to be twice the
size the first?

Cheers,
Andrew
