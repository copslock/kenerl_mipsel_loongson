Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 16:39:11 +0100 (WEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:2898 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022422AbZFDPjF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 16:39:05 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a27ea570000>; Thu, 04 Jun 2009 11:37:59 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 4 Jun 2009 08:37:32 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 4 Jun 2009 08:37:32 -0700
Message-ID: <4A27EA3C.2020407@caviumnetworks.com>
Date:	Thu, 04 Jun 2009 08:37:32 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Florian Fainelli <florian@openwrt.org>
CC:	Greg KH <greg@kroah.com>, David Miller <davem@davemloft.net>,
	gregkh@suse.de, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH 0/7] Staging: Octeon-ethernet driver.
References: <4A00DA84.5040101@caviumnetworks.com> <20090603235428.GB19375@kroah.com> <200906040949.53167.florian@openwrt.org>
In-Reply-To: <200906040949.53167.florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Jun 2009 15:37:32.0579 (UTC) FILETIME=[606B1F30:01C9E52A]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Florian Fainelli wrote:
> Le Thursday 04 June 2009 01:54:28 Greg KH, vous avez écrit :
>> On Tue, May 05, 2009 at 05:32:04PM -0700, David Daney wrote:
>>> This patch set introduces the octeon-ethernet driver into the
>>> drivers/staging tree.  The Octeon is a mips64r2 base multi-core SOC
>>> family.
>>>
>>> The first five patches are small tweaks to the existing octeon support
>>> that are required by the ethernet driver.  I would expect them to be
>>> merged via Ralf's linux-mips.org tree.
>>>
>>> The last two are the driver, and would probably be merged via the
>>> drivers/staging tree.  However since they depend on the first five,
>>> they probably shouldn't be merged until those five are merged.
>> Ok, as Ralf doesn't seem to have responded to my previous query, I'll
>> just merge the last driver, and mark it CONFIG_BROKEN which you can turn
>> off when the infrastructure portions go in.
>>
>> Sound reasonable?
> 
> Cannot we get this driver merged via David Miller's tree instead ? It has been 
> rock solid here and does not seem too ugly for a net-next-2.6 inclusion imho.

The driver is not suitable for drivers/net at this time.  I would not 
want to subject David Miller to the ugliness contained within.

Although it does process network packets reliably, it really is only 
suitable for the staging tree at this time.

David Daney.
