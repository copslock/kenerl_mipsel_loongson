Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 11:01:51 +0100 (CET)
Received: from linux-libre.fsfla.org ([208.118.235.54]:52167 "EHLO
        linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823056AbaANKBpzr5MQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jan 2014 11:01:45 +0100
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
        by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id s0EA1deN007016;
        Tue, 14 Jan 2014 10:01:40 GMT
Received: from livre.home (livre.home [172.31.160.2])
        by freie.home (8.14.7/8.14.7) with ESMTP id s0EA1MmV028438;
        Tue, 14 Jan 2014 08:01:22 -0200
From:   Alexandre Oliva <oliva@gnu.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [3.13-rc regression] Unbreak Loongson2 and r4k-generic flush icache range
Organization: Free thinker, not speaking for the GNU Project
References: <ord2jwnmwd.fsf@livre.home> <52D3EA9B.6020404@cogentembedded.com>
Date:   Tue, 14 Jan 2014 08:01:22 -0200
In-Reply-To: <52D3EA9B.6020404@cogentembedded.com> (Sergei Shtylyov's message
        of "Mon, 13 Jan 2014 17:31:07 +0400")
Message-ID: <oriotmopal.fsf@livre.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <oliva@gnu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oliva@gnu.org
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

On Jan 13, 2014, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:

> Hello.

>> Commit 14bd8c08, that replaced Loongson2-specific ifdefs with cpu tests,
>> inverted the CPU test in local_r4k_flush_icache_range.  Loongson2 won't
>> boot up using the generic icache flush code.  Presumably other CPUs
>> might face other problems when presented with Loongson2-specific icache
>> flush code too.  This patch enabled my Yeeloong to boot up successfully
>> a 3.13-rc kernel for the first time, after a long git bisect session.

>> Signed-off-by: Alexandre Oliva <lxoliva@fsfla.org>

>    Fix for this issue has been posted long ago:

> http://marc.info/?l=linux-mips&m=138575576803890

Thanks.  As long ago as that was, I still don't see it in Torvalds's
master branch.  Was a pull request including this patch ever send his
way?  Such a trivial fix for such a show-stopper shouldn't find any
difficulties making 3.13, I think.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
