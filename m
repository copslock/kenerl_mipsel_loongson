Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Mar 2004 22:00:03 +0000 (GMT)
Received: from rrcs-sw-24-153-140-91.biz.rr.com ([IPv6:::ffff:24.153.140.91]:39052
	"EHLO public.nshore.com") by linux-mips.org with ESMTP
	id <S8224896AbUCLWAC>; Fri, 12 Mar 2004 22:00:02 +0000
Received: from nshore.com (gate.nshore.com [192.168.1.2])
	by public.nshore.com (8.11.6/8.11.6) with ESMTP id i2CLxKc22175;
	Fri, 12 Mar 2004 15:59:21 -0600
Message-ID: <405232DB.5050902@nshore.com>
Date: Fri, 12 Mar 2004 15:59:55 -0600
From: Tahoma Toelkes <tahoma@nshore.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Dan Malek <dan@embeddededge.com>
Subject: zboot patch and linux_2_4 branch [was Re: Linux Boot Issue in Au1550]
References: <20040312074402.6BE522B2B58@ws5-7.us4.outblaze.com> <4051D48F.5080300@embeddededge.com>
In-Reply-To: <4051D48F.5080300@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tahoma@nshore.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tahoma@nshore.com
Precedence: bulk
X-list: linux-mips

Dan Malek wrote:

> You will have to get the sources from linux-mips.org cvs,
> using the linux_2_4 tag.  From 
> ftp.linux-mips.org:/pub/linux/mips/people/ppopov/2.4
> get and apply the usb-nonpci-2.4.24.patch and zboot-2.4.25.patch

I'm having problems applying the zboot patch to the latest and greatest 
from the linux_2_4 branch ("cvs checkout -r linux_2_4 -D 2004-03-12 
linux").  When I try to apply the zboot patch, it rejects the chunk for 
'arch/mips/Makefile'.  However, upon inspection, I am unable to 
determine why it isn't happy with the patch.  Any suggestions?


-- Tahoma


Tahoma M. Toelkes
North Shore Circuit Design, L.L.P.
tahoma@nshore.com
