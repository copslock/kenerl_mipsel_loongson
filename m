Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2014 11:37:23 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:33862 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823056AbaANKhVARMqn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jan 2014 11:37:21 +0100
Message-ID: <52D5135E.9020407@phrozen.org>
Date:   Tue, 14 Jan 2014 11:37:18 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Alexandre Oliva <oliva@gnu.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [3.13-rc regression] Unbreak Loongson2 and r4k-generic flush
 icache range
References: <ord2jwnmwd.fsf@livre.home> <52D3EA9B.6020404@cogentembedded.com> <oriotmopal.fsf@livre.home>
In-Reply-To: <oriotmopal.fsf@livre.home>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

i think all questions were already answered

http://www.linux-mips.org/archives/linux-mips/2014-01/msg00127.html



On 14/01/2014 11:01, Alexandre Oliva wrote:
> On Jan 13, 2014, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:
>
>> Hello.
>>> Commit 14bd8c08, that replaced Loongson2-specific ifdefs with cpu tests,
>>> inverted the CPU test in local_r4k_flush_icache_range.  Loongson2 won't
>>> boot up using the generic icache flush code.  Presumably other CPUs
>>> might face other problems when presented with Loongson2-specific icache
>>> flush code too.  This patch enabled my Yeeloong to boot up successfully
>>> a 3.13-rc kernel for the first time, after a long git bisect session.
>>> Signed-off-by: Alexandre Oliva <lxoliva@fsfla.org>
>>    Fix for this issue has been posted long ago:
>> http://marc.info/?l=linux-mips&m=138575576803890
> Thanks.  As long ago as that was, I still don't see it in Torvalds's
> master branch.  Was a pull request including this patch ever send his
> way?  Such a trivial fix for such a show-stopper shouldn't find any
> difficulties making 3.13, I think.
>
