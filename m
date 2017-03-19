Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Mar 2017 08:23:50 +0100 (CET)
Received: from resqmta-ch2-02v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:34]:33062
        "EHLO resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991532AbdCSHXoAqwI7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Mar 2017 08:23:44 +0100
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-02v.sys.comcast.net with SMTP
        id pVBlcWIw0WRJ0pVBlcthk9; Sun, 19 Mar 2017 07:23:41 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-01v.sys.comcast.net with SMTP
        id pVBkcRvjRt7zrpVBlcAuv1; Sun, 19 Mar 2017 07:23:41 +0000
Subject: Re: ARCS can't load CONFIG_DEBUG_LOCK_ALLOC kernel
To:     Ralf Baechle <ralf@linux-mips.org>
References: <8b2d7473-ba4d-f2c9-27e7-b1a30b95c4f8@gentoo.org>
 <a639551b-4338-e1fb-0cc7-e6ea34b94c2c@gentoo.org>
 <20170316140918.GH5512@linux-mips.org>
 <86da6dd2-7b02-cd0d-f152-00dfb134a3ec@gentoo.org>
 <20170316190629.GP5512@linux-mips.org>
 <13b0221d-c17a-7e5b-6bb5-702ee7d896c1@gentoo.org>
 <20170316205006.GE10914@linux-mips.org>
 <c969ac8f-2915-6d9c-cc59-0da77199b3a1@gentoo.org>
 <23538ffb-4ab5-22b5-d740-fbe5fadf8aa0@gentoo.org>
Cc:     linux-mips@linux-mips.org
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <680b861f-c60f-441a-53ff-f79edb0ce044@gentoo.org>
Date:   Sun, 19 Mar 2017 03:23:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <23538ffb-4ab5-22b5-d740-fbe5fadf8aa0@gentoo.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOodTY/YbxOe0KTYDbKLS2EnzISmGPY8F8cuYLpUCErYbaQ13D17PTqwYbMyP3szFgo2sCHY3xsnqD0eVLdBK5LqNwN/7OvT9Hb0msevfd4FjLEDtF5r
 bsKYRI4REeP5km3U7G+caQdURG2GQ9rxCZEbHJz8nKZwAD/ZD42qQ3OoBjufGpBUyzBO6ov7bo/qz9tArabSMHd7vDa1/UAPGak=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57387
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

On 03/18/2017 19:42, Joshua Kinard wrote:
> 
> Futzing around with the load address on IP27 doesn't work the same as on
> Octane.  IP27 has a much smaller window of FreeMemory available versus the
> Octane, based on this dump I got out of arcload:
> 
> ARCS Memory Map
> 0x0 - 0x1000 (ExceptionBlock)
> 0x1000 - 0x2000 (SystemParameterBlock)
> 0x19000 - 0x12f0000 (FreeMemory)
> 0x12f0000 - 0x12ff000 (LoadedProgram)
> 0x12ff000 - 0x1300000 (FreeMemory)
> 0x1300000 - 0x1400000 (FirmwareTemporary)
> 0x1400000 - 0x1500000 (FreeMemory)
> 0x1500000 - 0x1800000 (FirmwareTemporary)
> 0x1800000 - 0x1a00000 (FirmwareTemporary)
> 0x1a00000 - 0x1b00000 (FirmwarePermanent)
> 0x1c00000 - 0x1e00000 (FreeMemory)
> 0x1c01000 - 0x1f66000 (FirmwareTemporary)
> 0x1f80000 - 0x1fa0000 (FirmwareTemporary)
> 
> Going by that, I was finally able to strip a kernel down small enough to
> contain both CONFIG_DEBUG_LOCK_ALLOC and the absolute bare minimum
> functionality to boot to login on IP27, and I have about ~3.5KB to spare.  The
> only thing I've seen thus far after several reboots is a single spinlock lockup
> in generic code, but that was on a kernel using my patches, and I couldn't
> reproduce it a second time.  So I'm switching to as pure of a mainline kernel
> as I can to see if I can trip things up there.
> 
> Also trying to get kgdb to work, but something isn't right with it.  Seems like
> the kgdboc= boot parameter isn't being parsed/honored, so I have to force it
> manually by writing to /sys/module/kgdboc/parameters/kgdboc before the SysRq-g
> option becomes available.  I am hoping there's nothing special I need to do to
> IOC3 to get a debugger attached and working, but we'll see.  The kdb frontend
> appears to be out of the question, as it adds ~6-7KB of extra code.

It looks like kgdb won't work with the IOC3 metadriver, but the existing IOC3
code in ioc3-eth.c that handles serial will work.  I was able to get gdb on my
Octane to connect to it, though one has to use ~4800 baud to make it reliable
(could be the 30ft cat5 cable I'm using that dislikes 9600 baud).

Looks like that whatever this deadlock issue is locks the kernel pretty hard,
as even after stopping with SysRq-g and then continuing it via gdb, when the
deadlock happens, I cannot break into the debugger at all.  Even triggering an
NMI via the MSC dumps nothing out of the kernel before the PROM resets.

The closest I've gotten to extracting info on the state of the machine is to
set the MSC debug switches to 0x1018 and then issue an immediate reset to have
it drop into POD dirty-exclusive as soon as possible.  Then running "why"
sometimes nets me a valid kernel address in EPC that tells me where the POD CPU
was last at.  Downside, I have four CPUs and MSC POD locks up if I try
switching to any of the other CPUs.  So I can't get a register dump off of the
other three.

Other interesting note, sometimes when this deadlock happens, a soft reset
doesn't work.  It seems like one of the HUBs is locked up, because the PROM is
unable to communicate with it:

2A 000: Done initializing klconfig.
2A 000: Discovering NUMAlink connectivity .........             DONE
2A 000: Found 2 objects (2 hubs, 0 routers) in 511413 usec
1B 000: Testing/Initializing memory ...............             DONE
2A 000: Waiting for peers to complete discovery....             Reading link 0
(addr 0x92000000
2A 000: 00000004) failed
1B 000: CPU B switching to UALIAS
1B 000: CPU B now running out of UALIAS
2A 000: Reading link 0 (addr 0x9200000000000004) failed
1B 000: Skipping secondary cache diags
1B 000: CPU B switching stack into UALIAS and invalidating D-cache
1B 000: CPU B switching into node 0 cached RAM
1B 000: CPU B running cached
2A 000: Reading link 0 (addr 0x9200000000000004) failed
2A 000: Reading link 0 (addr 0x9200000000000004) failed


Then it gets a general exception and drops to POD Dex:
1B 000: Local Slave : Waiting for my NASID ...
1B 000: CPU B switching to UALIAS
1B 000: CPU B running in UALIAS
1B 000: CPU B Flushing and invalidating caches
1B 000: CPU B switching to node 0 cached RAM
1B 000: CPU B running cached
1A 000:
1A 000: *** General Exception on node 0
1A 000: *** EPC: 0xc00000001fc473dc (0xc00000001fc473dc)
1A 000: *** Press ENTER to continue.
1A 000: POD MSC Dex>

If this is a hardware lock up, that might explain why kgdb isn't useful at that
point.  POD lets me dump the CRBs and PI error spool, but I'm not sure how
useful that information is w/o SGI's internal documents.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
