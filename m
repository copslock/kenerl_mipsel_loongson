Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Feb 2003 00:52:54 +0000 (GMT)
Received: from 66-122-194-201.ded.pacbell.net ([IPv6:::ffff:66.122.194.201]:43652
	"EHLO localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225261AbTBFAwy>; Thu, 6 Feb 2003 00:52:54 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.5/8.12.5) with ESMTP id h160Tew6002587
	for <linux-mips@linux-mips.org>; Wed, 5 Feb 2003 16:29:40 -0800
Received: (from lindahl@localhost)
	by localhost.localdomain (8.12.5/8.12.5/Submit) id h160TdIE002585
	for linux-mips@linux-mips.org; Wed, 5 Feb 2003 16:29:39 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Wed, 5 Feb 2003 16:29:39 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: hidden bug in 32 bit kernel ejtag
Message-ID: <20030206002939.GA2560@greglaptop.internal.keyresearch.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20030124141524.GA685@excalibur.cologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030124141524.GA685@excalibur.cologne.de>
User-Agent: Mutt/1.4i
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

While inspecting the 2.4 cvs kernel, I saw that arch/mips/kernel/head.S
does not have a .align for ejtag_debug_buffer -- just a ".fill 4".
The alignment happens to be correct, I guess since it's the first
.data segment item in the file, but anyone rearranging the code could
trigger a misalignment, which causes an unaligned trap inside an
exception... try debugging that one. (OK, I got lucky...)

The 64 bit cvs kernel doesn't yet have this ejtag stuff in it. 2.5
looks the same as 2.4.

-- greg
