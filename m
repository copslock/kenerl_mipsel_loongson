Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 11:59:30 +0100 (BST)
Received: from gateway11.websitewelcome.com ([70.85.130.22]:37847 "HELO
	gateway11.websitewelcome.com") by ftp.linux-mips.org with SMTP
	id S20022709AbZCaK7Z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 11:59:25 +0100
Received: (qmail 14522 invoked from network); 31 Mar 2009 11:00:39 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway11.websitewelcome.com with SMTP; 31 Mar 2009 11:00:39 -0000
Received: from [217.109.65.213] (port=1526 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1Lobgf-00074W-Hp
	for linux-mips@linux-mips.org; Tue, 31 Mar 2009 05:59:21 -0500
Message-ID: <49D1F78C.90501@paralogos.com>
Date:	Tue, 31 Mar 2009 12:59:24 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Linux MIPS org <linux-mips@linux-mips.org>
Subject: PATCH for SMTC: Update CP0 access macros
Content-Type: multipart/mixed;
 boundary="------------070001080009090005070202"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------070001080009090005070202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Commit ae462c65c5bad2d815cf3f0f3de36ee5187c72d8 changed the return value
semantics of some macros in their base versions, but not in the SMTC
variants.  The attached patch fixes this.

          Regards,

          Kevin K.

--------------070001080009090005070202
Content-Type: text/plain;
 name="0001-Bring-SMTC-up-to-date-on-set-clear-change_c0_-retu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Bring-SMTC-up-to-date-on-set-clear-change_c0_-retu.patc";
 filename*1="h"
