Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2004 03:38:06 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:19721 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225488AbUBWDiA>;
	Mon, 23 Feb 2004 03:38:00 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id i1N3D7i14018;
	Sun, 22 Feb 2004 22:13:07 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i1N3btM24422;
	Sun, 22 Feb 2004 22:37:56 -0500
Received: from [192.168.123.101] (vpn26-9.sfbay.redhat.com [172.16.26.9])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i1N3btX21577;
	Sun, 22 Feb 2004 19:37:55 -0800
Subject: Re: r3000 instruction set
From:	Eric Christopher <echristo@redhat.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Mark and Janice Juszczec <juszczec@hotmail.com>,
	linux-mips@linux-mips.org
In-Reply-To: <001001c3f98e$2270dcc0$10eca8c0@grendel>
References: <Law10-F39hgbi1Kigvf000046ac@hotmail.com>
	 <1077477186.3636.34.camel@dzur.sfbay.redhat.com>
	 <001001c3f98e$2270dcc0$10eca8c0@grendel>
Content-Type: text/plain
Message-Id: <1077507447.3636.37.camel@dzur.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date:	Sun, 22 Feb 2004 19:37:29 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips

On Sun, 2004-02-22 at 13:52, Kevin D. Kissell wrote:
> > Other than the responses you've already gotten, likely you'll need to
> > compile with -march=r3900(or -mcpu=r3900 if it's an old toolchain) since
> > the 3900 is missing a couple of r3000 instructions iirc.
> 
> The 3900 family should run MIPS I code compiled for the R3000.

IIRC there were some standard MIPS I instructions that were not on the
tx39.

-eric

-- 
Eric Christopher <echristo@redhat.com>
