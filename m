Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 21:27:49 +0100 (BST)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:63399 "EHLO
	sj-iport-4.cisco.com") by ftp.linux-mips.org with ESMTP
	id S8133586AbWDGU1k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2006 21:27:40 +0100
Received: from sj-core-4.cisco.com ([171.68.223.138])
  by sj-iport-4.cisco.com with ESMTP; 07 Apr 2006 13:39:02 -0700
X-IronPort-AV: i="4.04,98,1144047600"; 
   d="scan'208"; a="1792958079:sNHT29455192"
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-4.cisco.com (8.12.10/8.12.6) with ESMTP id k37KcsYq013596
	for <linux-mips@linux-mips.org>; Fri, 7 Apr 2006 13:39:01 -0700 (PDT)
Received: from xmb-sjc-215.amer.cisco.com ([171.70.151.169]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 7 Apr 2006 13:38:55 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Oprofile on sibyte 2.4.18 kernel
Date:	Fri, 7 Apr 2006 13:38:54 -0700
Message-ID: <5547014632ED654F971D7E1E0C2E0C3E018DAFBB@xmb-sjc-215.amer.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Oprofile on sibyte 2.4.18 kernel
Thread-Index: AcZag0lud8MhRbSARI6GHA+OQL7jGw==
From:	"Shanthi Kiran Pendyala \(skiranp\)" <skiranp@cisco.com>
To:	"linux-mips" <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 07 Apr 2006 20:38:55.0766 (UTC) FILETIME=[4A22FB60:01C65A83]
Return-Path: <skiranp@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skiranp@cisco.com
Precedence: bulk
X-list: linux-mips

Hi,

Did anyone port oprofile to 2.4.x kernel on sibyte ?.

Looking over the mailing list threads it looks like it has been given up
as a lost cause.

But business reasons require us to work with 2.4.18 kernel for the next
9-12 months and
We really would like explore a port.

Or are there other tools that I can use ?

Thank you
Shanthi kiran 
