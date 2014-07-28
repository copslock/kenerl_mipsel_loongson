Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 02:48:18 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:41587 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6861504AbaG1XpMfgo3u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Jul 2014 01:45:12 +0200
Received: from tazenda.hos.anvin.org ([IPv6:2601:9:7280:900:3408:aaff:fe41:adba])
        (authenticated bits=0)
        by mail.zytor.com (8.14.7/8.14.5) with ESMTP id s6SNj8fm024617
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Mon, 28 Jul 2014 16:45:08 -0700
Message-ID: <53D6E07F.7090806@zytor.com>
Date:   Mon, 28 Jul 2014 16:45:03 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Kees Cook <keescook@chromium.org>
CC:     linux-arch <linux-arch@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Will Drewry <wad@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexei Starovoitov <ast@plumgrid.com>
Subject: Re: [PATCH v3 0/8] Two-phase seccomp and x86 tracing changes
References: <cover.1405992946.git.luto@amacapital.net>  <CAGXu5jJ93-vto9voMENc4jX5itcd_Rm5AZjeChF57fpMYnWocA@mail.gmail.com>    <CALCETrVwqDeRbFOw=k_OhQZ4V6Pn5v3t8ODw75UuE7HKPFz=Sw@mail.gmail.com>    <53D68F91.4000106@zytor.com>    <CAGXu5jKJOrtjY9JsCBUvUbj_y4Hv+AeMEmGwWZZ18FmiZmAbbQ@mail.gmail.com>    <53D6DE1E.1060501@zytor.com> <CAGXu5jLjmHczeQiJN1Q+aGQKn_B+08FEXHWxjku6QedkGDhDTg@mail.gmail.com>
In-Reply-To: <CAGXu5jLjmHczeQiJN1Q+aGQKn_B+08FEXHWxjku6QedkGDhDTg@mail.gmail.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
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

On 07/28/2014 04:42 PM, Kees Cook wrote:
> On Mon, Jul 28, 2014 at 4:34 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> On 07/28/2014 04:29 PM, Kees Cook wrote:
>>> On Mon, Jul 28, 2014 at 10:59 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>>>> On 07/23/2014 12:20 PM, Andy Lutomirski wrote:
>>>>>
>>>>> It looks like patches 1-4 have landed here:
>>>>>
>>>>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>>>>>
>>>>> hpa, what's the route forward for the x86 part?
>>>>>
>>>>
>>>> I guess I should discuss this with Kees to figure out what makes most
>>>> sense.  In the meantime, could you address Oleg's question?
>>>
>>> Since the x86 parts depend on the seccomp parts, I'm happy if you
>>> carry them instead of having them land from my tree. Otherwise I'm
>>> open to how to coordinate timing.
>>>
>>
>> You mean for me to carry the seccomp part as well?
> 
> If that makes sense as far as the coordination, that's fine with me.
> Otherwise I'm not sure how x86 can build without having the seccomp
> changes in your tree.
> 

Exactly.  What I guess I'll do is set up a separate tip branch for this,
pull your branch into it, and then put the x86 patches on top.  Does
that make sense for everyone?

	-hpa
