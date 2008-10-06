Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Oct 2008 21:16:31 +0100 (BST)
Received: from rtp-iport-2.cisco.com ([64.102.122.149]:45635 "EHLO
	rtp-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S20756365AbYJFUQN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Oct 2008 21:16:13 +0100
X-IronPort-AV: E=Sophos;i="4.33,369,1220227200"; 
   d="scan'208,223";a="23386227"
Received: from rtp-dkim-1.cisco.com ([64.102.121.158])
  by rtp-iport-2.cisco.com with ESMTP; 06 Oct 2008 20:15:54 +0000
Received: from rtp-core-2.cisco.com (rtp-core-2.cisco.com [64.102.124.13])
	by rtp-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m96KFsFM029005
	for <linux-mips@linux-mips.org>; Mon, 6 Oct 2008 16:15:54 -0400
Received: from sausatlsmtp1.sciatl.com (sausatlsmtp1.cisco.com [192.133.217.33])
	by rtp-core-2.cisco.com (8.13.8/8.13.8) with ESMTP id m96KFrRF020512
	for <linux-mips@linux-mips.org>; Mon, 6 Oct 2008 20:15:53 GMT
Received: from default.com ([192.133.217.33]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Oct 2008 16:15:53 -0400
Received: from sausatlbhs02.corp.sa.net ([192.133.216.42]) by sausatlsmtp1.sciatl.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Oct 2008 16:15:51 -0400
Received: from CUPLXSUNDISM01.corp.sa.net ([64.101.21.60]) by sausatlbhs02.corp.sa.net with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 6 Oct 2008 16:15:50 -0400
Message-ID: <48EA71F5.1040200@sciatl.com>
Date:	Mon, 06 Oct 2008 13:15:49 -0700
From:	C Michael Sundius <Michael.sundius@sciatl.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Andy Whitcroft <apw@shadowen.org>,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	linux-mips@linux-mips.org, "VomLehn, David" <dvomlehn@cisco.com>,
	me94043@yahoo.com
Subject: Re: Have ever checked in your mips sparsemem code into mips-linux
 tree?
Content-Type: multipart/mixed;
 boundary="------------060208040407070002090605"
X-OriginalArrivalTime: 06 Oct 2008 20:15:50.0923 (UTC) FILETIME=[53DA75B0:01C927F0]
X-ST-MF-Message-Resent:	10/6/2008 16:15
Authentication-Results:	rtp-dkim-1; header.From=Michael.sundius@sciatl.com; dkim=neutral
Return-Path: <michael.sundius@sciatl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Michael.sundius@sciatl.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060208040407070002090605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

adding patch 2  containing Documentation:




     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
--------------060208040407070002090605
Content-Type: text/x-patch;
 name="0002-mips-sparsemem-howto.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-mips-sparsemem-howto.patch"
