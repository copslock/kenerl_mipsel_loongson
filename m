Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2012 17:40:26 +0200 (CEST)
Received: from mailout-de.gmx.net ([213.165.64.22]:60792 "HELO
        mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1903524Ab2HCPkS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2012 17:40:18 +0200
Received: (qmail 14595 invoked by uid 0); 3 Aug 2012 15:40:12 -0000
Received: from 217.12.59.162 by www053.gmx.net with HTTP;
 Fri, 03 Aug 2012 17:40:11 +0200 (CEST)
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset="utf-8"
Date:   Fri, 03 Aug 2012 17:40:11 +0200
From:   "Oliver Kowalke" <oliver.kowalke@gmx.de>
In-Reply-To: <20120803062242.GA22167@linux-mips.org>
Message-ID: <20120803154011.214590@gmx.net>
MIME-Version: 1.0
References: <50085CB4.3030205@gmx.de> <1343917513.13395.6.camel@ubctp.tal.org>
 <20120803062242.GA22167@linux-mips.org>
Subject: Re: development board?
To:     Ralf Baechle <ralf@linux-mips.org>, milang@tal.org
X-Authenticated: #25097877
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX1+VLqs6tkaV6iMyoQ3NaSJ/W6XVr+0l0dFCAtKHTD
 PvN0mypdAVYu+hkECQDUbw2yrQg/2AZv0r6g== 
Content-Transfer-Encoding: 8bit
X-GMX-UID: jJVpcLcyeSEqNvSVFXUhLMN+IGRvb0CC
X-archive-position: 34050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oliver.kowalke@gmx.de
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

I'll try MikroTik RouterBOARD 450G:

    CPU: AR7161 680MHz
    Memory 256MB DDR SDRAM onboard memory
    Boot loader RouterBOOT
    Data storage 512MB onboard NAND memory chip, microSD slot on back side
    Ethernet Five 10/100/1000 Mbit/s Ethernet ports with Auto-MDI/X
    miniPCI none
    Extras Reset switch, Beeper
    Serial port One DB9 RS232C asynchronous serial port
    Power, NAND activity, 5 user LEDs
    Power options Power over Ethernet: 18-28V DC (except power over datalines). Power jack: 8-28V DC
    Dimensions 9 cm x 11.5 cm, 105 grams
    Operating System MikroTik RouterOS v3, Level5 license
    Actual tested throughput
        Ether1 <-> Ether2 = 1Gbps
        Ether2 <-> Ether3 = 650Mbps

openvrt/debvrt support this board

(no FPU)

Oliver 

> On Thu, Aug 02, 2012 at 05:25:13PM +0300, Kaj-Michael Lang wrote:
> 
> > On Thu, 2012-07-19 at 21:15 +0200, Oliver Kowalke wrote:
> > > I'm searching for an development board with a MIPS processor - 1GB
> > > RAM 
> > > would be nice but 10/100MBit ethernet is required. 
> > 
> > Don't know about the ethernet part, but you could check out the very
> > cheap mips based android tablets. Search for Ainol Novo 7 Paladin for
> > example, under 100€.
> > 
> > Anyone tried getting plain-old-linux running on one?
> 
> I suggest that whoever has suggestions for suitable boards should list
> them including key technical data such as kernel / distribution support,
> CPU type, 32/64 bit, endianess, price, peripherals, manufacturing status
> and availability.
> 
>   Ralf
> 
