Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2014 23:42:33 +0200 (CEST)
Received: from mail-vc0-f171.google.com ([209.85.220.171]:36875 "EHLO
        mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843091AbaFMVm3nqxww (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jun 2014 23:42:29 +0200
Received: by mail-vc0-f171.google.com with SMTP id id10so2885848vcb.16
        for <linux-mips@linux-mips.org>; Fri, 13 Jun 2014 14:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ZljoJp06/rm8UKcN8vI+ix/Dkl+y/t0aKIkpoDzUiN4=;
        b=HiVHyRJZaOM2+LVaNRAgmFea7/ao4hfFX0efY88hrEpRuNQkgLW4i2rNxlKLAByjje
         dHprGvP1RujyLBsWWRf69DWKNqNz4L+W2M9CPhyaAN/jHgswbFU4c+ybcM3s9WrPDp1A
         asoK1ZVlBuqYNuZEP03Qy6WQXlgi9VUE341ELTUNa9rxNE2QYSknBuxIgaFjczs3Qv96
         bRW2NXqs5eVTobQaYnzb59VlmJKdv4PmGN3YydpS/oItaVLFvTIKx7YfSdnjuhIE+LxI
         gR9mZRy0bq9n3VSp61eDxRT+l1TUnhKvFpgRC/CCbTkODpq7YtmqEBSQ9K4vlbYD2wwm
         pkjg==
X-Gm-Message-State: ALoCoQnIKVpvtIzNwFCkmg8hg19pYYN3ce7m3UD0uXgjGSYPH5+JSJGFIsXo+M28KY7MXlPRY/+5
X-Received: by 10.52.52.168 with SMTP id u8mr2959268vdo.25.1402695743511; Fri,
 13 Jun 2014 14:42:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.58.91.40 with HTTP; Fri, 13 Jun 2014 14:42:03 -0700 (PDT)
In-Reply-To: <CAMEtUuykiN=FvBFZLp8ieN2ymt0=opfyFee0UC9aRpcW3SQ0pg@mail.gmail.com>
References: <1402457121-8410-1-git-send-email-keescook@chromium.org>
 <1402457121-8410-7-git-send-email-keescook@chromium.org> <CAMEtUuwKRUYN_qdnCj42G3Z1UT3vMYPoJqXd2_PjV+_J3WA+8w@mail.gmail.com>
 <CALCETrVCJvnj9yr5yhhZTn_Gq32mgSqOhMRi16Y=_LvqGOTZ5g@mail.gmail.com> <CAMEtUuykiN=FvBFZLp8ieN2ymt0=opfyFee0UC9aRpcW3SQ0pg@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 13 Jun 2014 14:42:03 -0700
Message-ID: <CALCETrVbsGjgtHtQKftxcNJB_vY5=Dd3FckW-1C9=xgdOrR6_A@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] seccomp: add "seccomp" syscall
To:     Alexei Starovoitov <ast@plumgrid.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Fri, Jun 13, 2014 at 2:37 PM, Alexei Starovoitov <ast@plumgrid.com> wrote:
> On Fri, Jun 13, 2014 at 2:25 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Fri, Jun 13, 2014 at 2:22 PM, Alexei Starovoitov <ast@plumgrid.com> wrote:
>>> On Tue, Jun 10, 2014 at 8:25 PM, Kees Cook <keescook@chromium.org> wrote:
>>>> This adds the new "seccomp" syscall with both an "operation" and "flags"
>>>> parameter for future expansion. The third argument is a pointer value,
>>>> used with the SECCOMP_SET_MODE_FILTER operation. Currently, flags must
>>>> be 0. This is functionally equivalent to prctl(PR_SET_SECCOMP, ...).
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> Cc: linux-api@vger.kernel.org
>>>> ---
>>>>  arch/x86/syscalls/syscall_32.tbl  |    1 +
>>>>  arch/x86/syscalls/syscall_64.tbl  |    1 +
>>>>  include/linux/syscalls.h          |    2 ++
>>>>  include/uapi/asm-generic/unistd.h |    4 ++-
>>>>  include/uapi/linux/seccomp.h      |    4 +++
>>>>  kernel/seccomp.c                  |   63 ++++++++++++++++++++++++++++++++-----
>>>>  kernel/sys_ni.c                   |    3 ++
>>>>  7 files changed, 69 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/arch/x86/syscalls/syscall_32.tbl b/arch/x86/syscalls/syscall_32.tbl
>>>> index d6b867921612..7527eac24122 100644
>>>> --- a/arch/x86/syscalls/syscall_32.tbl
>>>> +++ b/arch/x86/syscalls/syscall_32.tbl
>>>> @@ -360,3 +360,4 @@
>>>>  351    i386    sched_setattr           sys_sched_setattr
>>>>  352    i386    sched_getattr           sys_sched_getattr
>>>>  353    i386    renameat2               sys_renameat2
>>>> +354    i386    seccomp                 sys_seccomp
>>>> diff --git a/arch/x86/syscalls/syscall_64.tbl b/arch/x86/syscalls/syscall_64.tbl
>>>> index ec255a1646d2..16272a6c12b7 100644
>>>> --- a/arch/x86/syscalls/syscall_64.tbl
>>>> +++ b/arch/x86/syscalls/syscall_64.tbl
>>>> @@ -323,6 +323,7 @@
>>>>  314    common  sched_setattr           sys_sched_setattr
>>>>  315    common  sched_getattr           sys_sched_getattr
>>>>  316    common  renameat2               sys_renameat2
>>>> +317    common  seccomp                 sys_seccomp
>>>>
>>>>  #
>>>>  # x32-specific system call numbers start at 512 to avoid cache impact
>>>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>>>> index b0881a0ed322..1713977ee26f 100644
>>>> --- a/include/linux/syscalls.h
>>>> +++ b/include/linux/syscalls.h
>>>> @@ -866,4 +866,6 @@ asmlinkage long sys_process_vm_writev(pid_t pid,
>>>>  asmlinkage long sys_kcmp(pid_t pid1, pid_t pid2, int type,
>>>>                          unsigned long idx1, unsigned long idx2);
>>>>  asmlinkage long sys_finit_module(int fd, const char __user *uargs, int flags);
>>>> +asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
>>>> +                           const char __user *uargs);
>>>
>>> It looks odd to add 'flags' argument to syscall that is not even used.
>>> It don't think it will be extensible this way.
>>> 'uargs' is used only in 2nd command as well and it's not 'char __user *'
>>> but rather 'struct sock_fprog __user *'
>>> I think it makes more sense to define only first argument as 'int op' and the
>>> rest as variable length array.
>>> Something like:
>>> long sys_seccomp(unsigned int op, struct nlattr *attrs, int len);
>>> then different commands can interpret 'attrs' differently.
>>> if op == mode_strict, then attrs == NULL, len == 0
>>> if op == mode_filter, then attrs->nla_type == seccomp_bpf_filter
>>> and nla_data(attrs) is 'struct sock_fprog'
>>
>> Eww.  If the operation doesn't imply the type, then I think we've
>> totally screwed up.
>>
>>> If we decide to add new types of filters or new commands, the syscall prototype
>>> won't need to change. New commands can be added preserving backward
>>> compatibility.
>>> The basic TLV concept has been around forever in netlink world. imo makes
>>> sense to use it with new syscalls. Passing 'struct xxx' into syscalls
>>> is the thing
>>> of the past. TLV style is more extensible. Fields of structures can become
>>> optional in the future, new fields added, etc.
>>> 'struct nlattr' brings the same benefits to kernel api as protobuf did
>>> to user land.
>>
>> I see no reason to bring nl_attr into this.
>>
>> Admittedly, I've never dealt with nl_attr, but everything
>> netlink-related I've even been involved in has involved some sort of
>> API atrocity.
>
> netlink has a lot of legacy and there is genetlink which is not pretty
> either because of extra socket creation, binding, dealing with packet
> loss issues, but the key concept of variable length encoding is sound.
> Right now seccomp has two commands and they already don't fit
> into single syscall neatly. Are you saying there should be two syscalls
> here? What about another seccomp related command? Another syscall?
> imo all seccomp related commands needs to be mux/demux-ed under
> one syscall. What is the way to mux/demux potentially very different
> commands under one syscall? I cannot think of anything better than
> TLV style. 'struct nlattr' is what we have today and I think it works fine.
> I'm not suggesting to bring the whole netlink into the picture, but rather
> TLV style of encoding different arguments for different commands.

I'm unconvinced.  These are simple commands, and I think the interface
should be simple.  Syscalls are cheap.

As an example, the interface could be:

int seccomp_add_filter(const struct sock_fprog *filter, unsigned int flags);

The "tsync" operation would be seccomp_add_filter(NULL,
SECCOMP_ADD_FILTER_TSYNC) -- it's equivalent to adding an
always-accept filter and syncing threads.

But, frankly, this kind of stuff should probably be "do operation X".
IIUC nl_attr is more like "do something, with these tags and values",
which results in oddities like whatever should happen of more than one
tag is set.

--Andy

-- 
Andy Lutomirski
AMA Capital Management, LLC
