Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2011 10:30:57 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:29474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491015Ab1EFIay (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 6 May 2011 10:30:54 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p468UTux029351
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 6 May 2011 04:30:29 -0400
Received: from freie.oliva.athome.lsd.ic.unicamp.br (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p468UQ4Q009687
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 6 May 2011 04:30:28 -0400
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
        by freie.oliva.athome.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p468UPAO017491;
        Fri, 6 May 2011 05:30:25 -0300
Received: from livre.localdomain (aoliva@localhost.localdomain [127.0.0.1])
        by livre.localdomain (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p468TJ8S006941;
        Fri, 6 May 2011 05:29:19 -0300
Received: (from aoliva@localhost)
        by livre.localdomain (8.14.3/8.14.3/Submit) id p468TGfq006939;
        Fri, 6 May 2011 05:29:16 -0300
X-Authentication-Warning: livre.localdomain: aoliva set sender to aoliva@redhat.com using -f
From:   Alexandre Oliva <aoliva@redhat.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips <linux-mips@linux-mips.org>, GCC <gcc@gcc.gnu.org>,
        binutils <binutils@sourceware.org>,
        Prasun Kapoor <prasun.kapoor@caviumnetworks.com>
Subject: Re: RFC: A new MIPS64 ABI
Organization: Free thinker, does not speak for Red Hat
                or its Operating System Tools Group
References: <4D5990A4.2050308@caviumnetworks.com>
        <orzkpx6v2m.fsf@livre.localdomain>
        <4D5AC12D.3080108@caviumnetworks.com>
Date:   Fri, 06 May 2011 05:29:16 -0300
In-Reply-To: <4D5AC12D.3080108@caviumnetworks.com> (David Daney's message of
        "Tue, 15 Feb 2011 10:08:45 -0800")
Message-ID: <or7ha4cjvn.fsf@livre.localdomain>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <aoliva@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aoliva@redhat.com
Precedence: bulk
X-list: linux-mips

On Feb 15, 2011, David Daney <ddaney@caviumnetworks.com> wrote:

> On 02/15/2011 09:56 AM, Alexandre Oliva wrote:
>> On Feb 14, 2011, David Daney<ddaney@caviumnetworks.com>  wrote:

>> So, sorry if this is a dumb question, but wouldn't it be much easier to
>> keep on using sign-extended addresses, and just make sure the kernel
>> never allocates a virtual memory range that crosses a sign-bit change,

> No, it is not possible.  The MIPS (and MIPS64) hardware architecture
> does not allow userspace access to addresses with the high bit (two
> bits for mips64) set.

Interesting.  I guess this makes it far easier to transition to the u32
ABI: n32 addresses all have the 32-bit MSB bit clear, so n32 binaries
can be used within u32 environments, as long as the environment refrains
from using addresses that have the MSB bit set.

So we could switch lib32 to u32, have a machine-specific bit set for u32
binaries, and if the kernel starts an executable or interpreter that has
that bit clear, it will refrain from allocating any n32-invalid address
for that process.  Furthermore, libc, upon loading a library, should be
able to notify the kernel when an n32 library is to be loaded, to which
the kernel would respond either with failure (if that process already
uses u32-valid but n32-invalid addresses) or success (switching to n32
mode if not in it already).

Am I missing any other issues?

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
