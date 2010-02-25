Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 19:49:19 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13223 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492000Ab0BYStP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2010 19:49:15 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b86c6310001>; Thu, 25 Feb 2010 10:49:21 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 25 Feb 2010 10:48:12 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 25 Feb 2010 10:48:12 -0800
Message-ID: <4B86C5EB.6090303@caviumnetworks.com>
Date:   Thu, 25 Feb 2010 10:48:11 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Thunderbird/3.0.1
MIME-Version: 1.0
To:     Joel Brobecker <brobecker@adacore.com>
CC:     gdb-patches@sourceware.org,
        "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Make mips-linux signal frame unwinding more robust.
References: <4B82CEC4.2010607@caviumnetworks.com> <20100225174739.GA2851@adacore.com>
In-Reply-To: <20100225174739.GA2851@adacore.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Feb 2010 18:48:12.0144 (UTC) FILETIME=[14CFB700:01CAB64B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/25/2010 09:47 AM, Joel Brobecker wrote:
>> This patch makes gdb follow suit and find the sigcontext_base using
>> the signal frame's SP rather than an offset from the trampoline.
>
> Is there a document that explains that the sigcontext structure is
> always going to be at the frame's SP?

No official document, however the principle of maintaining binary 
compatibility is important, and recognized by the kernel maintainers.

There are several things that constrain the the changes that can be made 
in the kernel:

1) The glibc setcontext API as discussed here:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=alpine.DEB.1.10.0902282326580.4064%40tp.orcam.me.uk

2) libgcc's unwinder:

http://gcc.gnu.org/viewcvs/trunk/gcc/config/mips/linux-unwind.h?revision=145841&view=markup

>
> I don't know mips-linux, but something looked funny to me: You avoid
> the use of SIGFRAME_CODE_OFFSET to compute the address where the sigcontext
> structure is located, but you still use it to compute the frame base
> address (used when building the frame ID).  Is the frame base address
> still a constant offset from FUNC, or does the frame ID base address
> also needs to be changed.

Right, I missed that part.  When it started working, I stopped patching. 
  I will take another look at that part.


>
> I believe that Daniel J has a good knowledge of mips-linux, and would be
> an ideal reviewer.  If he doesn't have time, though, I'm OK with approving
> a patch for the HEAD branch.  For the 7.1 branch, though, I'd rather have
> a more knowledgeable opinion.
>

Thanks,
David Daney
