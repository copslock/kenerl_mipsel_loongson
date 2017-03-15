Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 17:46:28 +0100 (CET)
Received: from resqmta-ch2-05v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:37]:58144
        "EHLO resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990514AbdCOQqV0SwDJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 17:46:21 +0100
Received: from resomta-ch2-04v.sys.comcast.net ([69.252.207.100])
        by resqmta-ch2-05v.sys.comcast.net with SMTP
        id oC2pcfcJC4CjQoC44cALiS; Wed, 15 Mar 2017 16:46:20 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-04v.sys.comcast.net with SMTP
        id oC42cUGKbk0LeoC42crEes; Wed, 15 Mar 2017 16:46:19 +0000
Subject: Re: NFS corruption, fixed by echo 1 > /proc/sys/vm/drop_caches --
 next debugging steps?
To:     Matt Turner <mattst88@gmail.com>,
        Manuel Lauss <manuel.lauss@gmail.com>
References: <CAEdQ38HcOgAT6wJWWKY3P0hzYwkBGSQkRSQ2a=eaGmD6c6rwXA@mail.gmail.com>
 <20170313094757.GI2878@jhogan-linux.le.imgtec.org>
 <20170315092536.GC22089@linux-mips.org>
 <CAOLZvyGRn5JgeRoiHv0AH8LVwLF5MtXF2KwS5Yr5N8QOK6eYnw@mail.gmail.com>
 <CAEdQ38FU6H7ThmP2MgUY-uLhf9feZ6US2JwhEQsCuPw9AeV3nQ@mail.gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <2d13de51-e757-b283-1e7f-f4a54f87965a@gentoo.org>
Date:   Wed, 15 Mar 2017 12:46:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAEdQ38FU6H7ThmP2MgUY-uLhf9feZ6US2JwhEQsCuPw9AeV3nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGWMbGhARuwuwFp9+vfCgT/TEcTEDoMmUX4VSE7nDU6IxuUS56hoYWmRdEm92RubDCF0qXnGBxqtUB7YW4A7pH+wfB4zx4iyV3S9pIJATclLuqIZcjSd
 iWA1rqZ8AgzsciBNaBhF2kURNz65zsO8BBmcCuLENsJAhca3vGtLx0E2ZZmhjaqL3Cy7KWXY9q96WbSur1ojGc1IBFTaWVNiPybmmCS7H52xv5dxGtuQay1z
 Rk8UbJC9a/7b3qqYMwXs0F/0Bk1ukQwfbyPni1DfpoR6Cx3lW5n6tzSDJFp2ijfI
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57300
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

On 03/15/2017 11:31, Matt Turner wrote:
> On Wed, Mar 15, 2017 at 7:00 AM, Manuel Lauss <manuel.lauss@gmail.com> wrote:
>>
>> On Wed, Mar 15, 2017 at 10:25 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>>>
>>> On Mon, Mar 13, 2017 at 09:47:57AM +0000, James Hogan wrote:
>>>
>>>>>
>>>>> Note that the corruption is different across reboots, both in the size
>>>>> of the corruption and the location. I saw 1900~ and 1400~ byte
>>>>> sequences corrupted on separate occasions, which don't correspond to
>>>>> the system's 16kB page size.
>>>>>
>>>>> I've tested kernels from v3.19 to 4.11-rc1+ (master branch from
>>>>> today). All exhibit this behavior with differing frequencies. Earlier
>>>>> kernels seem to reproduce the issue less often, while more recent
>>>>> kernels reliably exhibit the problem every boot.
>>>>>
>>>>> How can I further debug this?
>>>>
>>>> It smells a bit like a DMA / caching issue.
>>>>
>>>> Can you provide a full kernel log. That might provide some information
>>>> about caching that might be relevant (e.g. does dcache have aliases?).
>>>
>>> The architecture of the BCM1250 SOC used for the BCM91250 boards are
>>> fully coherent, S-cache and D-cache are physically indexed and tagged.
>>> Only the VIVT (plus the usual ASID tagging) I-cache leaves space for
>>> software to screw up cache management but that shouldn't matter for this
>>> case, so I suggest to start looking into this from the NFS side.
>>
>>
>> I did Matt's tests on Alchemy (VIPT caches) with kernels 3.18 to 4.11-rc
>> against
>> an x86 4.9.15 host, and did not see any problems.   Given Ralf's comment
>> about the BCM1250 caches, maybe you have bad hardware (BCM board or
>> network) ?
> 
> I certainly cannot rule that possibility out. If that is the case, I
> would like to be sure of it -- see a failure in memtester or something
> for instance. Any suggestions? (I have run memtester and never found
> anything)
> 
> For what its worth, did you determine the cause of the NFS corruption
> you reported [1]?
> 
> [1] https://www.spinics.net/lists/mips/msg44006.html

I'm using NFSv4 between my SGI Octane and Intel box with no noticeable issues.
I used both rsync and cp to move a large, ~845MB file between both and
md5summed them both and get the same md5sum back.  What NFS versions and
protocols have you tried?  v4 is TCP-only, but v3 can do both UDP and TCP.

That said, I doubt this'll affect you, but, if you're running the XFS
filesystem, version 5 (crc=1, finobt=1), Do you notice any oddities with
untarring a really large tarball, like a Gentoo stage or such on that BCM
machine?  That's revealed a couple of curious issues that may be
Octane-specific that I haven't tried to trace down yet.  Would be interesting
if you saw them as well.  Specifically, if you get a non-fatal Oops in dmesg
from the above or a message from xfsaild about a possible deadlock in
kmem_alloc(), I'd love to know.



-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
