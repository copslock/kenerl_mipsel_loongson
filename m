Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2005 11:26:45 +0000 (GMT)
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:21646 "EHLO
	gw02.mail.saunalahti.fi") by ftp.linux-mips.org with ESMTP
	id S8133769AbVKAL0Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 1 Nov 2005 11:26:24 +0000
Received: from tori.tal.org (tori.tal.org [195.16.220.82])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 62CA2D5D9E
	for <linux-mips@linux-mips.org>; Tue,  1 Nov 2005 13:26:57 +0200 (EET)
Date:	Tue, 1 Nov 2005 13:28:48 +0200 (EET)
From:	Kaj-Michael Lang <milang@tal.org>
To:	linux-mips@linux-mips.org
Subject: Working XZ console
Message-ID: <Pine.LNX.4.61.0511011320140.11207@tori.tal.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

Hi

This is the first ever e-mail written using local XZ console on a Indigo2!

The driver is 99% working, I've tested running links, pine and nano
and all display correctly. The only bug that I know of is in normal 
console mode, the last line won't get cleared when scrolling.

The code is mess right now, but I'll post it after I've cleaned it up.

If anyone with a XZ would like to try it, download the ip22 kernel from
http://home.tal.org/~milang/o2/kernels/

Please post success/failure stories.

-- 
Kaj-Michael Lang
