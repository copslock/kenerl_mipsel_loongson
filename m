Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 01:56:52 +0000 (GMT)
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:14801 "EHLO
	mo00.iij4u.or.jp") by linux-mips.org with ESMTP id <S8226232AbULBB4r>;
	Thu, 2 Dec 2004 01:56:47 +0000
Received: MO(mo00)id iB21uC43004052; Thu, 2 Dec 2004 10:56:12 +0900 (JST)
Received: MDO(mdo01) id iB21uB6Z028090; Thu, 2 Dec 2004 10:56:12 +0900 (JST)
Received: 4UMRO01 id iB21uBR8002349; Thu, 2 Dec 2004 10:56:11 +0900 (JST)
	from rally (localhost [127.0.0.1]) (authenticated)
Date: Thu, 2 Dec 2004 10:56:26 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: "Maciej W. Rozycki" <macro@linux-mips.org>,
	ica2_ts@csv.ica.uni-stuttgart.de
Cc: yuasa@hh.iij4u.or.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] tlbwr hazard for NEC VR4100
Message-Id: <20041202105626.46056a37.yuasa@hh.iij4u.or.jp>
In-Reply-To: <Pine.LNX.4.58L.0412020019050.20966@blysk.ds.pg.gda.pl>
References: <20041201234943.584d88e8.yuasa@hh.iij4u.or.jp>
	<20041202000713.GO3225@rembrandt.csv.ica.uni-stuttgart.de>
	<Pine.LNX.4.58L.0412020019050.20966@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Thu, 2 Dec 2004 00:24:30 +0000 (GMT)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> On Thu, 2 Dec 2004, Thiemo Seufer wrote:
> 
> > If 64bit kernels are ever relevant for VR41xx, you might want to use
> > the same branch trick as it is used for R4[04]00. IIRC it reduced the
> > handler size from 34 to 30 instructions, saving another branch.
> 
>  Isn't that based on specific properties of the R4[04]00 pipeline?  It may
> still work for the VR41xx, but you can't take it for granted, so it should
> be double-checked.  Given the conditions it's probably worth the hassle,
> though.

The specification of VR41xx does not have the guarantee to the branch trick.
Furthermore, VR41xx has the NEC original pipeline.

I think that the present method is exact for VR41xx.

Yoichi
