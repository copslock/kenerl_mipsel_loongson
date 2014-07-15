Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jul 2014 03:53:39 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:39009 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860076AbaGOBxgtQ63L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jul 2014 03:53:36 +0200
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s6F1rKUU011484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 15 Jul 2014 01:53:22 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
        by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s6F1rIdr007752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 15 Jul 2014 01:53:19 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s6F1rH4u000346;
        Tue, 15 Jul 2014 01:53:17 GMT
Received: from [10.191.130.12] (/10.191.130.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Jul 2014 18:53:17 -0700
Message-ID: <53C48986.5010109@oracle.com>
Date:   Tue, 15 Jul 2014 11:53:10 +1000
From:   James Morris <james.l.morris@oracle.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Kees Cook <keescook@chromium.org>
CC:     Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v10 0/11] seccomp: add thread sync ability
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>   <20140711164931.GA18473@redhat.com>     <CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com> <CAGXu5jJJsiTxxn5UijkBz7jpWgqg01BS=Zc0WbHXbs0vH_xPMQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJJsiTxxn5UijkBz7jpWgqg01BS=Zc0WbHXbs0vH_xPMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: acsinet22.oracle.com [141.146.126.238]
Return-Path: <james.l.morris@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.l.morris@oracle.com
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

On 07/15/2014 04:59 AM, Kees Cook wrote:
> Hi James,
>
> Is this series something you would carry in the security-next tree?
> That has traditionally been where seccomp features have landed in the
> past.
>
> -Kees
>
>
> On Fri, Jul 11, 2014 at 10:55 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Fri, Jul 11, 2014 at 9:49 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 07/10, Kees Cook wrote:
>>>>
>>>> This adds the ability for threads to request seccomp filter
>>>> synchronization across their thread group (at filter attach time).
>>>> For example, for Chrome to make sure graphic driver threads are fully
>>>> confined after seccomp filters have been attached.
>>>>
>>>> To support this, locking on seccomp changes via thread-group-shared
>>>> sighand lock is introduced, along with refactoring of no_new_privs. Races
>>>> with thread creation are handled via delayed duplication of the seccomp
>>>> task struct field and cred_guard_mutex.
>>>>
>>>> This includes a new syscall (instead of adding a new prctl option),
>>>> as suggested by Andy Lutomirski and Michael Kerrisk.
>>>
>>> I do not not see any problems in this version,
>>
>> Awesome! Thank you for all the reviews. :) If Andy and Michael are
>> happy with this too, I think this is in good shape. \o/
>>
>> -Kees
>>
>>>
>>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>>>
>>
>>
>>
>> --
>> Kees Cook
>> Chrome OS Security
>
>
>

Yep, certainly.
