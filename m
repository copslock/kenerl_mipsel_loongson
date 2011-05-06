Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2011 19:00:27 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15577 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491069Ab1EFRAT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2011 19:00:19 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4dc4295c0000>; Fri, 06 May 2011 10:01:16 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 6 May 2011 10:00:15 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 6 May 2011 10:00:15 -0700
Message-ID: <4DC42919.5030403@caviumnetworks.com>
Date:   Fri, 06 May 2011 10:00:09 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Alexandre Oliva <aoliva@redhat.com>
CC:     linux-mips <linux-mips@linux-mips.org>, GCC <gcc@gcc.gnu.org>,
        binutils <binutils@sourceware.org>,
        Prasun Kapoor <prasun.kapoor@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: RFC: A new MIPS64 ABI
References: <4D5990A4.2050308@caviumnetworks.com>       <orzkpx6v2m.fsf@livre.localdomain>      <4D5AC12D.3080108@caviumnetworks.com> <or7ha4cjvn.fsf@livre.localdomain>
In-Reply-To: <or7ha4cjvn.fsf@livre.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2011 17:00:15.0147 (UTC) FILETIME=[11E9A7B0:01CC0C0F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 05/06/2011 01:29 AM, Alexandre Oliva wrote:
> On Feb 15, 2011, David Daney<ddaney@caviumnetworks.com>  wrote:
>
>> On 02/15/2011 09:56 AM, Alexandre Oliva wrote:
>>> On Feb 14, 2011, David Daney<ddaney@caviumnetworks.com>   wrote:
>
>>> So, sorry if this is a dumb question, but wouldn't it be much easier to
>>> keep on using sign-extended addresses, and just make sure the kernel
>>> never allocates a virtual memory range that crosses a sign-bit change,
>
>> No, it is not possible.  The MIPS (and MIPS64) hardware architecture
>> does not allow userspace access to addresses with the high bit (two
>> bits for mips64) set.
>
> Interesting.  I guess this makes it far easier to transition to the u32
> ABI: n32 addresses all have the 32-bit MSB bit clear, so n32 binaries
> can be used within u32 environments, as long as the environment refrains
> from using addresses that have the MSB bit set.
>

Correct.

> So we could switch lib32 to u32, have a machine-specific bit set for u32
> binaries, and if the kernel starts an executable or interpreter that has
> that bit clear, it will refrain from allocating any n32-invalid address
> for that process.  Furthermore, libc, upon loading a library, should be
> able to notify the kernel when an n32 library is to be loaded, to which
> the kernel would respond either with failure (if that process already
> uses u32-valid but n32-invalid addresses) or success (switching to n32
> mode if not in it already).
>
> Am I missing any other issues?

No, this is pretty much what Ralf and I came up with on IRC.

We tag u32 objects (in a similar manner to how non-executable stack is 
done).  The linker will propagate the u32 tag as it links things together.

u32 shared libraries are compatible with legacy n32 binaries as long as 
the OS doesn't map any memory where the address has bit 31 set.

When the OS loads an n32 executable it would check the u32 tag (both of 
the executable and ld.so) and adjust its memory allocation strategy.

The OS will continue to map the VDSO at the 2GB point.  This will cause 
the maximum size of any object to be compatible with the 32-bit n32 
ptrdiff_t.

I think once the OS puts a process into u32 mode, there is no going 
back.  We would just have ld.so refuse to load any shared objects that 
were not compatible with the current mode.

We would continue to place libraries in /lib32, /usr/lib32, 
/usr/local/lib32, etc.


David Daney
