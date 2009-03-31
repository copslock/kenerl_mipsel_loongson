Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 12:11:42 +0100 (BST)
Received: from gateway01.websitewelcome.com ([67.18.66.19]:45451 "HELO
	gateway01.websitewelcome.com") by ftp.linux-mips.org with SMTP
	id S28582982AbZCaLKc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 12:10:32 +0100
Received: (qmail 31651 invoked from network); 31 Mar 2009 11:10:39 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway01.websitewelcome.com with SMTP; 31 Mar 2009 11:10:39 -0000
Received: from [217.109.65.213] (port=1537 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LobrR-0001GR-Aj
	for linux-mips@linux-mips.org; Tue, 31 Mar 2009 06:10:29 -0500
Message-ID: <49D1FA28.4030308@paralogos.com>
Date:	Tue, 31 Mar 2009 13:10:32 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Linux MIPS org <linux-mips@linux-mips.org>
Subject: PATCH for SMTC: Fix Name Collision in _clockevent_init functions
Content-Type: multipart/mixed;
 boundary="------------070601030706030107070108"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070601030706030107070108
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Commit 779e7d41ad004946603da139da99ba775f74cb1c created a name collision
in SMTC builds.  The attached patch corrects this in a a
not-too-terribly-ugly manner.  Note that the SMTC case has to come
first, because CEVT_R4K will also be true.

          Regards,

          Kevin K.

--------------070601030706030107070108
Content-Type: text/plain;
 name="0001-Fix-xxx_clockevent_init-naming-conflict-for-SMTC.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Fix-xxx_clockevent_init-naming-conflict-for-SMTC.patch"
