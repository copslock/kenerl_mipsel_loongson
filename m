Received:  by oss.sgi.com id <S305177AbQDBD3C>;
	Sat, 1 Apr 2000 19:29:02 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:13402 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305164AbQDBD2r>;
	Sat, 1 Apr 2000 19:28:47 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id TAA10991; Sat, 1 Apr 2000 19:24:06 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id TAA63875; Sat, 1 Apr 2000 19:28:16 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA97570
	for linux-list;
	Sat, 1 Apr 2000 19:19:57 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA24816
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 Apr 2000 19:19:56 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id TAA08883
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 Apr 2000 19:15:16 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-6.uni-koblenz.de (cacc-6.uni-koblenz.de [141.26.131.6])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id FAA04447;
	Sun, 2 Apr 2000 05:16:44 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S407778AbQDBDQ0>;
	Sun, 2 Apr 2000 05:16:26 +0200
Date:   Sun, 2 Apr 2000 05:16:26 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: configure spaghetti code
Message-ID: <20000402051626.J829@uni-koblenz.de>
References: <20000401181931.M3970@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000401181931.M3970@paradigm.rfc822.org>; from flo@rfc822.org on Sat, Apr 01, 2000 at 06:19:31PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sat, Apr 01, 2000 at 06:19:31PM +0200, Florian Lohoff wrote:

> Hi,
> i tried to compile my own kernel for the IP22 (mips not mips64) and 
> had no sucess (no output on any console) - I think this is due
> to the a couple of bugs ...
> 
> First of all - The spaghetti code in the config.in contains a lot if nice
> gimmicks like:
> 
> if [ "$CONFIG_DECSTATION" != "y" ]; then
>    source drivers/char/Config.in
> else
>    mainmenu_option next_comment
>    comment 'DECstation Character devices'
> [...]
>    if [ "$CONFIG_SGI_IP22" = "y" ]; then
>       bool 'SGI PROM Console Support' CONFIG_SGI_PROM_CONSOLE
>    fi
> [...]
> 
> Due to this the CONFIG_SGI_PROM_CONSOLE is not even selectable if
> i do not enable CONFIG_DECSTATION with CONFIG_SGI_IP22 ...
> 
> As most of the Architectures (IP22, Decstation etc) have VERY special
> hardware and nothing in common with the "default pc architecture"
> wouldnt it be a good way to 
> 
> 1. Have a choice of ONE architecture to select (Most of them can coexist
>    within the same kernel)

Most of them can NOT coexist in one kernel due to address space layout
differences, firmware differences etc. and users can not be expected to
know the details nor is it realistic to make a generic kernel for MIPS.
So as you say there should only one be selectable.

> 2. Depending on the selected Architecture include "config" scripts
>    within their special directory (Probably common CPU Type and networking
>    option, filesystem selection)
> 3. Only show devices which are really available for the architectures
>    (I dont think anyone has succeeded in plugging a 3C509 into a DecStation 
>    5000 or a Telephony card or even IDE)

Patches will be accepted :-)  Actually in the past things were slightly
more as you were suggesting but the code was fairly spagetty-like with the
intension to redo it somewhen.

  Ralf
