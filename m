Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2008 16:26:15 +0200 (CEST)
Received: from bay0-omc3-s17.bay0.hotmail.com ([65.54.246.217]:12250 "EHLO
	bay0-omc3-s17.bay0.hotmail.com") by lappi.linux-mips.net with ESMTP
	id S1786583AbYDKO0I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Apr 2008 16:26:08 +0200
Received: from BAY141-W48 ([65.55.152.83]) by bay0-omc3-s17.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Apr 2008 07:25:43 -0700
Message-ID: <BAY141-W485F2B6BCF95F92004A64DC2EF0@phx.gbl>
X-Originating-IP: [61.95.197.134]
From:	POORNIMA R <rpoornar@hotmail.com>
To:	<linux-mips@linux-mips.org>
CC:	<ralf@linux-mips.org>
Subject: [MIPS]hrt implementation on MIPS
Date:	Fri, 11 Apr 2008 14:25:43 +0000
Importance: Normal
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 11 Apr 2008 14:25:43.0655 (UTC) FILETIME=[ED043F70:01C89BDF]
Return-Path: <rpoornar@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpoornar@hotmail.com
Precedence: bulk
X-list: linux-mips



Hi,

I am a newbie to MIPS architecture. I am working on MIPS architecture and my kernel version is vanilla linux-2.6.18.
I  wanted to know whether High resolution timer implemented is done for MIPS?
If it is implemented is it implemented as a part of existing timer sub-system or as a seperate sub-system?
and how do I check HRT imlemenation?

Poornima
_________________________________________________________________
Technology : Catch up on updates on the latest Gadgets, Reviews, Gaming and Tips to use technology etc.
http://computing.in.msn.com/
From rpoornar@hotmail.com Fri Apr 11 16:26:39 2008
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2008 16:26:46 +0200 (CEST)
Received: from bay0-omc3-s22.bay0.hotmail.com ([65.54.246.222]:47333 "EHLO
	bay0-omc3-s22.bay0.hotmail.com") by lappi.linux-mips.net with ESMTP
	id S1786584AbYDKO0I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Apr 2008 16:26:08 +0200
Received: from BAY141-W20 ([65.55.152.55]) by bay0-omc3-s22.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Apr 2008 07:25:43 -0700
Message-ID: <BAY141-W20230983BB721CEFFD0670C2EF0@phx.gbl>
X-Originating-IP: [61.95.197.134]
From:	POORNIMA R <rpoornar@hotmail.com>
To:	<linux-mips@linux-mips.org>
CC:	<ralf@linux-mips.org>
Subject: [MIPS]hrt implementation on MIPS
Date:	Fri, 11 Apr 2008 14:25:43 +0000
Importance: Normal
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 11 Apr 2008 14:25:43.0636 (UTC) FILETIME=[ED015940:01C89BDF]
Return-Path: <rpoornar@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18897
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpoornar@hotmail.com
Precedence: bulk
X-list: linux-mips
Content-Length: 554
Lines: 12



Hi,

I am a newbie to MIPS architecture. I am working on MIPS architecture and my kernel version is vanilla linux-2.6.18.
I  wanted to know whether High resolution timer implemented is done for MIPS?
If it is implemented is it implemented as a part of existing timer sub-system or as a seperate sub-system?
and how do I check HRT imlemenation?

Poornima
_________________________________________________________________
Technology : Catch up on updates on the latest Gadgets, Reviews, Gaming and Tips to use technology etc.
http://computing.in.msn.com/
From rpoornar@hotmail.com Fri Apr 11 16:33:31 2008
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2008 16:33:36 +0200 (CEST)
Received: from bay0-omc3-s9.bay0.hotmail.com ([65.54.246.209]:32896 "EHLO
	bay0-omc3-s9.bay0.hotmail.com") by lappi.linux-mips.net with ESMTP
	id S1786590AbYDKOdb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Apr 2008 16:33:31 +0200
Received: from BAY141-W52 ([65.55.152.87]) by bay0-omc3-s9.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Apr 2008 07:33:08 -0700
Message-ID: <BAY141-W5221CFA922CACCA7ECC366C2EF0@phx.gbl>
X-Originating-IP: [61.95.197.134]
From:	POORNIMA R <rpoornar@hotmail.com>
To:	<ralf@linux-mips.org>
CC:	<linux-mips@linux-mips.org>
Subject: [MIPS]hrt implementation for mips
Date:	Fri, 11 Apr 2008 14:33:08 +0000
Importance: Normal
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 11 Apr 2008 14:33:08.0314 (UTC) FILETIME=[F60DD3A0:01C89BE0]
Return-Path: <rpoornar@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpoornar@hotmail.com
Precedence: bulk
X-list: linux-mips
Content-Length: 557
Lines: 12



Hi,
 
I am a newbie to MIPS architecture. I am working on MIPS architecture and my kernel version is vanilla linux-2.6.18.
I  wanted to know whether High resolution timer implementation is done for MIPS?
If it is implemented, is it implemented as a part of existing timer sub-system or as a seperate sub-system?
and how do I check HRT implementation?
 
Poornima
_________________________________________________________________
Video: Get a glimpse of the latest in Cricket, Bollywood, News and Fashion. Only on MSN videos.
http://video.msn.com/?mkt=en-in
From rpoornar@hotmail.com Fri Apr 11 16:34:07 2008
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2008 16:34:14 +0200 (CEST)
Received: from bay0-omc3-s23.bay0.hotmail.com ([65.54.246.223]:27248 "EHLO
	bay0-omc3-s23.bay0.hotmail.com") by lappi.linux-mips.net with ESMTP
	id S1786591AbYDKOdb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Apr 2008 16:33:31 +0200
Received: from BAY141-W54 ([65.55.152.89]) by bay0-omc3-s23.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 11 Apr 2008 07:33:07 -0700
Message-ID: <BAY141-W540D8674F884B2B1C129ECC2EF0@phx.gbl>
X-Originating-IP: [61.95.197.134]
From:	POORNIMA R <rpoornar@hotmail.com>
To:	<ralf@linux-mips.org>
CC:	<linux-mips@linux-mips.org>
Subject: [MIPS]hrt implementation for mips
Date:	Fri, 11 Apr 2008 14:33:07 +0000
Importance: Normal
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginalArrivalTime: 11 Apr 2008 14:33:08.0031 (UTC) FILETIME=[F5E2A4F0:01C89BE0]
Return-Path: <rpoornar@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18899
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpoornar@hotmail.com
Precedence: bulk
X-list: linux-mips
Content-Length: 557
Lines: 12



Hi,
 
I am a newbie to MIPS architecture. I am working on MIPS architecture and my kernel version is vanilla linux-2.6.18.
I  wanted to know whether High resolution timer implementation is done for MIPS?
If it is implemented, is it implemented as a part of existing timer sub-system or as a seperate sub-system?
and how do I check HRT implementation?
 
Poornima
_________________________________________________________________
Video: Get a glimpse of the latest in Cricket, Bollywood, News and Fashion. Only on MSN videos.
http://video.msn.com/?mkt=en-in
From ralf@linux-mips.org Fri Apr 11 16:49:37 2008
Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2008 16:49:41 +0200 (CEST)
Received: from oss.sgi.com ([192.48.170.157]:28547 "EHLO oss.sgi.com")
	by lappi.linux-mips.net with ESMTP id S1786620AbYDKOth (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Apr 2008 16:49:37 +0200
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3BEmrOj007011
	for <linux-mips@linux-mips.org>; Fri, 11 Apr 2008 07:48:54 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3BEnWuk012239
	for <linux-mips@linux-mips.org>; Fri, 11 Apr 2008 15:49:32 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3BEnPaI012238
	for linux-mips@linux-mips.org; Fri, 11 Apr 2008 15:49:25 +0100
Date:	Fri, 11 Apr 2008 15:49:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: [MIPS] More server moving ...
Message-ID: <20080411144925.GA12209@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Content-Length: 209
Lines: 5

The linux-mips.org server machine has just been installed in Portugal.
So I'm now going to shut down the temporary services and migrate
services to the real machines.  Thanks for everybody's patience!

  Ralf
