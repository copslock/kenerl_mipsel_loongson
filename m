Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 19:17:00 +0200 (CEST)
Received: from out02.mta.xmission.com ([166.70.13.232]:37974 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012329AbbHERQ53fgvg convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Aug 2015 19:16:57 +0200
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1ZN2J7-0001bZ-LM; Wed, 05 Aug 2015 11:16:49 -0600
Received: from 97-119-22-40.omah.qwest.net ([97.119.22.40] helo=x220.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1ZN2J6-0003Tb-Ai; Wed, 05 Aug 2015 11:16:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?= 
        <hidehiro.kawai.ez@hitachi.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mips\@linux-mips.org" <linux-mips@linux-mips.org>,
        Baoquan He <bhe@redhat.com>,
        "kexec\@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "HATAYAMA Daisuke" <d.hatayama@jp.fujitsu.com>,
        =?utf-8?B?5bmz5p2+6ZuF?=
         =?utf-8?B?5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= 
        <masami.hiramatsu.pt@hitachi.com>,
        Daniel Walker <dwalker@fifo99.com>,
        "Ingo Molnar" <mingo@kernel.org>
References: <20150724011615.6834.79628.stgit@softrs>
        <55BF4B1F.9000602@hitachi.com> <877fpcfi2j.fsf@x220.int.ebiederm.org>
        <04EAB7311EE43145B2D3536183D1A84454926993@GSjpTKYDCembx31.service.hitachi.net>
Date:   Wed, 05 Aug 2015 12:10:06 -0500
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454926993@GSjpTKYDCembx31.service.hitachi.net>
        (=?utf-8?B?Iuays+WQiOiLseWujw==?= / =?utf-8?Q?KAWAI=EF=BC=8CHIDEHIRO=22's?=
 message of "Tue, 4 Aug 2015 11:41:14
        +0000")
Message-ID: <87io8tvez5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-AID: U2FsdGVkX18RPZC33dA55LTTOfLKiKElNPZ8H7AUiII=
X-SA-Exim-Connect-IP: 97.119.22.40
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC V2 PATCH 0/1] kexec: crash_kexec_post_notifiers boot option related fixes
X-SA-Exim-Version: 4.2.1 (built Wed, 24 Sep 2014 11:00:52 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
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

"河合英宏 / KAWAI，HIDEHIRO"  <hidehiro.kawai.ez@hitachi.com> writes:

> Hello,
>
> Thanks for the reply.
>
>> From: Eric W. Biederman [mailto:ebiederm@xmission.com]
> [...]
>> A specific hook for a very specific purpose when there is no other way
>> we can consider.
>
> So, is kmsg_dump like feature admissible?
>
>> If you don't have something that generalises well into a general purpose
>> operation that it makes sense for everyone to call you can always use
>> the world's largest aka you can run code before the new kernel starts
>> that is loaded with kexec_load.
>
> One of our purposes, notifying "I'm dying", would be achieved by purgatory
> code provided by kexec command as I stated before.  Since the way of the
> notification will differ from each vendor, I think we need to modify
> the purgatory codes pluggable.  Also, I think we need some parameter
> passing mechanism to the purgatory code.  For example, passing the panic
> message via boot parameter to save it to SEL.  Although I'm not sure
> we can do that (I've not investigated well yet).  Is that acceptable?

I think the address of panic message is available in crash notes.  If
not that is very reasonable to add.

Updating the SEL from purgatory after purgatory has validated the
checksums of the crash handling code is acceptable.

All that is desired is to run as little code as possible in a kernel
that is known broken.  Once the checksums have verified things in
purgatory you should be in good shape, and there is no possibility of
relying on broken infrastructure because that code simply is not present
in purgatory.

We already have a few early_printk style drivers in purgatory and I
don't the code to update the SEL would be much worse.

On the flip side there are enough firmware bugs that I personally would
not want to rely on firmware code running properly when the machine is
in a known broken state, so I don't want the SEL update to be
unconditional.

Eric
