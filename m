Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Mar 2004 15:16:35 +0000 (GMT)
Received: from x1000-57.tellink.net ([IPv6:::ffff:63.161.110.249]:24057 "EHLO
	tibook.netx4.com") by linux-mips.org with ESMTP id <S8225512AbUCLPQe>;
	Fri, 12 Mar 2004 15:16:34 +0000
Received: from embeddededge.com (IDENT:dan@localhost.localdomain [127.0.0.1])
	by tibook.netx4.com (8.11.1/8.11.1) with ESMTP id i2CFHZw00900;
	Fri, 12 Mar 2004 10:17:35 -0500
Message-ID: <4051D48F.5080300@embeddededge.com>
Date: Fri, 12 Mar 2004 10:17:35 -0500
From: Dan Malek <dan@embeddededge.com>
Organization: Embedded Edge, LLC.
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: xavier prabhu <xavier_prabhu@linuxmail.org>
CC: linux-mips@linux-mips.org
Subject: Re: Linux Boot Issue in Au1550
References: <20040312074402.6BE522B2B58@ws5-7.us4.outblaze.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4530
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips

xavier prabhu wrote:

> I'm sorry that the kernel is 2.4.22(linux-14oct2003.tar).

You will have to get the sources from linux-mips.org cvs,
using the linux_2_4 tag.  From ftp.linux-mips.org:/pub/linux/mips/people/ppopov/2.4
get and apply the usb-nonpci-2.4.24.patch and zboot-2.4.25.patch

Use the pb1550 configuration file already in the sources.
You can 'make zImage', then use objcopy to create an srec file you
can tftp load into memory, or make zImage.srec that will create the
file you can place into flash.


	-- Dan
