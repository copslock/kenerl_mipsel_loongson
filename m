Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 21:29:02 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:28426 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225376AbTIWU3A>;
	Tue, 23 Sep 2003 21:29:00 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id h8NKBLO27433;
	Tue, 23 Sep 2003 16:11:21 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h8NKSFD29503;
	Tue, 23 Sep 2003 16:28:16 -0400
Received: from ghostwheel.sfbay.redhat.com (vpn26-5.sfbay.redhat.com [172.16.26.5])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id h8NKS4w27385;
	Tue, 23 Sep 2003 13:28:04 -0700
Subject: Re: recent binutils and mips64-linux
From: Eric Christopher <echristo@redhat.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Zack Weinberg <zack@codesourcery.com>,
	Alexandre Oliva <aoliva@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
In-Reply-To: <20030923200337.GE18698@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl>
	 <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com>
	 <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de>
	 <ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br>
	 <20030922233952.GR13578@rembrandt.csv.ica.uni-stuttgart.de>
	 <1064280106.21720.0.camel@ghostwheel.sfbay.redhat.com>
	 <20030923081447.GS13578@rembrandt.csv.ica.uni-stuttgart.de>
	 <1064340070.21720.14.camel@ghostwheel.sfbay.redhat.com>
	 <20030923181659.GA30037@nevyn.them.org> <87eky7b867.fsf@codesourcery.com>
	 <20030923200337.GE18698@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain
Message-Id: <1064348883.21720.16.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 23 Sep 2003 13:28:03 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips


> > that tells gcc to do the right thing in the first place?
> 
> Gcc still generates MIPS assembler macros, so such a switch would
> do nothing yet. Gcc should be changed to do the expansion itself
> (and improve code quality by that), but that's a much larger task.

And is done in mainline.

.set nomacro, .set noreorder provided you have a gas that can deal with
it on the function level.

-eric

-- 
Eric Christopher <echristo@redhat.com>
