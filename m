Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2017 02:03:45 +0100 (CET)
Received: from resqmta-ch2-06v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:38]:58290
        "EHLO resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992110AbdAWBDh5uPQF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2017 02:03:37 +0100
Received: from resomta-ch2-08v.sys.comcast.net ([69.252.207.104])
        by resqmta-ch2-06v.sys.comcast.net with SMTP
        id VT2YcbEtVTERUVT2mcKjYp; Mon, 23 Jan 2017 01:03:36 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-08v.sys.comcast.net with SMTP
        id VT2kcwiBoaYRCVT2lc628c; Mon, 23 Jan 2017 01:03:36 +0000
Subject: Re: gcc-6.3.x miscompiling code for IP27?
To:     linux-mips@linux-mips.org
References: <ee417407-6877-f49c-5893-f3b3dbc2d103@gentoo.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <44d9e9df-2d77-df23-266b-9cb90b0db4c9@gentoo.org>
Date:   Sun, 22 Jan 2017 20:03:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <ee417407-6877-f49c-5893-f3b3dbc2d103@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJn3P0YoQHKAOful74BS6Qf+puP2sQim+VhS+49ADV4STh4X0N1Kpn34pL55tP314lu96dnPx5/5jTiDqJpf0qcMwM0JZRKTf/I+C6wFfvLWxWtCtrTT
 DK5i0o1EbOkbD7LANo8Dhg+CIC+YfdtGEokEUau7h2XKyLmwPjnKcNt3
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56460
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

On 01/22/2017 18:28, Joshua Kinard wrote:
> I think I've run into a really odd gcc-6.3.x miscompile bug here on IP27.
> But I'm not sure.  I've reproduced the issue on 4.9.5, 4.8.17, and now
> 4.7.10 (which I KNOW should boot).  If I recompile the same 4.7.10 kernel
> with gcc-5.4.0, though, it boots as expected.  The fault appears to be in
> the assembly for _raw_spin_lock_irq.
> 

Figured it out.  Not 100% sure WHY, but gcc-6.3.x is causing kbuild to parse
the arch/mips/sgi-ip32/Platform file for some reason on both IP27 and IP30
builds, and is thusly appending -mr10k-cache-barrier=load-store to the kernel
CFLAGS.  It did this on my Octane's kernel as well, but the Octane seems to be
unaffected by the extraneous cache barriers.  I sent a fix in for this a long
time ago, but it never got accepted.  So I'll try again...

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
