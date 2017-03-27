Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2017 03:50:21 +0200 (CEST)
Received: from resqmta-ch2-06v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:38]:46076
        "EHLO resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbdC0BuPOyWMa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Mar 2017 03:50:15 +0200
Received: from resomta-ch2-04v.sys.comcast.net ([69.252.207.100])
        by resqmta-ch2-06v.sys.comcast.net with SMTP
        id sJnCcU02Yl4eqsJnRcB8db; Mon, 27 Mar 2017 01:50:13 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-04v.sys.comcast.net with SMTP
        id sJnQcaOmMFcZ2sJnQcsSJF; Mon, 27 Mar 2017 01:50:13 +0000
From:   Joshua Kinard <kumba@gentoo.org>
Subject: Does the R10K family support the "wait" instruction?
To:     Linux/MIPS <linux-mips@linux-mips.org>
Message-ID: <88c3cc1d-fd80-bb9a-d1ec-ed3c44dea71b@gentoo.org>
Date:   Sun, 26 Mar 2017 21:50:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH69CZOFcS7GQLPkvZtWPBdG1LlCKrpbnAopqL4a2zTg9t3utqoWQhmXMMg7ueZUqbViyinSGPGyI1XUDXAb2fPw8WByS5br0TDL1yqekYR54BPxyE3f
 Wv/FPkfIMgLKJsIXvCNZ+a6rLhzR7QK7MHWNG2sxesLXVNE+44UfykLp
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57448
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

Does anyone know if the R1x000 family of CPUs support the "wait" instruction?
The 'check_wait' function in arch/mips/kernel/idle.c doesn't have a case for
any of the R10K CPUs, and I can't find any specific guidance in the final R10K
manual produced by Renesas, nor in the MIPS-IV instruction set.  It appears
this was added in MIPS-II, and the R4K CPUs use it, with one version for when
interrupts are enabled, and one where they're disabled.  Since a lot of CPUs
tend to reuse R4K-compatible code, I wasn't sure.

Kinda-assuming it doesn't, since the R10K lacks any notion of reduced power
operation.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
