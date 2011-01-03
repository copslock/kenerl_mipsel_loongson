Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jan 2011 17:54:37 +0100 (CET)
Received: from walscop001.walsimou.com ([82.228.201.70]:34912 "EHLO
        bekkor.walsimou.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491985Ab1ACQye (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jan 2011 17:54:34 +0100
Received: from wdebian.fr.swissvoice.net (swissvoice-53-74.cnt.nerim.net [213.215.53.74])
  (AUTH: PLAIN walsimou@walsimou.com, SSL: TLSv1/SSLv3,256bits,CAMELLIA256-SHA)
  by bekkor.walsimou.com with esmtp; Mon, 03 Jan 2011 17:54:22 +0100
  id 0108DC27.4D21FF3E.0000A214
Message-ID: <4D21FEFA.2030904@embtoolkit.org>
Date:   Mon, 03 Jan 2011 17:53:14 +0100
From:   Abdoulaye Walsimou GAYE <awg@embtoolkit.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20101227 Icedove/3.0.11
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@paralogos.com>
CC:     Florian Fainelli <florian@openwrt.org>,
        Linux MIPS org <linux-mips@linux-mips.org>
Subject: Re: CygWin Cross-tool Package?
References: <4D20DABE.5020306@kevink.net> <201101022123.11450.florian@openwrt.org> <4D21ED6C.1020503@paralogos.com>
In-Reply-To: <4D21ED6C.1020503@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <awg@embtoolkit.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: awg@embtoolkit.org
Precedence: bulk
X-list: linux-mips

On 01/03/2011 04:38 PM, Kevin D. Kissell wrote:
>
> Sigh.  It looked promising, but...
>
> $ make menuconfig
> Checking 'working-make'... ok.
> Checking 'case-sensitive-fs'... failed.
> Checking 'getopt'... ok.
> Checking 'fileutils'... ok.
> Checking 'working-gcc'... ok.
> Checking 'working-g++'... ok.
> Checking 'ncurses'... failed.
> Checking 'zlib'... ok.
> Checking 'gawk'... ok.
> Checking 'flex'... ok.
> Checking 'unzip'... ok.
> Checking 'bzip2'... ok.
> Checking 'patch'... ok.
> Checking 'perl'... ok.
> Checking 'python'... ok.
> Checking 'wget'... ok.
> Checking 'gnutar'... ok.
> Checking 'svn'... ok.
> Checking 'gnu-find'... ok.
> Checking 'getopt-extended'... ok.
> Checking 'non-root'... ok.
>
> Build dependency: OpenWrt can only be built on a case-sensitive filesystem
> ...
>
> It will probably be easier for me to get some random cheap PC running
> Ubuntu than to get a non-case-sensitive filesystem working on an
> existing XP platform.
>
> Any recommendations on cross tool packages for X86/X86-64 Ubuntu
> installations?  Or would splicing the linux-mips.org kernel tree under
> the OpenWrt structure - but under Linux this time - still be the
> shortest path?
>
>             Regards, and thanks,
>
>             Kevin K.
>   


Hello,
If you really want to still use window$, you can use vwmare with an ubuntu
virtual machine.

Best regards,
AWG
