Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 16:08:51 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:49719 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27014678AbbBCPIsuyCXD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 16:08:48 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 882021538A; Tue,  3 Feb 2015 15:08:41 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Kevin Cernekee <cernekee@chromium.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Oleg Kolosov <bazurbat@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Few questions about porting Linux to SMP86xx boards
References: <54CEACC1.1040701@gmail.com>
        <CAJiQ=7AQuP1JsiApEs4yAR449w6-pcR_qqhSqKdpqNHL5L1mRQ@mail.gmail.com>
        <yw1xwq409odv.fsf@unicorn.mansr.com> <54D017D4.70200@gmail.com>
        <alpine.LFD.2.11.1502030930000.22715@eddie.linux-mips.org>
        <CAJiQ=7DWiSEeBUiKCPZKn8fUwxUdOrCqMLDYFTaXSMTGsJCJOA@mail.gmail.com>
Date:   Tue, 03 Feb 2015 15:08:41 +0000
In-Reply-To: <CAJiQ=7DWiSEeBUiKCPZKn8fUwxUdOrCqMLDYFTaXSMTGsJCJOA@mail.gmail.com>
        (Kevin Cernekee's message of "Tue, 3 Feb 2015 06:28:14 -0800")
Message-ID: <yw1xsien9gna.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

Kevin Cernekee <cernekee@chromium.org> writes:

> On Tue, Feb 3, 2015 at 3:39 AM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
>>  For the record -- the exact address `__fast_iob' reads from does not
>> really matter, all it has to guarantee is no side effects on read access.
>> Using the base of KSEG1 was therefore a natural choice for legacy MIPS
>> processors that set the architecture back at the time this code was added,
>> as the presence of exception vectors there guaranteed this area of the
>> address space behaved like RAM so the same location did for any system.
>>
>>  With the introduction of revision 2 of the MIPS architecture the CP0
>> EBase register was added and consequently there is no longer a guarantee
>> that exception vectors reside at the base of KSEG1.  Using the value read
>> from CP0.EBase to determine a usable address might therefore be a better
>> idea, although the current revision of the MIPS architecture specification
>> that includes segmentation control makes it a bit complicated.  Using a
>> dummy page mapped uncached instead might work the best.
>
> Would something like this work, assuming __fast_iob() doesn't get
> called before mem_init()?
>
> CKSEG1ADDR((void *)empty_zero_page)
>
> It is currently a GPL export, so maybe that would need to change to
> allow non-GPL drivers to use iob().  But that's still easier than
> allocating another dummy page.

The 86xx has a 64k remappable block at CPU physical address zero, so one
option would be to simply point this at some actual memory and leave the
macro alone.  There doesn't seem to be anything useful in that bus
address range anyway.  Reading returns zeros, and writes have no
apparent effect.  Maybe it's even safe to do a dummy read from there in
iob().

-- 
Måns Rullgård
mans@mansr.com
