Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jan 2018 01:09:40 +0100 (CET)
Received: from resqmta-ch2-11v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:43]:42126
        "EHLO resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990435AbeAEAJacQiQt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jan 2018 01:09:30 +0100
Received: from resomta-ch2-07v.sys.comcast.net ([69.252.207.103])
        by resqmta-ch2-11v.sys.comcast.net with ESMTP
        id XFWte8n2PbdmiXFXEeVnj6; Fri, 05 Jan 2018 00:06:56 +0000
Received: from [192.168.1.13] ([76.100.35.246])
        by resomta-ch2-07v.sys.comcast.net with SMTP
        id XFXCeef39MxjlXFXDet1xu; Fri, 05 Jan 2018 00:06:56 +0000
To:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: Is MIPS affected by the recent KAISER/KASLR/KPTI/etc mess?
Message-ID: <fa392a88-9968-14f4-73e3-0d8bafad97df@gentoo.org>
Date:   Thu, 4 Jan 2018 19:06:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfM7Vy94f0sub6DySIrIzg+XUNH7dHD/i1rUbpsjfFxlSKgWjhS5uoVuTac3Ky+P1sFVKWaoI976VLyCd6MHLzYzqfZ/pNHIm7K3nUDtRonVJicJ8tVt+
 WNU7U4GwseuqIC0m32OA9fngqZp4DtbY5M+0Sxm3jG5aag+Vu9XTnr0MUUCUQaDGIE5gndZuPSEUHA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61901
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


Regarding the KAISER/KASLR/KPTI work to mitigate the recently-announced
"Spectre" and "Meltdown" issues in x86/x64 and some Arm processors, does anyone
know how vulnerable MIPS processors might be?

My initial guess is Spectre might apply, since MIPS CPUs have supported
speculative execution as far back as the R10000, and even the R10K manual
contained an entire section on "The side-effects of speculative execution", for
SGI's non-coherent platforms (IP28, IP32).  But MIPS is a varied ecosystem of
CPUs, so if the arch is vulnerable, there might be specific MIPS CPU types that
are not vulnerable.

I am also uncertain if the way MIPS lays out its address space, with specific
ranges for kernel mode, supervisor mode (unused), and user mode, makes this a
non-issue.

Thoughts?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
