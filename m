Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 19:42:57 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:61961 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225226AbUARTm4>;
	Sun, 18 Jan 2004 19:42:56 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id i0IJJPO31300;
	Sun, 18 Jan 2004 14:19:25 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i0IJgjM28851;
	Sun, 18 Jan 2004 14:42:45 -0500
Received: from [192.168.123.101] (vpn26-3.sfbay.redhat.com [172.16.26.3])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i0IJgib32757;
	Sun, 18 Jan 2004 11:42:44 -0800
Subject: Re: Trouble compiling MIPS cross-compiler
From: Eric Christopher <echristo@redhat.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040118072824.GU22218@rembrandt.csv.ica.uni-stuttgart.de>
References: <200401171711.34964@korath> <200401181510.35686@korath>
	 <400A1B5F.6010307@gentoo.org> <200401181646.04740@korath>
	 <1074409013.3602.16.camel@dzur.sfbay.redhat.com>
	 <20040118072824.GU22218@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain
Message-Id: <1074454861.310.0.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 18 Jan 2004 11:41:02 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4026
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> > b) -mtune otherwise (this will generate generic code and then tune for
> > something)
> 
> Actually, -mtune=r3900 breaks the "generic" part due to an assembler bug
> (and did so for a long time).

Hard to fix it if I don't know about it :)

What's the bug?

-eric

-- 
Eric Christopher <echristo@redhat.com>
