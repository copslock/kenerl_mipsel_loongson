Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Jan 2014 02:54:22 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:54597 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827281AbaARByUlvT0- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 18 Jan 2014 02:54:20 +0100
Message-ID: <52D9DEBF.3090008@phrozen.org>
Date:   Sat, 18 Jan 2014 02:54:07 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Huacai Chen <chenhc@lemote.com>
CC:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V16 02/12] MIPS: Loongson: Add basic Loongson-3 CPU support
References: <1389149068-24376-1-git-send-email-chenhc@lemote.com> <1389149068-24376-3-git-send-email-chenhc@lemote.com> <20140108195838.GA10463@hall.aurel32.net> <CAAhV-H4tx=sCk=iUwuCfnCS+rbmtu5Y_UcpAn6JXDoobA+OGrQ@mail.gmail.com> <20140109213624.GG11944@hall.aurel32.net> <CAAhV-H7+XDYi3i7bp7q0t0oszi8tmAVGtTeAkP+t9VZ6sD3b1w@mail.gmail.com> <20140112095752.GA14181@ohm.rr44.fr> <20140112121048.GA1797@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20140112121048.GA1797@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

Hi,

On 12/01/2014 13:10, Aaro Koskinen wrote:
>>>>>> As remarked by Aaro Koskinen, changing the names of the Loongson 2 CPUs
>>>>>> > > >> > (which is displayedd in /proc/cpuinfo) will break at least
>>>>>> > > >> > GCC -march=native option. The name should be left unchanged.
>>>>>> > > >> >
>>>>> > > >> Can I keep it as is and then submit a patch to GCC? I think it is important
>>>>> > > >> to distinguish 2E/2F/3A in cpuinfo.
>>>> > > >
>>>> > > > I think first the patch has to be integrated to GCC, and then you have
>>>> > > > to wait at least a few months so that people start using the new
>>>> > > > version. Then it should be possible to modify this.
>>>> > > >
>>>> > > > That said, other programs than GCC might use this information from
>>>> > > > /proc/cpuinfo and might also break with this change.
>>> > > The GCC patch has been accepted yesterday, and the coming V17 patchset
>>> > > won't be accept at least in kernel-3.14,
>>> > > So, I'll keep the name in V17.
>> > 
>> > Kernel 3.15 is expected in roughly 6 months, it might still be a bit
>> > tight for the change to propagate, even if I have seen it has been added
>> > to the 4.8 branch. What the others things? Aaro?
> It doesn't really matter if some future version of GCC supports the
> new name. Most people will continue to use older toolchains for years,
> and we shouldn't change the behaviour of those.
>
> A.
>

NAK

Breaking the ABI is a really bad idea. I cannot think of any valid
reason that would allow me to merge this change.

    John
