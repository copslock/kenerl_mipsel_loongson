Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Apr 2003 16:36:09 +0100 (BST)
Received: from 154-84-51-66.reonbroadband.com ([IPv6:::ffff:66.51.84.154]:1664
	"EHLO tibook.netx4.com") by linux-mips.org with ESMTP
	id <S8225223AbTDWPgJ>; Wed, 23 Apr 2003 16:36:09 +0100
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id h3NFZWg00877;
	Wed, 23 Apr 2003 11:35:32 -0400
Message-ID: <3EA6B2C4.2000808@embeddededge.com>
Date: Wed, 23 Apr 2003 11:35:32 -0400
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>
CC: Jun Sun <jsun@mvista.com>, Jeff Baitis <baitisj@evolution.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Improperly handled case in arch/mips/au1000/common/time.c
References: <20030422125450.E10148@luca.pas.lab>	 <20030422155625.E28544@mvista.com> <1051052439.2552.352.camel@zeus.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

Pete Popov wrote:

> .... The
> modifications I had to make were such that they couldn't go in the
> generic time.c. But that area definitely needs to be revisited and
> cleaned up.

I've got a bunch of updates to the Au1xxx timer stuff.  I'll send a patch.


	-- Dan
