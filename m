Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jan 2017 05:00:47 +0100 (CET)
Received: from resqmta-ch2-07v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:39]:45241
        "EHLO resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbdA2EAlLykYs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jan 2017 05:00:41 +0100
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-07v.sys.comcast.net with SMTP
        id XgfPcClQej8tqXgfPcrSqs; Sun, 29 Jan 2017 04:00:39 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-01v.sys.comcast.net with SMTP
        id XgfOcljVGqBvQXgfOczrt8; Sun, 29 Jan 2017 04:00:39 +0000
Subject: Re: [PATCH] MIPS: Add ifdefs to IP22/IP32's Platform files
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
References: <b290b37d-b136-0766-44ce-a094b336779a@gentoo.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <aefec5f3-1d00-99c1-3ee0-da972b7bd4ab@gentoo.org>
Date:   Sat, 28 Jan 2017 23:00:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <b290b37d-b136-0766-44ce-a094b336779a@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPZXfwbqho2LKLNQGG9wjqf35htkuk8xtd6kCeyLz60SOokJsWUtql7rxeMdfPdfpDQEahDE6/6rzjYWAS4UZUCuC/rt7OPcAov/JoGwB6I9HyXwRnJB
 4cQ9f8b0D8bYAU4Uy7/dkveumFXfVSR4rgLmTPfWm4N9AlWX8ARM2yS75LrkuEbu+gwJGqMW17Oo7VjHXXkkY6kZNfBQ3TzHw+iPMO8MuH9nPSTTk1Qs49QC
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56535
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

On 01/28/2017 22:38, Joshua Kinard wrote:
> From: Joshua Kinard <kumba@gentoo.org>
> 
> Prevent IP22/IP32's Platform directives from mixing into builds of
> other MIPS platforms.  During a recent IP27 build, erroneous R10K
> cache barrier instructions were being emitted before every load or
> store instruction.  This was caused by IP27 accidentally picking up
> the -mr10k-cache-barrier option from arch/mips/sgi-ip32/Platform.
> 
> By wrapping the directives in both IP22 and IP32's Platform file
> inside an 'ifdef' block, as is already done in IP27's Platform file,
> this prevents the R10K cache barriers from being emitted on platforms
> where they are not needed.
> 

[snip]

Scrub this one.  I'll send a fixed copy shortly.  I diffed it from the
wrong branch on my local git, which includes testing for IP32 R10K/R12K.

--J
