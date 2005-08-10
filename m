Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2005 20:39:48 +0100 (BST)
Received: from static-151-204-232-50.bos.east.verizon.net ([IPv6:::ffff:151.204.232.50]:39640
	"EHLO mail2.sicortex.com") by linux-mips.org with ESMTP
	id <S8225252AbVHJTj3>; Wed, 10 Aug 2005 20:39:29 +0100
Received: from gs104.sicortex.com (gs104.sicortex.com [10.0.1.104])
	by mail2.sicortex.com (Postfix) with ESMTP id 9CC091BF211
	for <linux-mips@linux-mips.org>; Wed, 10 Aug 2005 15:43:28 -0400 (EDT)
From:	Joshua Wise <mips@joshuawise.com>
To:	linux-mips@linux-mips.org
Subject: Re: SMP spinlocks forever while doing a put_user
Date:	Wed, 10 Aug 2005 15:43:27 -0400
User-Agent: KMail/1.8.1
References: <200508101536.43605.mips@joshuawise.com>
In-Reply-To: <200508101536.43605.mips@joshuawise.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508101543.28175.mips@joshuawise.com>
Return-Path: <mips@joshuawise.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mips@joshuawise.com
Precedence: bulk
X-list: linux-mips

> I'm not sure where this is being held that I'm not seeing it. I guess I
> should probably enable spinlock debugging, although I've tried that once in
> the past and gotten a total of zero spinlock-debug related messages. I'll
> give it another shot, in case I selected the wrong option or some such.
It appears that spinlock debugging was, in fact, already enabled.

joshua
