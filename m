Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jan 2011 21:22:51 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:62742 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491056Ab1ABUWs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Jan 2011 21:22:48 +0100
Received: by wyf22 with SMTP id 22so12819205wyf.36
        for <linux-mips@linux-mips.org>; Sun, 02 Jan 2011 12:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=mKGi2y7nZzUfZn+/lXrUqutk16fNmXdB83svydWH4mE=;
        b=TU+yvBd6Z5fkRmsec+YgQlzyN24t3cMD6TA06higbb0UYS0s+9FZFdeEUPx6s0Icfd
         LqOlWHFuqMAX2iFkWhXRbAT7x9PXiGAsfAsHhs7ptMc7ovGHRz9opLcIKWFjrkoZ2AUf
         xSujSWUyHxwTOuOI4FZseE1IqXErzBru4EGKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=lV7RsCqaj9sw+JU8olVRzl7vyKc7SrgsQNs1YQvbNvs7SwIEOLkwzMHCy9VlYubH/a
         OSpfYR65GdFy12Zp8y5loFDpBMapiiZc1yi8AD8ZdRPUUywZ+dD4EwH+8NYTUkKn4hB3
         acHeMvdwFN7zlCZh+Z4nNv+AA04DkSHvt9G98=
Received: by 10.216.154.14 with SMTP id g14mr19294876wek.78.1293999762710;
        Sun, 02 Jan 2011 12:22:42 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id f52sm9450203wes.35.2011.01.02.12.22.40
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 Jan 2011 12:22:41 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     "Kevin D. Kissell" <kevink@kevink.net>
Subject: Re: CygWin Cross-tool Package?
Date:   Sun, 2 Jan 2011 21:23:11 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.35-24-server; KDE/4.5.1; x86_64; ; )
Cc:     Linux MIPS org <linux-mips@linux-mips.org>
References: <4D20DABE.5020306@kevink.net>
In-Reply-To: <4D20DABE.5020306@kevink.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201101022123.11450.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello Kevin,

On Sunday 02 January 2011 21:06:22 Kevin D. Kissell wrote:
> As the person guilty of inventing the damned thing, I've been trying to
> help folks keep the SMTC kernel working, but it's strictly a spare-time
> thing - nobody pays me for time or materials.  So I'm not willing to
> spend the time and money to set up a Linux box at home that would serve
> only to build SMTC kernels.  For better or for worse, my home office
> system is a Windows XP machine.   I've got Cygwin installed, and that
> gives me git to peruse the sources, but I've got no means of building a
> kernel.  I know that, in theory, I could build my own MIPS/Linux cross
> tools under Cygwin, but looking at various email archives, it looks like
> the procedure is moderately complex and fragile, and, frankly, I just
> don't have the spare time to deal with it.  By any chance, could one of
> you point me to a functional, pre-built package I could install under
> Cygwin to do kernel builds?

Providing that you install of the required dependencies (subversion, flex, 
bison ...), OpenWrt can build a Linux kernel and root filesystem under Cygwin.

Hope that helps.
--
Florian
