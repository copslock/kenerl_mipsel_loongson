Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Dec 2011 23:49:05 +0100 (CET)
Received: from qmta14.emeryville.ca.mail.comcast.net ([76.96.27.212]:55467
        "EHLO qmta14.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903622Ab1L0WtB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Dec 2011 23:49:01 +0100
Received: from omta16.emeryville.ca.mail.comcast.net ([76.96.30.72])
        by qmta14.emeryville.ca.mail.comcast.net with comcast
        id ENAh1i0041ZMdJ4AENon8B; Tue, 27 Dec 2011 22:48:47 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta16.emeryville.ca.mail.comcast.net with comcast
        id ENZ51i00Q1rgsis8cNZ7gG; Tue, 27 Dec 2011 22:33:07 +0000
Message-ID: <4EFA4B40.8090502@gentoo.org>
Date:   Tue, 27 Dec 2011 17:48:32 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     Stephen Hemminger <shemminger@vyatta.com>
CC:     netdev@vger.kernel.org, Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] net: meth: Add set_rx_mode hook to fix ICMPv6 neighbor
 discovery
References: <4EED3A3D.9080503@gentoo.org> <4EF95247.7000403@gentoo.org> <20111227103408.01aad10e@nehalam.linuxnetplumber.net> <4EFA38D5.1000602@gentoo.org> <20111227143441.30d2c42f@nehalam.linuxnetplumber.net>
In-Reply-To: <20111227143441.30d2c42f@nehalam.linuxnetplumber.net>
X-Enigmail-Version: 1.3.4
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-archive-position: 32203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20180

On 12/27/2011 17:34, Stephen Hemminger wrote:

> On Tue, 27 Dec 2011 16:29:57 -0500
> Joshua Kinard <kumba@gentoo.org> wrote:
> 
>> MIPS I/O registers are always memory-mapped, and to prevent the compiler
>> from trying to over-optimize, volatile is used to make sure we always read a
>> value from the hardware and not from some cached value.
> 
> Almost every other network driver had memory mapped register.
> The problem is volatile is that the compiler is stupid and wrong.
> Using explicit barriers is preferred and ensures correct and fast
> code.


I am somewhat new to driver development, so I do not know all the tricks of
the trade just yet.  Do you have references to doing explicit barriers that
I can look at?  Might be worth trying on the RTC driver I have to get the
hang of them.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
