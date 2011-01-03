Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jan 2011 16:38:25 +0100 (CET)
Received: from gateway15.websitewelcome.com ([67.18.7.8]:59647 "HELO
        gateway15.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491961Ab1ACPiW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jan 2011 16:38:22 +0100
Received: (qmail 26613 invoked from network); 3 Jan 2011 15:38:26 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway15.websitewelcome.com with SMTP; 3 Jan 2011 15:38:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=QT0xWTvQtbPWGu6fmwJoOVxFX9Th3Y0bY9QIhTt2/rrbhDoJ2USbTnGaDweZNGJpX/i0bvdd3w5XJEXF+6DiGA6rTskow2c/8l2oaj4XdOCMijSgS7NQZB/miJK1VUv/;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:2758 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PZmUC-0004GZ-Aq; Mon, 03 Jan 2011 09:38:16 -0600
Message-ID: <4D21ED6C.1020503@paralogos.com>
Date:   Mon, 03 Jan 2011 07:38:20 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     "Kevin D. Kissell" <kevink@paralogos.com>,
        Linux MIPS org <linux-mips@linux-mips.org>
Subject: Re: CygWin Cross-tool Package?
References: <4D20DABE.5020306@kevink.net> <201101022123.11450.florian@openwrt.org>
In-Reply-To: <201101022123.11450.florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 1/2/2011 12:23 PM, Florian Fainelli wrote:
> Hello Kevin,
>
> On Sunday 02 January 2011 21:06:22 Kevin D. Kissell wrote:
>> ...By any chance, could one of
>> you point me to a functional, pre-built package I could install under
>> Cygwin to do kernel builds?
> Providing that you install of the required dependencies (subversion, flex, 
> bison ...), OpenWrt can build a Linux kernel and root filesystem under Cygwin.
>
> Hope that helps.
Sigh.  It looked promising, but...

$ make menuconfig
Checking 'working-make'... ok.
Checking 'case-sensitive-fs'... failed.
Checking 'getopt'... ok.
Checking 'fileutils'... ok.
Checking 'working-gcc'... ok.
Checking 'working-g++'... ok.
Checking 'ncurses'... failed.
Checking 'zlib'... ok.
Checking 'gawk'... ok.
Checking 'flex'... ok.
Checking 'unzip'... ok.
Checking 'bzip2'... ok.
Checking 'patch'... ok.
Checking 'perl'... ok.
Checking 'python'... ok.
Checking 'wget'... ok.
Checking 'gnutar'... ok.
Checking 'svn'... ok.
Checking 'gnu-find'... ok.
Checking 'getopt-extended'... ok.
Checking 'non-root'... ok.

Build dependency: OpenWrt can only be built on a case-sensitive filesystem
...

It will probably be easier for me to get some random cheap PC running
Ubuntu than to get a non-case-sensitive filesystem working on an
existing XP platform.

Any recommendations on cross tool packages for X86/X86-64 Ubuntu
installations?  Or would splicing the linux-mips.org kernel tree under
the OpenWrt structure - but under Linux this time - still be the
shortest path?

            Regards, and thanks,

            Kevin K.
