Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 19:02:06 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:1033 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225579AbTIWSCD>;
	Tue, 23 Sep 2003 19:02:03 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id h8NHiKO21371;
	Tue, 23 Sep 2003 13:44:20 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h8NI1ED21083;
	Tue, 23 Sep 2003 14:01:14 -0400
Received: from ghostwheel.sfbay.redhat.com (vpn26-5.sfbay.redhat.com [172.16.26.5])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id h8NI1Cw19264;
	Tue, 23 Sep 2003 11:01:12 -0700
Subject: Re: recent binutils and mips64-linux
From: Eric Christopher <echristo@redhat.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Alexandre Oliva <aoliva@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
In-Reply-To: <20030923081447.GS13578@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl>
	 <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com>
	 <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de>
	 <ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br>
	 <20030922233952.GR13578@rembrandt.csv.ica.uni-stuttgart.de>
	 <1064280106.21720.0.camel@ghostwheel.sfbay.redhat.com>
	 <20030923081447.GS13578@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain
Message-Id: <1064340070.21720.14.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 23 Sep 2003 11:01:11 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> > 
> > objcopy?
> 
> You mean, let gcc generate n64 code, stuff it in n32 objects, and
> objcopy it back to n64? Well, it may work, but it looks more like
> a test of binutils sign-extension handling than a straightforward
> way of creating kernels to me.
> 
> Besides, as soon as gcc handles 64bit expansions itself we need
> such an option anyway.

I'm still trying to figure out why you are going through such weird
contortions at all. I understand not having an elf64 loader. That's what
the objcopy comment was for, everything else I don't understand. Why not
compile for the abi you want?

-eric

-- 
Eric Christopher <echristo@redhat.com>
