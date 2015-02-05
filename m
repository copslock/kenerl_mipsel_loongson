Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2015 16:28:42 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:58066 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012593AbbBEP2hxc5Ct convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2015 16:28:37 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 55F561538A; Thu,  5 Feb 2015 15:28:31 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com>
        <54BF12B9.8000507@gentoo.org>
        <alpine.LFD.2.11.1501210347180.28301@eddie.linux-mips.org>
        <20150126131621.GB31322@linux-mips.org>
        <alpine.LFD.2.11.1501261358540.28301@eddie.linux-mips.org>
        <54C68429.4030701@gmail.com>
        <alpine.LFD.2.11.1501261904310.28301@eddie.linux-mips.org>
        <54C69FCE.80002@gmail.com>
        <alpine.LFD.2.11.1501262345320.28301@eddie.linux-mips.org>
        <54C7ED94.6070507@gmail.com>
        <alpine.LFD.2.11.1501272231190.28301@eddie.linux-mips.org>
Date:   Thu, 05 Feb 2015 15:28:31 +0000
In-Reply-To: <alpine.LFD.2.11.1501272231190.28301@eddie.linux-mips.org>
        (Maciej W. Rozycki's message of "Thu, 5 Feb 2015 13:46:38 +0000
        (GMT)")
Message-ID: <yw1xd25o9y3k.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45725
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

"Maciej W. Rozycki" <macro@linux-mips.org> writes:

> On Tue, 27 Jan 2015, David Daney wrote:
>
>> > > It is bizarre, and perhaps almost mind bending, but that seems to
>> > > be how it is specified.  Certainly the OCTEON implementation
>> > > works this way.
>> >
>> >   Well, I think this observation:
>> >
>> > "2.2.2.2 Memory Operation Functions
>> >
>> > "Regardless of byte ordering (big- or little-endian), the address of a
>> > halfword, word, or doubleword is the smallest byte address of the bytes
>> > that form the object.  For big-endian ordering this is the
>> > most-significant byte; for a little-endian ordering this is the
>> > least-significant byte."
>> >
>> > contradicts your claim [...]
>> 
>> One can argue about the meaning of the text in the reference manual. But in
>> the end, the behavior of real processors is what we are forced to deal with.
>> 
>> In the case of all existing OCTEON processors, there is no Status[RE]
>> bit, but you can switch the endianess of the entire CPU under
>> software control.  I am really making statements based on how they
>> actually work, not assertions about the meaning of the specification.
>> However, I do believe that this is what is specified.
>> 
>> If you have access to processors with a working Status[RE] bit, you could
>> empirically determine how they work.
>
>  Well, I do actually, I have a working machine driven by an R4000 
> processor.  It was the original implementation of the Status.RE feature 
> and therefore it can be used as the reference.  I don't feel tempted to 
> use my time to actually make any checks though.

Is it reasonably easy to test this on an R10000 (SGI Octane) running
IRIX 6.5?

-- 
Måns Rullgård
mans@mansr.com
