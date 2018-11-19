Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Nov 2018 12:05:19 +0100 (CET)
Received: from www62.your-server.de ([213.133.104.62]:57352 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992834AbeKSLFJU60r1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Nov 2018 12:05:09 +0100
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gOhMV-0005nw-Bj; Mon, 19 Nov 2018 12:05:03 +0100
Received: from [2a02:1203:ecb1:b710:c81f:d2d6:50a9:c2d] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gOhMV-0006f2-5C; Mon, 19 Nov 2018 12:05:03 +0100
Subject: Re: [PATCH net-next 0/6] Remove VLAN.CFI overload
To:     David Miller <davem@davemloft.net>, mirq-linux@rere.qmqm.pl
Cc:     netdev@vger.kernel.org, ast@kernel.org, benh@kernel.crashing.org,
        jhogan@kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        paul.burton@mips.com, paulus@samba.org, ralf@linux-mips.org,
        sparclinux@vger.kernel.org
References: <cover.1541876179.git.mirq-linux@rere.qmqm.pl>
 <20181110.134758.693752342395888727.davem@davemloft.net>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6d7de753-7e53-d980-e357-b1af2495cb7e@iogearbox.net>
Date:   Mon, 19 Nov 2018 12:05:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181110.134758.693752342395888727.davem@davemloft.net>
Content-Type: text/plain; charset=euc-kr
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25134/Mon Nov 19 07:16:12 2018)
Return-Path: <daniel@iogearbox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@iogearbox.net
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

On 11/10/2018 10:47 PM, David Miller wrote:
> From: Micha©© Miros©©aw <mirq-linux@rere.qmqm.pl>
> Date: Sat, 10 Nov 2018 19:58:29 +0100
> 
>> Fix BPF code/JITs to allow for separate VLAN_PRESENT flag
>> storage and finally move the flag to separate storage in skbuff.
>>
>> This is final step to make CLAN.CFI transparent to core Linux
>> networking stack.
>>
>> An #ifdef is introduced temporarily to mark fragments masking
>> VLAN_TAG_PRESENT. This is removed altogether in the final patch.
> 
> Daniel and Alexei, please review.

Sorry, was completely swamped due to plumbers, just getting to it now.
