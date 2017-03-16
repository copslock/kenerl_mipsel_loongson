Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 04:51:07 +0100 (CET)
Received: from resqmta-ch2-03v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:35]:44454
        "EHLO resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990720AbdCPDvBMyxVt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Mar 2017 04:51:01 +0100
Received: from resomta-ch2-02v.sys.comcast.net ([69.252.207.98])
        by resqmta-ch2-03v.sys.comcast.net with SMTP
        id oMRGcVp89dEjjoMRGckB45; Thu, 16 Mar 2017 03:50:58 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-02v.sys.comcast.net with SMTP
        id oMRFcx9GGnnYZoMRFcmaFJ; Thu, 16 Mar 2017 03:50:58 +0000
Subject: Re: ARCS can't load CONFIG_DEBUG_LOCK_ALLOC kernel
To:     linux-mips@linux-mips.org
References: <8b2d7473-ba4d-f2c9-27e7-b1a30b95c4f8@gentoo.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <a639551b-4338-e1fb-0cc7-e6ea34b94c2c@gentoo.org>
Date:   Wed, 15 Mar 2017 23:50:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <8b2d7473-ba4d-f2c9-27e7-b1a30b95c4f8@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPTatjufJiTbtH7DpjN9UJFbI2qxoSqDANs//6GmPVyox3tEpNiyopwdzJhhkO/eF1Ab2YUjSifk2Xq1/RQQHoILx7ogdKz9uTDsxb6itbX/z4ab8eWJ
 TphgBNDZlaVPnVZ5hVUzS0Z4f1davVJ7rSAHYGOdXM8ke7Sr4j3BFGNb
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57316
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

On 03/15/2017 16:11, Joshua Kinard wrote:
> I've reported in the past that turning on CONFIG_DEBUG_LOCK_ALLOC produces a
> kernel that can't boot on several SGI platforms.  It turns out that using
> arcload (Stan's bootloader originally written for IP30), I can get some
> debugging out on why.  I am still puzzled, but maybe this information can be
> interpreted by someone else into something meaningful?
> 
> All addresses printed out of arcload are physical address.
> 
> ARCS Memory Map as printed by some debugging I added to the arcload binary:
> 
> 0x00000000 - 0x00001000 ExceptionBlock
> 0x00001000 - 0x00002000 SystemParameterBlock
> 0x00002000 - 0x00004000 FirmwarePermanent
> 0x20004000 - 0x20f00000 FreeMemory***
> 0x20f00000 - 0x21000000 FirmwareTemporary
> 0x21000000 - 0x5fff0000 FreeMemory
> 0x5fff0000 - 0x5ffff000 LoadedProgram
> 0x5ffff000 - 0x60000000 FreeMemory
> 0x60000000 - 0xa0000000 FirmwarePermanent

So it turns out I can get away, on Octane at least, by changing the load
address from 0x20004000 to an arbitrary value in the other FreeMemory segment
from 0x21000000 - 0x5fff0000.  Specifically, using 0x21004000 appears to work
without any ill effects.

The 0x20004000 value is the address used by IRIX to load (with symon, it
becomes 0x200800000 instead).  I'll have to try this on the IP27 later on as
well.  On Octane, CONFIG_DEBUG_LOCK_ALLOC didn't toss up any major locking
issues yet.  Probably need to hammer the disks with bonnie++ or such.  At least
I can get back to the BRIDGE/PCI mess now...

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
