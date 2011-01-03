Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jan 2011 18:25:40 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:41503 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491994Ab1ACRZh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jan 2011 18:25:37 +0100
Received: by wyf22 with SMTP id 22so13482958wyf.36
        for <linux-mips@linux-mips.org>; Mon, 03 Jan 2011 09:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=Z5+N+6TkJFYWyA6VpcRlXSUUSr3ZNwCcYEChnxUTk9Q=;
        b=YWv5XgQPeac+zXj4MT/nA92HQoaeLLxIAih0D4hV768g8/csAbss2QKeZSdQFzR9nl
         /Z1W1ePC8LMGUZtuqOwbL3R71olWr4tUCSN4eZn6hLo3zfNUiXTh2HxMOPoQwUq18Lo8
         SMBxaBHsERpW6jBJqEmoDmIa7n0eDU1zWV/sQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=gwlarF6L/t3LDttGYSbGyG4aGpkSJNnAkr7/VajduC4OYtcrAHQVltgeYXkdxlepIO
         RaBBrVO9gqIteanJd9Plul6Xy+mm3MZEcalfopp83Ld3kSTvD1C98yB/9zgxqMH6esxd
         HfMd8MnVg3xyIkUvtdBlxITPBtH5F2xpZ04sA=
Received: by 10.227.155.138 with SMTP id s10mr11800010wbw.61.1294075530432;
        Mon, 03 Jan 2011 09:25:30 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 11sm14311338wbi.6.2011.01.03.09.25.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 09:25:28 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Subject: Re: CygWin Cross-tool Package?
Date:   Mon, 3 Jan 2011 18:26:05 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.35-24-server; KDE/4.5.1; x86_64; ; )
Cc:     Linux MIPS org <linux-mips@linux-mips.org>
References: <4D20DABE.5020306@kevink.net> <201101022123.11450.florian@openwrt.org> <4D21ED6C.1020503@paralogos.com>
In-Reply-To: <4D21ED6C.1020503@paralogos.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201101031826.05444.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28812
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

On Monday 03 January 2011 16:38:20 Kevin D. Kissell wrote:
> On 1/2/2011 12:23 PM, Florian Fainelli wrote:
> > Hello Kevin,
> > 
> > On Sunday 02 January 2011 21:06:22 Kevin D. Kissell wrote:
> >> ...By any chance, could one of
> >> you point me to a functional, pre-built package I could install under
> >> Cygwin to do kernel builds?
> > 
> > Providing that you install of the required dependencies (subversion,
> > flex, bison ...), OpenWrt can build a Linux kernel and root filesystem
> > under Cygwin.
> > 
> > Hope that helps.
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

And that can be achieved simply by using a case sensitive mount:
http://www.mail-archive.com/cygwin@cygwin.com/msg81382.html

> 
> Any recommendations on cross tool packages for X86/X86-64 Ubuntu
> installations?  Or would splicing the linux-mips.org kernel tree under
> the OpenWrt structure - but under Linux this time - still be the
> shortest path?

OpenWrt or some other project like buildroot would work fine building a 
toolchain and kernel for that specific target.
--
Florian
