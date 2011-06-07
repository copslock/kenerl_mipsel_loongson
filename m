Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 01:02:30 +0200 (CEST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:43881 "EHLO
        sj-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491851Ab1FGXCZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jun 2011 01:02:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=dvomlehn@cisco.com; l=3303; q=dns/txt;
  s=iport; t=1307487745; x=1308697345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=W5UypO2ohGJvEcm5UkBhOdp1YilegaMidT9C/bF63Oc=;
  b=DJ7oOOotcj+zVOqlp5NXTmMM8Vrhc7tA2/NZyYBCbRnsBklbEH20kjih
   VtlaIVr6jSw6sebR2AAIPDXo87cEtwqiIQOTdCGmDQAtv6eGR+zebvG7i
   FJ3cSK8jOILM7Diox62gzaBzhdkj1Hzhezvr4xTKCTzp+1yUJIRrKnLw6
   c=;
X-IronPort-AV: E=Sophos;i="4.65,335,1304294400"; 
   d="scan'208";a="372203881"
Received: from mtv-core-2.cisco.com ([171.68.58.7])
  by sj-iport-2.cisco.com with ESMTP; 07 Jun 2011 23:02:18 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by mtv-core-2.cisco.com (8.14.3/8.14.3) with ESMTP id p57N2IJR008768;
        Tue, 7 Jun 2011 23:02:18 GMT
Date:   Tue, 7 Jun 2011 16:02:18 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     Grant Likely <grant.likely@secretlab.ca>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        "Dezhong Diao (dediao)" <dediao@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Converting MIPS to Device Tree
Message-ID: <20110607230218.GA23552@dvomlehn-lnx2.corp.sa.net>
References: <20110606010753.GA16202@linux-mips.org> <BANLkTik1mRWTcX8WgO5s6mFrUGYwBRmSow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BANLkTik1mRWTcX8WgO5s6mFrUGYwBRmSow@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 30287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6250

On Sun, Jun 05, 2011 at 11:41:10PM -0500, Grant Likely wrote:
> On Sun, Jun 5, 2011 at 7:07 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Over the past few days I've started to convert arch/mips to use DT.
> 
> Nice!
> 
> >  So
> > far none of the platforms (except maybe PowerTV?) seems to have a
> > firmware that is passing a DT nor is there any 2nd stage bootloader that
> > could do so.
> 
> FWIW, U-Boot now has pretty generic support for manipulating and
> passing a dtb at boot.  That doesn't do much good for existing
> deployed systems though.

I took a look at the issue of passing device trees to the kernel and started
by surveying the methods currently in use for passing information from the
bootloader to the kernel. I came up with the ten approaches:

How MIPS Bootloaders Pass Information to the Kernel
---------------------------------------------------
Apologies for any errors; this was meant more to be a quick survey
rather than a detailed analysis.

1.	a0 - argc
	a1 - argv
	Strings are concatenated to create the command line, starting at
	argv[0].
	Platforms: ath79

2.	a0 - argc
	a1 - argv
	a2 - envp
	Strings are concatenated to create the command line, starting at
	argv[0].
	Platforms: pnx8550, rb532

3.	a0 - argc
	a1 - argv
	Command line created by concatenating argv strings, starting at
	argv[1].
	Platforms: emma, fw, jz4740, lasat, pnx833x, vr41xx

4.	a0 - argc
	a1 - argv
	a2 - envp
	Command line created by concatenating argv strings, starting at
	argv[1].
	Platforms: alchemy, ar7, loongson, mti-malta, pmc-sierra

5.	a0 - unused
	a1 - unused
	a2 - unused
	Boot descriptor in a3.
	Platforms: cavium-octeon

6.	a0 - argc
	a1 - argv
	a2 - non-standard envp
	Command line created by concatenating argv strings, starting at
	argv[1]. The envp is a pointer to a list of char ptr to name/char
	ptr pairs.
	Platforms: txx9

7.	a0 - argc
	a1 - argv
	a2 - magic
	a3 - prom_vec
	Command line created by concatenating argv strings, starting at
	either argv[1] or argv[2], depending on the value passed in magic.
	Platforms: dec

8.	a0 - argc
	a1 - unused
	a2 - envp
	a3 - prom_vec
	Interpretation depends on the values passed, but command line is
	a single string in the cfe environment.
	Platforms: bcm47xxx, sibyte

9.	a0 - bits 30-16: memory size, bits 15-0, argc
	a1 - argv
	Command line created by concatenating argv strings, starting at
	argv[1].
	Platforms: cobalt

10.	a0 - argc
	a1 - argv
	a2 - unused
	a3 - memory size
	The command line is assumed to already be a single string, pointed
	to by argv.
	Platforms: powertv

It seems like everything ultimately does create a command line. We could then
use a parameter like "devtree=<virtual-address>" on the command line, passed
in any way the bootloader likes. In this case, the <virtual-address> will be
a kseg0 address so we don't have to set up any mappings. If we allow multiple
device trees to be built in or appended to the end of the kernel, we can use
the existing "dtb_compat" command line parameter to select which one to use.
I would propose that "devtree" take precedence over "dtb_compat", but that's
really just a desire to pick one over the other, whichever is the preferred
one.
-- 
David VL
