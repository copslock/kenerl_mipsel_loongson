Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Feb 2004 01:22:40 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:19209 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225474AbUBNBWk>;
	Sat, 14 Feb 2004 01:22:40 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id i1E0wAn12068;
	Fri, 13 Feb 2004 19:58:10 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i1E1MbM24028;
	Fri, 13 Feb 2004 20:22:37 -0500
Received: from [192.168.123.101] (vpn26-4.sfbay.redhat.com [172.16.26.4])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i1E1MaX03005;
	Fri, 13 Feb 2004 17:22:36 -0800
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
From: Eric Christopher <echristo@redhat.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	David Daney <ddaney@avtrex.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
In-Reply-To: <20040214011539.GB31847@linux-mips.org>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl>
	 <20040213145316.GA23810@linux-mips.org>
	 <20040213222253.GA20118@rembrandt.csv.ica.uni-stuttgart.de>
	 <402D513F.8080205@avtrex.com>
	 <20040213224959.GB20118@rembrandt.csv.ica.uni-stuttgart.de>
	 <20040214011539.GB31847@linux-mips.org>
Content-Type: text/plain
Message-Id: <1076721727.3773.0.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 13 Feb 2004 17:22:07 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4360
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> It's the gcc generated function epilogue which is the problem.  There's
> no reliable way to work around that ...

What's the problem?

-eric

-- 
Eric Christopher <echristo@redhat.com>
