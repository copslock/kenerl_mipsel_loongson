Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2011 08:53:31 +0100 (CET)
Received: from gateway04.websitewelcome.com ([69.93.179.22]:35921 "HELO
        gateway04.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1492554Ab1AMHx1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jan 2011 08:53:27 +0100
Received: (qmail 5874 invoked from network); 13 Jan 2011 07:53:12 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway04.websitewelcome.com with SMTP; 13 Jan 2011 07:53:12 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=HOiosDSvOU/NISCtzVJd0PzoxKNrNhMPCFli3TqHfHF/bu+aaIsAwcYyrxQ6MycR8+o50GnKG7DQ8P0UgbiE1pmGbB6QhgFrUedmS4gxYhlbjGfiXtdUS5oF39WvVsR+;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:1649 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PdHzh-0007VG-4D; Thu, 13 Jan 2011 01:53:17 -0600
Message-ID: <4D2EAF78.7010805@paralogos.com>
Date:   Wed, 12 Jan 2011 23:53:28 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>      <1293470392.27661.202.camel@paanoop1-desktop>   <1293524389.27661.210.camel@paanoop1-desktop>   <4D19A31E.1090905@paralogos.com>        <1293798476.27661.279.camel@paanoop1-desktop>   <4D1EE913.1070203@paralogos.com>        <1294067561.27661.293.camel@paanoop1-desktop>   <4D21F5D3.50604@paralogos.com>  <1294082426.27661.330.camel@paanoop1-desktop>   <4D22D7B3.2050609@paralogos.com>        <1294146165.27661.361.camel@paanoop1-desktop>   <1294151822.27661.375.camel@paanoop1-desktop>   <4D235717.1000603@paralogos.com>        <1294163657.27661.386.camel@paanoop1-desktop>   <4D2367EE.7000702@paralogos.com>        <1294233097.27661.391.camel@paanoop1-desktop>   <4D24C525.5000306@paralogos.com>        <1294345396.27661.422.camel@paanoop1-desktop>   <4D2650D6.4030102@paralogos.com> <1294387019.27661.458.camel@paanoop1-desktop> <4D2B5E46.3070609@paralogos.com>
In-Reply-To: <4D2B5E46.3070609@paralogos.com>
Content-Type: text/plain; charset=UTF-8
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
X-archive-position: 28900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Further interesting data point:

If I specify "nowait" on the command line, I get much better behavior on
the 2.6.36 and 2.6.37 kernels.  In particular, 2.6.37, which hung after
the "Switching to clocksource MIPS" even booting with a single TC, gets
far enough to enable swap space even with 4 TCs running.  I note that
there was historically a problem with getting SMTC to work with the
wait-with-interrupts-disabled idle wait mode.  I had it working back in
2.5.2x, but something seems to have gotten broken in that 2.6.32 to
2.6.36 interval...

            Regards,

            Kevin K.
