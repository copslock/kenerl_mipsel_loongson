Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 07:19:41 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:17415 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225228AbUARHTl>;
	Sun, 18 Jan 2004 07:19:41 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id i0I6uFO24266;
	Sun, 18 Jan 2004 01:56:15 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i0I7JcM13238;
	Sun, 18 Jan 2004 02:19:38 -0500
Received: from [192.168.123.101] (vpn26-3.sfbay.redhat.com [172.16.26.3])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i0I7Jbb15858;
	Sat, 17 Jan 2004 23:19:37 -0800
Subject: Re: Trouble compiling MIPS cross-compiler
From: Eric Christopher <echristo@redhat.com>
To: kumba@gentoo.org
Cc: linux-mips@linux-mips.org
In-Reply-To: <400A3353.6050903@gentoo.org>
References: <200401171711.34964@korath> <200401181510.35686@korath>
	 <400A1B5F.6010307@gentoo.org> <200401181646.04740@korath>
	 <400A3353.6050903@gentoo.org>
Content-Type: text/plain
Message-Id: <1074410279.3602.18.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 17 Jan 2004 23:17:59 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> -mips[1234] as a synonym), although if you use a recent kernel source 
> tree off linux-mips anoncvs, selecting the right CPU/Machinetype in 
> menuconfig will supply the proper -march/-mipsX commands to the 
> compiler.  You'll also want to pass something like this:

Hey, cool. Glad to hear that.

-eric

-- 
Eric Christopher <echristo@redhat.com>
