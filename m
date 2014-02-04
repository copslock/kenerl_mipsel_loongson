Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2014 10:00:36 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:3565 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822902AbaBDJAeBUkOb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Feb 2014 10:00:34 +0100
Message-ID: <52F0AC3E.5050806@imgtec.com>
Date:   Tue, 4 Feb 2014 09:00:46 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 00/58] Add support for Enhanced Virtual Addressing
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com> <52E94A85.3040602@gmail.com>
In-Reply-To: <52E94A85.3040602@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_02_04_09_00_28
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

Hi David,

I have some comments

On 01/29/2014 06:37 PM, David Daney wrote:
> This whole thing seems very messy.  I see a couple of problems:
>
> 1) There are if(CONFIG_EVA) ... else ... endif  all over the place.  It
> is very ugly.
>
> 2) You cannot have a signel kernel with both EVA and non-EVA support.


Unfortunately, I don't think using eva=1 or whatever in the kernel 
command line would work. First of all, there is board specific init code 
long before the command line is available. See patch #51. At that point, 
the kernel command line is not 'exposed' yet so there is no way to tell 
if you are booting in EVA or non-EVA mode.

>
> Have you considered just tagging all the instructions that touch the
> user address space, and patching them at system boot with their EVA
> equivalents if EVA support is desired?

I don't think this is possible (or maybe i don't understand your 
proposal). Consider for example the copy_user function in memcpy.S. This 
function does copy_{to,from,in} user/kernel depending on the supplied 
virtual address. There is no way to tell in advance if a 'lb' 
instruction will load from kernel or user space. This is only possible 
during runtime by examining the get_fs() == get_ds() status. Therefore, 
it's necessary to have 4 variants of this functions replacing only the 
'store' or 'load' instructions that you really need to. For example

- load from user, store to kernel
- load from kernel, store to user
- load from user, store to user
- load from kernel, store to kernel

As you can see, static replacement of the instructions with the EVA ones 
during boot will not work as expected.

This is the reason I converted these functions to macros, so all the 
variants will be a simple 3 line assembler code that only replaces the 
instructions you are really interested in.

-- 
markos
