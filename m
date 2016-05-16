Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2016 16:21:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50285 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028345AbcEPOVHnhjRn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2016 16:21:07 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 25FF837BBE4CA;
        Mon, 16 May 2016 15:20:58 +0100 (IST)
Received: from hhmail02.hh.imgtec.org ([fe80::5400:d33e:81a4:f775]) by
 HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3%26]) with mapi id
 14.03.0266.001; Mon, 16 May 2016 15:21:01 +0100
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "binutils@sourceware.org" <binutils@sourceware.org>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
CC:     Joseph Myers <joseph@codesourcery.com>
Subject: RE: [RFC v2] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
Thread-Topic: [RFC v2] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
Thread-Index: AQHRrgOUwaHVYqP+hUemv+Dv8MXdNJ+7lSHw
Date:   Mon, 16 May 2016 14:21:00 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B023537E40C27F@hhmail02.hh.imgtec.org>
References: <alpine.DEB.2.00.1605141043120.6794@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1605141043120.6794@tp.orcam.me.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.105]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Hi Maciej,

Thanks for the update.  I've read through the whole proposal again and
it looks good.  I'd like to discuss legacy objects a bit more though...

Maciej Rozycki <Maciej.Rozycki@imgtec.com> writes:
> 3.4 Relocatable Object Generation
> 
>  Tools that produce relocatable objects such as the assembler shall
> always produce a SHT_MIPS_ABIFLAGS section according to the IEEE Std 754
> compliance mode selected.  In the absence of any explicit user
> instructions the `strict' mode shall be assumed.  No new `legacy'
> objects shall be produced.

Is it necessary to say that no new legacy objects can be created?

I think there is value in still being able to generate legacy objects because
of the fact that strict executables leave no room for override at runtime.
Apart from the fact that strict cannot be disabled there is otherwise no
difference between legacy and strict compliance modes.

I believe the strict option is really intended for conscious use so that
programmers who know they need it, can use it. Ordinary users still get the
casual safety they need as legacy objects are just as good as strict until
overridden. If we lose the ability to override then in some environments we
will accumulate lots of needlessly strict executables just because of a tools
upgrade whereas the old tools would have generated executables that were as
safe but also could be overridden by kernel options. 

Allowing legacy objects to be generated may also allow the linkage rules to
be tightened.  I.e. Forcing a relaxed mode at link time could simply fail
if confronted by a strict object instead only allowing legacy objects to
be relaxed.

A default build of GCC and binutils would therefore still generate legacy
objects until someone consciously updated the configure options or used
command line options.

Thanks,
Matthew
