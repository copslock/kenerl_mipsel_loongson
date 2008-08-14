Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Aug 2008 23:06:36 +0100 (BST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:53974 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28596841AbYHNWG2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Aug 2008 23:06:28 +0100
X-IronPort-AV: E=Sophos;i="4.32,211,1217808000"; 
   d="scan'208,223";a="75473665"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-2.cisco.com with ESMTP; 14 Aug 2008 22:06:15 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id m7EM6EdU001281;
	Thu, 14 Aug 2008 15:06:14 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m7EM6AxQ026672;
	Thu, 14 Aug 2008 22:06:10 GMT
Received: from CUPLXSUNDISM01.corp.sa.net ([64.101.21.60]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id WAA28304; Thu, 14 Aug 2008 22:05:46 GMT
Message-ID: <48A4AC39.7020707@sciatl.com>
Date:	Thu, 14 Aug 2008 15:05:45 -0700
From:	C Michael Sundius <Michael.sundius@sciatl.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>,
	Dave Hansen <dave@linux.vnet.ibm.com>
Subject: sparsemem support for mips with highmem
Content-Type: multipart/mixed;
 boundary="------------010403040800010305090501"
Authentication-Results:	sj-dkim-3; header.From=Michael.sundius@sciatl.com; dkim=neutral
Return-Path: <Michael.sundius@sciatl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Michael.sundius@sciatl.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010403040800010305090501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi

I just got sparsemem working on our MIPS 32 platform. I'm not sure if 
anyone
has done that before since there seems to be a couple of problems in the 
arch specific code.

Well I realize that it is blazingly simple to turn on sparsemem, but for 
the idiots (like myself)
out there I created a howto file to put in the Documentation directory 
just because I thought
it would be a good idea to have some official info on  it written down 
somewhere.

it saved me a ton of space by the way.  it seems to work great.

Mike


--------------010403040800010305090501
Content-Type: text/plain;
 name="mypatchfile"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mypatchfile"
