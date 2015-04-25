Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Apr 2015 17:56:41 +0200 (CEST)
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:43299 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011137AbbDYP4kRdcA3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Apr 2015 17:56:40 +0200
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-11v.sys.comcast.net with comcast
        id LFwZ1q0022VvR6D01FwZtm; Sat, 25 Apr 2015 15:56:33 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-19v.sys.comcast.net with comcast
        id LFwY1q00142s2jH01FwYNm; Sat, 25 Apr 2015 15:56:33 +0000
Message-ID: <553BB91C.3010308@gentoo.org>
Date:   Sat, 25 Apr 2015 11:56:12 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: MIPS: BUG() in isolate_lru_pages in mm/vmscan.c?
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1429977393;
        bh=ky9n2r2T/EhVQcR3AKdRqfYM0eib+QRpI4Uan2xryrY=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=rnXea+TyQMaltyOjJ9GNSxvLEP5we1m0vkN8+aGavoY4py5uy1S6MDc+W75mCGaXG
         hlEnRUmPWyXBDvOid3VnBqlVZE0Ji4PvCeLgPisiKvkIyoA0LNvsYr/hL5/epGaL2r
         jUo8zHqLI8EH1rtr21pFdcqlj1Bs7MyP64SHsi6WFC5dZ40Kb/S/cbUitSoXJj1Nt3
         7MpZZ5CHDo/mL8zclWvAFTGCcBXIpD6h5xnN9BGL53QBTOSqU5tCjT9Zz2jFH+Do8c
         UNzwDpaszpPWQTtb266/HMLq8mt3PyBADM2FoWAuP9OZoD8gThXBiEwdo0JMFuZKgf
         oRPVbTpdjb46g==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

I keep tripping up a BUG() in isolate_lru_pages in mm/vmscan.c:1345:

	switch (__isolate_lru_page(page, mode)) {
	case 0:
		nr_pages = hpage_nr_pages(page);
		mem_cgroup_update_lru_size(lruvec, lru, -nr_pages);
		list_move(&page->lru, dst);
		nr_taken += nr_pages;
		break;

	case -EBUSY:
		/* else it is being freed elsewhere */
		list_move(&page->lru, src);
		continue;

	default:
		BUG();
	}

This is on an SGI Onyx2 platform (MIPS, IP27), two node boards (4x R14000
CPUs), and 8G of RAM.  The problem appears tied to heavy disk I/O, typically
writes.  I can reproduce sometimes with a long bonnie++ run, but I haven't
gotten a recent panic() message under 4.0 yet.  Most of the time, it silently
hardlocks.  I only have serial console access at 9600bps, so it may lock too
fast before the serial driver can dump the panic.

Is there any information behind the purpose or triggers of this BUG()?  I went
back in git all the way to the initial 2006 commit that added this function,
but could not find any comments or explanation of just what it's protecting
against.  That makes it hard to know where to start debugging.

I've already tried switching filesystems, first ext4, now XFS.  Enabling
CONFIG_NUMA seems to make it harder to trigger, but that's not an objective
observation.  An md RAID resync doesn't appear to trigger it either.

Help?
