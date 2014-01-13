Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2014 14:44:09 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:43321 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815784AbaAMNoG466qZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Jan 2014 14:44:06 +0100
Message-ID: <52D3ED11.1080103@phrozen.org>
Date:   Mon, 13 Jan 2014 14:41:37 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [3.13-rc regression] Unbreak Loongson2 and r4k-generic flush
 icache range
References: <ord2jwnmwd.fsf@livre.home> <52D3EA9B.6020404@cogentembedded.com>
In-Reply-To: <52D3EA9B.6020404@cogentembedded.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38956
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

On 13/01/14 14:31, Sergei Shtylyov wrote:
> Hello.
>
> On 13-01-2014 15:26, Alexandre Oliva wrote:
>
>> Commit 14bd8c08, that replaced Loongson2-specific ifdefs with cpu tests,
>
> Please also specify that commit's summary line in parens.
>
>> inverted the CPU test in local_r4k_flush_icache_range. Loongson2 won't
>> boot up using the generic icache flush code. Presumably other CPUs
>> might face other problems when presented with Loongson2-specific icache
>> flush code too. This patch enabled my Yeeloong to boot up successfully
>> a 3.13-rc kernel for the first time, after a long git bisect session.
>
>> Signed-off-by: Alexandre Oliva <lxoliva@fsfla.org>
>
> Fix for this issue has been posted long ago:
>
> http://marc.info/?l=linux-mips&m=138575576803890
>
> WBR, Sergei
>
>
>


Hi,

i was under the impression that it is in rc8 but i am failing to see it 
there.

	John
