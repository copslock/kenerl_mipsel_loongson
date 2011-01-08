Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jan 2011 00:23:32 +0100 (CET)
Received: from gateway16.websitewelcome.com ([69.56.160.2]:44949 "HELO
        gateway16.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491026Ab1AHXX3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Jan 2011 00:23:29 +0100
Received: (qmail 30388 invoked from network); 8 Jan 2011 23:22:58 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway16.websitewelcome.com with SMTP; 8 Jan 2011 23:22:58 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=d+WsadIkveWlDsSXsEnrDobOiE5esPRGjHGbsEpqVjiBm2AJNs9IjmS2Lor65wkLP/gP5odSixnkrovgB/O+tO5oOXlSEitrPJxH5XZki5hrQacUTA+OCnx2tn9/bQ7R;
Received: from c-98-207-157-135.hsd1.ca.comcast.net ([98.207.157.135]:2445 helo=[127.0.0.1])
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1Pbi82-0000CN-3d; Sat, 08 Jan 2011 17:23:22 -0600
Message-ID: <4D28F1EE.8030609@paralogos.com>
Date:   Sat, 08 Jan 2011 15:23:26 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Linux MIPS org <linux-mips@linux-mips.org>,
        tsbogend@alpha.franken.de
Subject: Re: MIPS Malta and PCNet32 Driver
References: <4D28AFB4.7090108@paralogos.com> <4D28C2C7.2080005@paralogos.com> <alpine.LFD.2.00.1101082251440.31930@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.00.1101082251440.31930@eddie.linux-mips.org>
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
X-archive-position: 28890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 1/8/2011 3:07 PM, Maciej W. Rozycki wrote:
> On Sat, 8 Jan 2011, Kevin D. Kissell wrote:
>
>> and, amusingly, from a stock 2.6.32.27 kernel that exhibits the problem,
>> I plugged in a PCI NIC and *both* interfaces came up happy.  :o/   One
>> might suspect that PCNet32 now assumes some level of initialization that
>> isn't being done in the platform code, and lucks out if a more
>> thoroughly paranoid driver gets loaded first.
>  Are you seeing the problem with a system controller other than the 
> Bonito?  That would be somewhat alarming, though easier to fix.
>
>  With the Bonito I'd have assumed it was some low-level PCI code rewrite 
> -- that seem to keep happening over and over again -- that missed a bit in 
> the Bonito driver or the driver altogether.  With the Bonito core cards 
> limited to the MIPS 20Kc core and some exotic (for the Malta) QED CPU 
> options that would be no surprise at all to me.
I don't think it's a "classic" Bonito, YAMON calls out:

MIPS SOC-it 101 OCP / 1.3   SDR-FW-1:1

            Regards,

            Kevin K.
