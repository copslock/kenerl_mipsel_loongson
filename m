Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 May 2005 18:31:39 +0100 (BST)
Received: from corvus.et.put.poznan.pl ([IPv6:::ffff:150.254.11.9]:44175 "EHLO
	corvus.et.put.poznan.pl") by linux-mips.org with ESMTP
	id <S8226074AbVE0RbY>; Fri, 27 May 2005 18:31:24 +0100
Received: from corvus (corvus.et.put.poznan.pl [150.254.11.9])
	by corvus.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4RHVGe26296;
	Fri, 27 May 2005 19:31:18 +0200 (MET DST)
Received: from helios.et.put.poznan.pl ([150.254.29.65])
	by corvus.et.put.poznan.pl (MailMonitor for SMTP v1.2.2 ) ;
	Fri, 27 May 2005 19:30:20 +0200 (MET DST)
Received: from localhost (sskowron@localhost)
	by helios.et.put.poznan.pl (8.11.6+Sun/8.11.6) with ESMTP id j4RHUCT25120;
	Fri, 27 May 2005 19:30:12 +0200 (MET DST)
X-Authentication-Warning: helios.et.put.poznan.pl: sskowron owned process doing -bs
Date:	Fri, 27 May 2005 19:30:12 +0200 (MET DST)
From:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
To:	Cameron Cooper <developer@phatlinux.com>
cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@linux-mips.org
Subject: Re: Porting To New System
In-Reply-To: <20050527165949.17623.qmail@server256.com>
Message-ID: <Pine.GSO.4.10.10505271929510.25076-100000@helios.et.put.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <sskowron@ET.PUT.Poznan.PL>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sskowron@ET.PUT.Poznan.PL
Precedence: bulk
X-list: linux-mips

>  Does the firmware give you the ability to control MMU mappings ?

I think we won't - this would be a serious security bug.

Stanislaw
