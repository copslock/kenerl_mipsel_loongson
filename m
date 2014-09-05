Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 22:44:02 +0200 (CEST)
Received: from terminus.zytor.com ([198.137.202.10]:47768 "EHLO mail.zytor.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008131AbaIEUn7sdbKY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Sep 2014 22:43:59 +0200
Received: from anacreon.sc.intel.com ([192.55.55.41])
        (authenticated bits=0)
        by mail.zytor.com (8.14.7/8.14.5) with ESMTP id s85Khnpq027694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 5 Sep 2014 13:43:50 -0700
Message-ID: <540A2080.8050404@zytor.com>
Date:   Fri, 05 Sep 2014 13:43:44 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
MIME-Version: 1.0
To:     Andy Lutomirski <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
CC:     Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Post-merge-window ping (Re: [PATCH v4 0/5] x86: two-phase syscall
 tracing and seccomp fastpath)
References: <CALCETrUaZ8w92g96SmFEZDE0Jr+0Moeo+S24-TyW8crrK5reSg@mail.gmail.com> <540A1800.3000005@zytor.com>
In-Reply-To: <540A1800.3000005@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42451
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

On 09/05/2014 01:07 PM, H. Peter Anvin wrote:
> On 08/26/2014 06:32 PM, Andy Lutomirski wrote:
>> On Mon, Jul 28, 2014 at 8:38 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> This applies to:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp-fastpath
>>>
>>> Gitweb:
>>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>>
>> Hi all-
>>
>> AFAIK the only thing that's changed since I submitted it is that the
>> 3.17 merge window is closed.  Kees rebased the tree this applies to,
>> but I think the patches all still apply.  What, if anything, do I need
>> to do to help this along for 3.18?
>>
> 
> Just put this stuff in a branch and running through my personal test
> battery now.
> 

... and they fail build testing.  Specifically, both i386 and x86-64
allnoconfig fail with:

arch/x86/kernel/ptrace.c: In function ‘syscall_trace_enter_phase2’:
  LD      fs/quota/built-in.o
../arch/x86/kernel/ptrace.c:1579:2: error: implicit declaration of
function ‘seccomp_phase2’ [-Werror=implicit-function-declaration]
  if (phase1_result > 1 && seccomp_phase2(phase1_result)) {
  ^
cc1: some warnings being treated as errors
  CC      arch/x86/kernel/step.o
make[4]: *** [arch/x86/kernel/ptrace.o] Error 1

	-hpa
