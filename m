Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 06:58:37 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:28690 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225228AbUARG6h>;
	Sun, 18 Jan 2004 06:58:37 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id i0I6Z9O23224;
	Sun, 18 Jan 2004 01:35:09 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i0I6wWM11989;
	Sun, 18 Jan 2004 01:58:32 -0500
Received: from [192.168.123.101] (vpn26-3.sfbay.redhat.com [172.16.26.3])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i0I6wVb15290;
	Sat, 17 Jan 2004 22:58:31 -0800
Subject: Re: Trouble compiling MIPS cross-compiler
From: Eric Christopher <echristo@redhat.com>
To: Adam Nielsen <a.nielsen@optushome.com.au>
Cc: linux-mips@linux-mips.org
In-Reply-To: <200401181646.04740@korath>
References: <200401171711.34964@korath> <200401181510.35686@korath>
	 <400A1B5F.6010307@gentoo.org>  <200401181646.04740@korath>
Content-Type: text/plain
Message-Id: <1074409013.3602.16.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 17 Jan 2004 22:56:54 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> If I copy the command line and change -mcpu to -march then it works fine, but 
> this isn't happening automatically for some reason.  Any ideas?  (I tried 
> downgrading to binutils-2.13.xxx but it still gave the error, so I'm guessing 
> it's a gcc problem - oh how much easier life would be if they didn't remove 
> the -mcpu option somewhere along the way ;-))

Actually, I removed it :)

If you'd like the rant behind it I'll mail it privately.

Anyhow, I've been trying to push for the kernel to use either

a) -march depending on whatever cpu is specified
b) -mtune otherwise (this will generate generic code and then tune for
something)

heck. if you do nothing you'll get mips1 code. It should really default
to mips2 (for things like, say, atomic operations), but no one has made
the change and I don't feel strongly enough since I'm using a 64-bit cpu
and n32 :)

-eric

-- 
Eric Christopher <echristo@redhat.com>
