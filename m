Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 11:57:40 +0000 (GMT)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:30444 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8225200AbULBL5f>; Thu, 2 Dec 2004 11:57:35 +0000
Received: from vivi.cc.vt.edu (IDENT:mirapoint@evil-vivi.cc.vt.edu [10.1.1.12])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id iB2BskRf027683;
	Thu, 2 Dec 2004 06:54:46 -0500
Received: from [192.168.1.2] (68-232-97-125.chvlva.adelphia.net [68.232.97.125])
	by vivi.cc.vt.edu (MOS 3.4.8-GR)
	with ESMTP id CCQ08077 (AUTH spbecker);
	Thu, 2 Dec 2004 06:57:05 -0500 (EST)
Message-ID: <41AF0327.4060303@gentoo.org>
Date: Thu, 02 Dec 2004 06:57:27 -0500
From: "Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041125)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
CC: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Nigel Stephens <nigel@mips.com>,
	David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de> <16813.39660.948092.328493@doms-laptop.algor.co.uk> <20041201204536.GI3225@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.58L.0412012151210.13579@blysk.ds.pg.gda.pl> <20041201230332.GM3225@rembrandt.csv.ica.uni-stuttgart.de> <16814.52180.502747.597080@doms-laptop.algor.co.uk> <20041202083859.GU3225@rembrandt.csv.ica.uni-stuttgart.de> <41AEFCF8.2020804@gentoo.org> <Pine.LNX.4.58L.0412021151100.11480@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0412021151100.11480@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 2 Dec 2004, Stephen P. Becker wrote:
> 
> 
>>For what it's worth, I'm running 64-bit kernels on my O2 and Indy that 
>>were compiled with gcc 3.4.3, and I have had no problems.
> 
> 
>  Have you used CONFIG_BUILD_ELF64 or not?  The former obviously works for
> me; it's the latter that may cause troubles.
> 
>   Maciej

I have used CONFIG_BUILD_ELF64 for an O2 kernel that booted, but 
typically I just use the -mabi=o64 hack.

Steve
