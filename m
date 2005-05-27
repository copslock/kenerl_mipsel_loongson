Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2005 00:15:01 +0100 (BST)
Received: from clock-tower.bc.nu ([IPv6:::ffff:81.2.110.250]:9150 "EHLO
	lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8224893AbVE0XOp>; Sat, 28 May 2005 00:14:45 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j4RNComP031637;
	Sat, 28 May 2005 00:12:50 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j4RNCnd2031636;
	Sat, 28 May 2005 00:12:49 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Porting To New System
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc:	Cameron Cooper <developer@phatlinux.com>, linux-mips@linux-mips.org
In-Reply-To: <Pine.GSO.4.10.10505272130200.1499-100000@helios.et.put.poznan.pl>
References: <Pine.GSO.4.10.10505272130200.1499-100000@helios.et.put.poznan.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117235565.5730.255.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Sat, 28 May 2005 00:12:47 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Gwe, 2005-05-27 at 20:43, Stanislaw Skowronek wrote:
> Rest assured, there will be no MMU interface. 

You seem remarkably confident for someone who has never taken one apart.
There are numerous ways to present an MMU interface without allowing
arbitary system access providing you do it via the core OS rather than
via the hardware. This is how Xen handles x86 and the same can be done
by other systems.
