Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 17:55:52 +0000 (GMT)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:19 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225316AbTKDRzk>;
	Tue, 4 Nov 2003 17:55:40 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.11.6/8.11.6) with ESMTP id hA4HaFA30587;
	Tue, 4 Nov 2003 12:36:15 -0500
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id hA4Hsoa30313;
	Tue, 4 Nov 2003 12:54:50 -0500
Received: from ghostwheel.sfbay.redhat.com (vpn50-45.rdu.redhat.com [172.16.50.45])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id hA4HsjJ22142;
	Tue, 4 Nov 2003 09:54:45 -0800
Subject: Re: Huge dynamically linked program does not run on mips-linux
From: Eric Christopher <echristo@redhat.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, jsun@mvista.com,
	linux-mips@linux-mips.org, binutils@sources.redhat.com
In-Reply-To: <20031104.200222.70226623.nemoto@toshiba-tops.co.jp>
References: <1067480704.2542.8.camel@ghostwheel.sfbay.redhat.com>
	 <20031104.142111.41626869.nemoto@toshiba-tops.co.jp>
	 <1067933156.3491.5.camel@ghostwheel.sfbay.redhat.com>
	 <20031104.200222.70226623.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain
Message-Id: <1067968386.3491.7.camel@ghostwheel.sfbay.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 04 Nov 2003 09:53:06 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <echristo@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: echristo@redhat.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-11-04 at 03:02, Atsushi Nemoto wrote:
> >>>>> On Tue, 04 Nov 2003 00:05:56 -0800, Eric Christopher <echristo@redhat.com> said:
> >> I tried binutils-2.14.90.0.7 (based on binutils 2003 1029 in CVS)
> >> but my problem did no solved.  It seems something is still wrong.
> 
> eric> This was plain mips-linux? Not mips64-linux?
> 
> Yes.  mips-linux and mipsel-linux target (host is i386).  Both target
> generate broken binary for my test program.
> 
> eric> And where would I find the sources?
> 
> I'm using plain binutils 2.14 and gcc 3.3.2 from gnu.org FTP site,
> binutils 2.14.90.0.7 from
> http://www.kernel.org/pub/linux/devel/binutils/.

I'm using mainline gcc, but I meant the python-qt sources you were
compiling.

-eric

-- 
Eric Christopher <echristo@redhat.com>
