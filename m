Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 14:44:04 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:47104 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493188AbZKWNnk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2009 14:43:40 +0100
Received: by bwz21 with SMTP id 21so5010703bwz.24
        for <multiple recipients>; Mon, 23 Nov 2009 05:43:33 -0800 (PST)
Received: by 10.204.48.140 with SMTP id r12mr4697979bkf.112.1258983812824;
        Mon, 23 Nov 2009 05:43:32 -0800 (PST)
Received: from monstr.eu (gw.wifiinternet.cz [89.31.42.6])
        by mx.google.com with ESMTPS id 13sm1092430bwz.2.2009.11.23.05.43.30
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Nov 2009 05:43:31 -0800 (PST)
Message-ID: <4B0A917F.8060000@petalogix.com>
Date:	Mon, 23 Nov 2009 14:43:27 +0100
From:	Michal Simek <michal.simek@petalogix.com>
Reply-To: michal.simek@petalogix.com
User-Agent: Thunderbird 2.0.0.22 (X11/20090625)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org
Subject: Re: linux-next: Tree for November 23
References: <20091123185232.1423c56b.sfr@canb.auug.org.au> <4B0A8841.8090905@petalogix.com> <20091123131932.GA28687@linux-mips.org>
In-Reply-To: <20091123131932.GA28687@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <michal.simek@petalogix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michal.simek@petalogix.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Nov 23, 2009 at 02:04:01PM +0100, Michal Simek wrote:
> 
>>> The microblaze tree still has a build failure for which I reverted a
>>> commit.
>>>
>>> The mips tree gained a conflict against the microblaze tree.
>> It is problem which is caused one my ftrace patch. MIPS ftrace  
>> implementation was first that's why I should solve it. It is easy to fix.
>> I just need to know where mips/mips-for-linux-next branch is.
> 
> Gitweb:  http://www.linux-mips.org/git?p=upstream-sfr.git;a=summary
> Git:     git://www.linux-mips.org/pub/scm/upstream-sfr.git

Thanks,
Michal

> 
>   Ralf 


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
