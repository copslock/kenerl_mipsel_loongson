Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2003 02:25:53 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:31498 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225460AbTJ3CZv>;
	Thu, 30 Oct 2003 02:25:51 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id h9U26eA29901;
	Wed, 29 Oct 2003 21:06:40 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h9U2P5a24668;
	Wed, 29 Oct 2003 21:25:05 -0500
Received: from unused (vpn26-1.sfbay.redhat.com [172.16.26.1])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id h9U2P4J16789;
	Wed, 29 Oct 2003 18:25:04 -0800
Subject: Re: Huge dynamically linked program does not run on mips-linux
From: Eric Christopher <echristo@redhat.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Jun Sun <jsun@mvista.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
In-Reply-To: <20031030015353.GE1486@rembrandt.csv.ica.uni-stuttgart.de>
References: <20031022.171118.88468465.nemoto@toshiba-tops.co.jp>
	 <20031029.163201.39178653.nemoto@toshiba-tops.co.jp>
	 <20031029101400.J30683@mvista.com> <20031029181516.GA14443@nevyn.them.org>
	 <20031030015353.GE1486@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain
Message-Id: <1067480704.2542.8.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 29 Oct 2003 18:25:04 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> When building python-qt3 on debian unstable I get an oversize GOT and:
> 
> /usr/bin/ld: BFD 2.14.90.0.6 20030820 Debian GNU/Linux assertion fail ../../bfd/elfxx-mips.c:2287
> 
> Seems like multi-GOT is broken for this case.

Judging from the line offset from today's sources to that error message
it might have been fixed with rsandifo's last patch that fixed an
uninitialized variable problem. (global_gotno)

-eric

-- 
Eric Christopher <echristo@redhat.com>
