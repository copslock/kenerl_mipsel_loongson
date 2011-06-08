Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 03:10:09 +0200 (CEST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:14431 "EHLO
        sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491875Ab1FHBKA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jun 2011 03:10:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=dvomlehn@cisco.com; l=2727; q=dns/txt;
  s=iport; t=1307495400; x=1308705000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=44oVJrTSfXJhSLl0VnmshbGiFpomzIujs2TU5zwzTXg=;
  b=En5Pj0BBuahq6fnsTMaJ2mKG4bjKx4tO0eUCZPhty/bV+gqyV+VZI/LZ
   udAx8IgnqFsn/PgUCelKfSzuvmARdcZm3agvAPIyi5QvCpYxhvcpxOBvh
   UYaClBtSGqqNVhYxi1hGgj4ww/NpZMWv8x7HK5WiqcUWEvf4VIcmZavb6
   0=;
X-IronPort-AV: E=Sophos;i="4.65,335,1304294400"; 
   d="scan'208";a="372268664"
Received: from mtv-core-4.cisco.com ([171.68.58.9])
  by sj-iport-2.cisco.com with ESMTP; 08 Jun 2011 01:09:52 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by mtv-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p5819qqI002715;
        Wed, 8 Jun 2011 01:09:52 GMT
Date:   Tue, 7 Jun 2011 18:09:52 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        "Dezhong Diao (dediao)" <dediao@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Converting MIPS to Device Tree
Message-ID: <20110608010952.GA27441@dvomlehn-lnx2.corp.sa.net>
References: <20110606010753.GA16202@linux-mips.org> <BANLkTik1mRWTcX8WgO5s6mFrUGYwBRmSow@mail.gmail.com> <20110607230218.GA23552@dvomlehn-lnx2.corp.sa.net> <4DEEB2A8.8050302@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DEEB2A8.8050302@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 30290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6376

On Tue, Jun 07, 2011 at 04:22:16PM -0700, David Daney wrote:
> On 06/07/2011 04:02 PM, David VomLehn wrote:
>> On Sun, Jun 05, 2011 at 11:41:10PM -0500, Grant Likely wrote:
>>> On Sun, Jun 5, 2011 at 7:07 PM, Ralf Baechle<ralf@linux-mips.org>  wrote:
>>>> Over the past few days I've started to convert arch/mips to use DT.
...
>> It seems like everything ultimately does create a command line. We could then
>> use a parameter like "devtree=<virtual-address>" on the command line, passed
>> in any way the bootloader likes.
...
> I would say to pass the pointer to the DTB in the environment, but not  
> all platforms (like powertv) have an environment.  So I guess the  
> command line has to do.

[Actually, PowerTV *could* have an environment; I fought with my bootloader
people to ensure a2 was NULL to allow for future support for passing a
pointer to an environment later.  I really wish those guys were in the
same group as the kernel people...]

I think we're kind of stuck with passing something on the command line, which
means passing the command line in the device tree ends up being a bit
confusing. We might want to think about this case a bit:

o  Do we take only the device tree argument from the command line, then
   replace it with the command line in the device tree, if any?
o  Or append the device tree command line to the command line?
o  Or do something else entirely?

I'm reluctant to leave it undefined but don't really see one alternative
as clearly better than another.

> Also I think we should pass the physical address of the DTB, not the  
> virtual address.  It would be the kernel's responsibility to figure out  
> what the virtual address is.

I'm good with this. We're currently passing a virtual address with the
command line parameter "devicetree" so, not surprisingly, I'd like to use
some other parameter name if we pass the physical address. Using "devtree"
is nice and short. Or "device_tree" if you like something more less terse.

> David Daney
>
>> In this case, the<virtual-address>  will be
>> a kseg0 address so we don't have to set up any mappings. If we allow multiple
>> device trees to be built in or appended to the end of the kernel, we can use
>> the existing "dtb_compat" command line parameter to select which one to use.
>> I would propose that "devtree" take precedence over "dtb_compat", but that's
>> really just a desire to pick one over the other, whichever is the preferred
>> one.

Any thoughts on precedence of "devtree"/"device_tree" over "dtb_compat"? My
thought is that something passed explicitly should take precedence over
something built-in, but that's just what I think right now.
-- 
David VL
