Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 10:49:42 +0200 (CEST)
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:40429 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011476AbbEPItit3hQg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 10:49:38 +0200
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-04v.sys.comcast.net with comcast
        id UYpa1q0014xDoy801Ypazu; Sat, 16 May 2015 08:49:34 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-po-05v.sys.comcast.net with comcast
        id UYpY1q00942s2jH01YpZfF; Sat, 16 May 2015 08:49:34 +0000
Message-ID: <5557048B.8010205@gentoo.org>
Date:   Sat, 16 May 2015 04:49:15 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: malta-time: Don't switch RTC to BCD mode
References: <1431519473-24049-1-git-send-email-james.hogan@imgtec.com> <1431519473-24049-2-git-send-email-james.hogan@imgtec.com> <alpine.LFD.2.11.1505131829580.1538@eddie.linux-mips.org> <20150513221956.GE7723@jhogan-linux.le.imgtec.org> <20150514084130.GE22815@NP-P-BURTON> <55547238.1040005@imgtec.com> <alpine.LFD.2.11.1505141122380.19904@eddie.linux-mips.org> <20150515180351.GE2322@linux-mips.org> <20150515181413.GA30774@NP-P-BURTON> <alpine.LFD.2.11.1505152038050.4923@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1505152038050.4923@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1431766174;
        bh=45tSuhbumV/dkS4SocV3i99vIOhtHf5Ph/kFrRWNloE=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=fwNFCze85HOIiPzror+ymk7nXYdKK7h8KMIfUUNzcHXTQ4gRyFqT4MGEL26STPE9N
         aJplBdpXwnNrlwSCC1an7SEuR2N5XplThneqHEjiiLAGTYmbph0lh1MA1yAT/hDEs7
         s9vOFGtL4zoyLI3GRZyOCCdshGkYmjTM8j45bVZ7WRd0mKZ08750Chd2GaBIl7HgXW
         bJE0brM9qpUZ0wcIuC/6AlYXPmHa1ntUQ/oD9YltfRrJCkf2ZNmcOSy2BGvFZGWiLC
         /YR1vnGmTCOtLZJeIZ1rVJ7l2+LudqEIAeiKQYbhR+SGawNEIqJhnjBPov4BqMHY15
         7ubnSxbVtXPdQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 05/15/2015 17:13, Maciej W. Rozycki wrote:
> On Fri, 15 May 2015, Paul Burton wrote:
> 
>>>>  I'd prefer RTC state not to be touched at all if its state is sane.  
>>>> That is read Register B, check for the only valid divider setting 
>>>> (32kHz), and if so then exit right away, and otherwise initialise the 
>>>> chip from scratch.  Consistency with YAMON might be a good idea in that 
>>>> initialisation, but I have no strong feeling towards that.  If you think 
>>>> there's value in having the chip set to the BCD mode, then feel free to 
>>>> keep that option.
>>>>
>>>>  Note that any inhibition of the RTC previously initialised by 
>>>> temporarily setting the SET bit in Register B during bootstrap will 
>>>> disturb timekeeping that the system may carry over reset using 
>>>> adjtimex(8).
>>>
>>> So you're instead suggesting to revoke a87ea88d8f6c ?
> 
>  No, now that I have the full picture -- everyone, please try to include 
> as much details with our commit messages as required for the reader to be 
> able to have a full understanding of the reasons behind the change without 
> having to guess or ask around.  You may not be around in a few years' 
> time, having moved on with your career or interests, or suchlike, and 
> people will have to cope without your assistance.  It's OK to give these 
> messages a meaning, they are not GNU ChangeLogs!

Maybe not in the commit message for rtc-ds1685, but a good chunk of that driver
is comments.  I found one of the most frustrating things in working on that
driver to be not understanding what other RTC drivers were doing because no one
else commented their code clearly.  Hopefully, if someone winds up in the same
position I was in, they'll be able to understand quicker what rtc-ds1685 does
and maybe use some of its code in their setup.


>>> If YAMON and U-Boot are differing in RTC handling then I suggest to
>>> treat that as a U-Boot bug. YAMON was there first.
> 
>  And that is a grand first, 15+ years!
> 
>> That would be fair enough, and is why I added RTC handling to Malta
>> U-boot at all. I could see logic in suggesting U-boot be changed to use
>> the binary mode instead of BCD. But...
> 
>  I find it a shame BTW that the handling of RTC has fallen so bad recently 
> across various platforms.  Here you shouldn't have been required to do 
> anything beyond enabling the right RTC driver (the Motorola clone has been 
> so ubiquitous that a driver must have been done eons ago), defining its 
> mapping on the bus (again 0x70/0x71 in the PCI I/O space is the vastly 
> most common arrangement) and maybe setting some configuration flags for 
> the mode (binary vs BCD and the like).

SGI O2 and SGI Octane both use the same RTC, a DS1687-5.  But with the O2, the
ARCS PROM forces the RTC to BCD on startup, while the Octane's ARCS PROM forces
it to binary on startup.  And if the Octane's PROM discovers the RTC is in BCD
mode, it resets it to 1969.  That really confused e2fsck...

Also on the O2, you can MMIO the RTC and make life easy.  But on the Octane,
the RTC is kludged onto the IOC3 ByteBus...so you have to write the address of
interest to an addr port, then read the data from the data port.  I've
discovered since then that, if you spam 'hwclock --show' on the shell, the O2
never misses a beat, but on the Octane, because the IOC3 ByteBus is so slow, I
can actually catch the RTC in the middle of an update cycle, which locks out
access for 1 second until the update completes.

--J
