Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Aug 2017 16:26:12 +0200 (CEST)
Received: from resqmta-po-12v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:171]:37944
        "EHLO resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994883AbdHCO0DnT7p0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Aug 2017 16:26:03 +0200
Received: from resomta-po-05v.sys.comcast.net ([96.114.154.229])
        by resqmta-po-12v.sys.comcast.net with ESMTP
        id dH42dmQelK2u5dH4bdFIim; Thu, 03 Aug 2017 14:26:01 +0000
Received: from [192.168.1.13] ([73.201.189.102])
        by resomta-po-05v.sys.comcast.net with SMTP
        id dH4ZdypfM25gRdH4adOTch; Thu, 03 Aug 2017 14:26:01 +0000
Subject: Re: Update PS2 R5900 to kernel 4.x?
To:     Fredrik Noring <noring@nocrew.org>, linux-mips@linux-mips.org
References: <A4F10467-06DE-4880-B740-10B32CAC9208@nocrew.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <0d0fdd50-929f-da92-dd35-88f2878da8c2@gentoo.org>
Date:   Thu, 3 Aug 2017 10:25:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <A4F10467-06DE-4880-B740-10B32CAC9208@nocrew.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHLCxihYZ8BNbOzNVYiuKHyajRjY7QC705wqANIxta2SYzLsrZ2gtk3582dLNhB15sDxbhSZ14QAC0x859WW2Q0Mk5f95LOGmiWcjuT+nQnlBsIcaSDj
 2sn2R8sLoh+NxCOeDyKSEZ+BBJJO2lJeDhjacjrjtQeE/GkrYsh+Sw9reZi0RMUwNCF4oymHln4Cq9NrOkOImx+C5yAV7BiIM8M=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 08/01/2017 10:08, Fredrik Noring wrote:
> Hello MIPS maintainers,
> 
> I'm trying update the PS2 R5900 patch to kernel version 4.x. I started
> at 2.6.35 and it was easy up to v3.9-rc1 commit 64b3122 which crashes with
> a memory fault at boot:
> 
>   commit 64b3122df48b81a40366a11f299ab819138c96e8
>   Author: Al Viro <viro@zeniv.linux.org.uk>
>   Date:   Thu Dec 27 11:52:32 2012 -0500
>   
>       mips: take the "zero newsp means inherit the parent's one" to copy_thread()
>       
>       Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> I've pushed the patched (working) parent commit here:
> 
>   https://github.com/frno7/linux/tree/ps2-v3.9-rc1-974fdb3
> 
> The whole PS2 R5900 patch is quite large, but I suspect the problem is limited
> to changes in arch/mips/kernel, more specifically:
> 
>   arch/mips/kernel/process.c
>   arch/mips/kernel/scall32-n32.S
>   arch/mips/kernel/syscall.c
> 
> (Several system calls etc. have been rearranged since 2.6.35.) I've been stuck
> for a couple of days trying to get this to work. Would anyone be able to help?
> 
> Many thanks,
> Fredrik

Didn't the PS2 kernel need a lot of userland changes and a special toolchain to
deal with the hybrid nature of the R5900?  Do you have a working userland that
can run under the 3.9 kernel?  Last I heard, the latest kernel that would work
on PS2 was a Sony-modified ~2.4.17 that was put out for some kind of
specialized PS2 hardware found only in Japan.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
