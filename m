Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2003 02:22:18 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:15891 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225551AbTIWBWQ>;
	Tue, 23 Sep 2003 02:22:16 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id h8N151O12181;
	Mon, 22 Sep 2003 21:05:01 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id h8N1LpD25001;
	Mon, 22 Sep 2003 21:21:51 -0400
Received: from ghostwheel.sfbay.redhat.com (vpn26-5.sfbay.redhat.com [172.16.26.5])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id h8N1Lnw06879;
	Mon, 22 Sep 2003 18:21:49 -0700
Subject: Re: recent binutils and mips64-linux
From: Eric Christopher <echristo@redhat.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Alexandre Oliva <aoliva@redhat.com>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Atsushi Nemoto <nemoto@toshiba-tops.co.jp>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
In-Reply-To: <20030922233952.GR13578@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.GSO.3.96.1030919144141.9134C-100000@delta.ds2.pg.gda.pl>
	 <1063988420.2537.5.camel@ghostwheel.sfbay.redhat.com>
	 <20030919164119.GH13578@rembrandt.csv.ica.uni-stuttgart.de>
	 <ord6ds346n.fsf@free.redhat.lsd.ic.unicamp.br>
	 <20030922233952.GR13578@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain
Message-Id: <1064280106.21720.0.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 22 Sep 2003 18:21:46 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips

On Mon, 2003-09-22 at 16:39, Thiemo Seufer wrote:
> Alexandre Oliva wrote:
> > On Sep 19, 2003, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> wrote:
> > 
> > > A third answer is to add a -msign-extend-addresses switch in the assembler.
> > 
> > In what sense is this different from -Wa,-mabi=n32 ?
> 
> ELF64 instead of ELF32.

objcopy?

-eric

-- 
Eric Christopher <echristo@redhat.com>
