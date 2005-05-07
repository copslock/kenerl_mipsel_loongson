Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2005 14:09:07 +0100 (BST)
Received: from money.ngit.com ([IPv6:::ffff:207.22.44.49]:20148 "EHLO
	money.ngit.com") by linux-mips.org with ESMTP id <S8226091AbVEGNIv> convert rfc822-to-8bit;
	Sat, 7 May 2005 14:08:51 +0100
Received: from lithium (router.ngit.com [207.22.44.62])
	by money.ngit.com (8.11.7p1+Sun/8.11.7) with ESMTP id j47DB2A06638;
	Sat, 7 May 2005 09:11:02 -0400 (EDT)
From:	"Bogdan Vacaliuc" <bvacaliuc@ngit.com>
To:	<ppopov@embeddedalley.com>,
	"'Ruslan V.Pisarev'" <jerry@izmiran.rssi.ru>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: dbau1200 ethernet driver?
Date:	Sat, 7 May 2005 09:08:36 -0400
Organization: NGI Technology, LLC
Message-ID: <00c801c55305$e3de3660$0b03a8c0@lithium>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <1115394400.5785.3.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Return-Path: <bvacaliuc@ngit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bvacaliuc@ngit.com
Precedence: bulk
X-list: linux-mips

On Friday, May 06, 2005 11:47 AM, Pete Popov wrote:

> On Fri, 2005-05-06 at 15:53 +0300, Ruslan V.Pisarev wrote:
>>   Hi!
>> 
>>  I compiled last 2.6 kernel (2-3 weeks ago from cvs@linux-mips) and
>> trying to start it on DBAu1200 development board. First problem I
>> discovered with "nfsroot" configuration - is that kernel cannot find
>> network interface at boot-time.  There is a smc91c111 network chip on
>> board, so my question is - what driver is suitable with him?
> 
> The smc91x.c driver. However, I don't remember if that driver was
> tested.  The board was tested with a different smc driver which I
> couldn't push in the tree because it was old and would conflict with
> the smc91x.c.   
> 
>>  Is it "MIPS AU1000 Ethernet support"
>> which fails to compile with "error: `NUM_ETH_INTERFACES' undeclared"
>> (and it must be?) or something different? It seems that I have
>> enabled all other options for ethernet functionality.
> 
> Well, that's a different driver.

Yes, and not for Au1200.  The Au1200 does not have an integrated MAC; access to the MAC/PHY is through the static memory controller.

-bogdan
