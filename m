Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2007 12:49:17 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:40718 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20032694AbXKYMtJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Nov 2007 12:49:09 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 10AC9D8E0; Sun, 25 Nov 2007 12:49:02 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 7969A544F2; Sun, 25 Nov 2007 13:48:42 +0100 (CET)
Date:	Sun, 25 Nov 2007 13:48:42 +0100
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	manoj.ekbote@broadcom.com, mark.e.mason@broadcom.com
Subject: BigSur: garbled characters during boot
Message-ID: <20071125124842.GA32479@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

When I boot a current kernel from git on a BigSur board I get some
garbled characters:

Synthesized TLB store handler fastpath (31 instructions).
Synthesized TLB modify handler fastpath (30 instructions).
��͡�х�������ɥ��遚����Bzɑ��遪b�������ѕͥ5R�Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 250436k/257568k available (2561k kernel code, 6940k reserved, 826k data, 132k init, 0k highmem)
Mount-cache hash table entries: 512

Any idea what this might be?
-- 
Martin Michlmayr
http://www.cyrius.com/
