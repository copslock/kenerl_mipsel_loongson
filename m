Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2005 00:42:53 +0100 (BST)
Received: from clock-tower.bc.nu ([IPv6:::ffff:81.2.110.250]:47806 "EHLO
	lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8224922AbVE0Xmi>; Sat, 28 May 2005 00:42:38 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j4RNenDk031720;
	Sat, 28 May 2005 00:40:49 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j4RNenZ6031719;
	Sat, 28 May 2005 00:40:49 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Porting To New System
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Cameron Cooper <developer@phatlinux.com>
Cc:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	linux-mips@linux-mips.org
In-Reply-To: <1117223539.2921.15.camel@phatbox>
References: <Pine.GSO.4.10.10505271929510.25076-100000@helios.et.put.poznan.pl>
	 <1117217584.5743.229.camel@localhost.localdomain>
	 <1117223539.2921.15.camel@phatbox>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117237244.5744.284.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Sat, 28 May 2005 00:40:46 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2005-05-27 at 20:52, Cameron Cooper wrote:
> I've looked into using uClinux, and although it appears as though it
> does support MIPS, it is very hard to find any information on it. Do you
> have any information regarding using uClinux with MIPS?

The 2.6 kernel has uclinux merged but that doesn't include MMUless
support at the moment. The 2.4 uclinux tree is seperate and Xiptech
released a set of patches for 2.4.19 for the mmuless mips and for the
ucLibc if the cpu lacks mipsII and FPU instructions.
