Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 08:07:29 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:10245 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225480AbTKDIHR>;
	Tue, 4 Nov 2003 08:07:17 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id hA47m1A05322;
	Tue, 4 Nov 2003 02:48:01 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id hA486da30064;
	Tue, 4 Nov 2003 03:06:39 -0500
Received: from ghostwheel.sfbay.redhat.com (vpn50-45.rdu.redhat.com [172.16.50.45])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id hA486aJ01301;
	Tue, 4 Nov 2003 00:06:36 -0800
Subject: Re: Huge dynamically linked program does not run on mips-linux
From: Eric Christopher <echristo@redhat.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, jsun@mvista.com,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
In-Reply-To: <20031104.142111.41626869.nemoto@toshiba-tops.co.jp>
References: <20031029181516.GA14443@nevyn.them.org>
	 <20031030015353.GE1486@rembrandt.csv.ica.uni-stuttgart.de>
	 <1067480704.2542.8.camel@ghostwheel.sfbay.redhat.com>
	 <20031104.142111.41626869.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain
Message-Id: <1067933156.3491.5.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 04 Nov 2003 00:05:56 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> eric> Judging from the line offset from today's sources to that error
> eric> message it might have been fixed with rsandifo's last patch that
> eric> fixed an uninitialized variable problem. (global_gotno)
> 
> I tried binutils-2.14.90.0.7 (based on binutils 2003 1029 in CVS) but
> my problem did no solved.  It seems something is still wrong.

This was plain mips-linux? Not mips64-linux?

And where would I find the sources?

-eric

-- 
Eric Christopher <echristo@redhat.com>
