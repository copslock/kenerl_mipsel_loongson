Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 23:19:27 +0100 (CET)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:62946 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007366AbaLRWT0RQWba (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 23:19:26 +0100
Received: by mail-ob0-f172.google.com with SMTP id va8so6431806obc.3;
        Thu, 18 Dec 2014 14:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=w0/Thw6cwAptPXc/mZMWWjtW4Ih2DOnDLzxQwaww1mA=;
        b=AULunLG5AhQIZ1g0Yj+8OBN4wbrfD97qHp8vR3+0+VgDkM8Pca+n1AJ92ZopGYsFJk
         jpthc3jw7kXCPtOYRaFUdMUIrBQbwAFxRUlupcjZK2lmX8g4AgcyKxHsUQj0qyyBluVv
         jwiQiNchrmib3LwelSoS/feGmqrnkaYdQTA0/0oi9VAN1303t1p24954eEXu3+0yTzmy
         TNcmDn2xFF/0IRGteDJsmDkvzHi4mJ0uPP1GzY5auWhMtmns7PqaUuVRBFg4W3i9Mi4p
         x9rdtruYeEtmQsDivOGZzXx03N1Vpigphv/HvzmpapcZ08Riw+ww1fCpPbm/1/zxdEDb
         +ghQ==
X-Received: by 10.42.129.140 with SMTP id q12mr4072597ics.68.1418941160168;
        Thu, 18 Dec 2014 14:19:20 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id zw12sm66014igc.12.2014.12.18.14.19.19
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Dec 2014 14:19:19 -0800 (PST)
Message-ID: <549352E4.7090800@gmail.com>
Date:   Thu, 18 Dec 2014 14:19:16 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH RFC 19/67] MIPS: asm: atomic: Update asm and ISA constrains
 for MIPS R6 support
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com> <1418915416-3196-20-git-send-email-markos.chandras@imgtec.com> <549321F3.1090704@gmail.com> <20141218190125.GA8221@linux-mips.org> <6D39441BF12EF246A7ABCE6654B0235320F8AD08@LEMAIL01.le.imgtec.org>
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235320F8AD08@LEMAIL01.le.imgtec.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 12/18/2014 01:04 PM, Matthew Fortune wrote:
>> On Thu, Dec 18, 2014 at 10:50:27AM -0800, David Daney wrote:
>>
>>> On 12/18/2014 07:09 AM, Markos Chandras wrote:
>>>> MIPS R6 changed the opcodes for LL/SC instructions and reduced the
>>>> offset field to 9-bits. This has some undesired effects with the "m"
>>>> constrain since it implies a 16-bit immediate. As a result of which,
>>>> add a register ("r") constrain as well to make sure the entire
>>>> address is loaded to a register before the LL/SC operations. Also use
>>>> macro to set the appropriate ISA for the asm blocks
>>>>
>>>
>>> Has support for MIPS R6 been added to GCC?
>>>
>>> If so, that should include a proper constraint to be used with the new
>>> offset restrictions.  We should probably use that, instead of forcing
>>> to a "r" constraint.
>>
>> In a non-public earlier discussion I've requested the same but somehow
>> that was ignored.
>
> I must have missed that comment or not been on the thread.
>
>> We need suitable constraints or the alternatives will be very, very
>> ugly.
>
> We can certainly discuss and investigate such things but there is a
> general problem of a growing list of different size displacement fields
> in load/store instructions. Obviously you could just opt to keep things
> the way they are for uMIPS today and leave the assembler to expand the
> instruction but my opinion is that magic expanding assembler macros
> are infuriating. We have however had to put support in binutils for many
> of them, simply to keep enough software building to ease the transition.
>
> So, all this patch does is highlight that magic assembler macros have
> been hiding this issue since micromips was added.
>
>>From your experiences will people invest the effort to look at the
> size of a displacement field for all the memory operations in an inline
> asm block and then choose an appropriate memory constraint?
>
> I'm obviously wary of putting things into GCC that are either only used
> in a handful of places (or not at all). The alternative to constraints
> is of course to try and reduce the need for inline asm and offer builtins
> for specific instructions or more complex operations.
>

Well, GCC directly emits LL/SC as part of its built-in support for 
atomic operations, so the knowledge of the constraints for the 
instructions must be present there.  Since the constraints must be 
present in GCC, using them in the kernel shouldn't be a problem.

David Daney
