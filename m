Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2003 20:52:46 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:14852 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225310AbTKGUwe>;
	Fri, 7 Nov 2003 20:52:34 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id hA7KX6A07898;
	Fri, 7 Nov 2003 15:33:06 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id hA7Kpqa30043;
	Fri, 7 Nov 2003 15:51:52 -0500
Received: from ghostwheel.sfbay.redhat.com (vpn26-5.sfbay.redhat.com [172.16.26.5])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id hA7KpoJ19291;
	Fri, 7 Nov 2003 12:51:50 -0800
Subject: Re: Huge dynamically linked program does not run on mips-linux
From: Eric Christopher <echristo@redhat.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, jsun@mvista.com,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
In-Reply-To: <20031107164043.GA24269@rembrandt.csv.ica.uni-stuttgart.de>
References: <1067480704.2542.8.camel@ghostwheel.sfbay.redhat.com>
	 <20031104.142111.41626869.nemoto@toshiba-tops.co.jp>
	 <1067933156.3491.5.camel@ghostwheel.sfbay.redhat.com>
	 <20031104.200222.70226623.nemoto@toshiba-tops.co.jp>
	 <1067968386.3491.7.camel@ghostwheel.sfbay.redhat.com>
	 <20031107164043.GA24269@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain
Message-Id: <1068238309.5943.0.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 07 Nov 2003 12:51:49 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> > I'm using mainline gcc, but I meant the python-qt sources you were
> > compiling.
> 
> It was python-qt-3.8 from debian unstable, compiled with
> "gcc (GCC) 3.3.2 (Debian)" and binutils
> "2.14.90.0.7 20031029 Debian GNU/Linux"
> 
> An attempt to link with CVS ld shows the same BFD assertion.

OK. Well, the one machine I have has current sources for gcc and
binutils so I'll be trying that :)

Pointer to a tarball with the sources?

-eric

-- 
Eric Christopher <echristo@redhat.com>
