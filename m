Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 11:30:58 +0000 (GMT)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:44503 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8225074AbULBLax>; Thu, 2 Dec 2004 11:30:53 +0000
Received: from vivi.cc.vt.edu (IDENT:mirapoint@evil-vivi.cc.vt.edu [10.1.1.12])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id iB2BSMnq019679;
	Thu, 2 Dec 2004 06:28:23 -0500
Received: from [192.168.1.2] (68-232-97-125.chvlva.adelphia.net [68.232.97.125])
	by vivi.cc.vt.edu (MOS 3.4.8-GR)
	with ESMTP id CCQ04524 (AUTH spbecker);
	Thu, 2 Dec 2004 06:30:42 -0500 (EST)
Message-ID: <41AEFCF8.2020804@gentoo.org>
Date: Thu, 02 Dec 2004 06:31:04 -0500
From: "Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041125)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
CC: Dominic Sweetman <dom@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Nigel Stephens <nigel@mips.com>, David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de> <16813.39660.948092.328493@doms-laptop.algor.co.uk> <20041201204536.GI3225@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.58L.0412012151210.13579@blysk.ds.pg.gda.pl> <20041201230332.GM3225@rembrandt.csv.ica.uni-stuttgart.de> <16814.52180.502747.597080@doms-laptop.algor.co.uk> <20041202083859.GU3225@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20041202083859.GU3225@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips


>>And what constraints are there on
>>your choice of gcc version? - it would be easier if 3.4 was OK.
> 
> 
> 3.2/3.3 are known to work. 3.4 fails for yet unknown reason, I guess
> either due to inline assembler changes or more agressive dead code
> elimination.
> 
> 
> Thiemo

For what it's worth, I'm running 64-bit kernels on my O2 and Indy that 
were compiled with gcc 3.4.3, and I have had no problems.

Steve
