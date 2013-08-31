Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Aug 2013 12:23:09 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:54557 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818014Ab3HaKXFqDQsh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 31 Aug 2013 12:23:05 +0200
Message-ID: <5221C3FC.7090608@phrozen.org>
Date:   Sat, 31 Aug 2013 12:22:52 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH V2] MIPS: BMIPS: fix compilation for BMIPS5000
References: <1375350938-16554-1-git-send-email-jogo@openwrt.org> <20130801135505.GA3466@linux-mips.org> <CAOiHx=kZuzVu=ung9suwuoYr7F5LP-ghNFzwVSM_Zrc3i+=Q-g@mail.gmail.com>
In-Reply-To: <CAOiHx=kZuzVu=ung9suwuoYr7F5LP-ghNFzwVSM_Zrc3i+=Q-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37726
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

Hi Kevin,
Hi Florian,

>> +       write_c0_ddatalo(3);
> I guess this needs to be write_c0_ddatalo(data);
>
>> >  +       __ssnop();
>> >  +       __ssnop();
>> >  +       __ssnop();
>> >  +       cache_op(Index_Store_Tag_S, ZSCM_REG_BASE + offset);
>> >  +       __ssnop();
>> >  +       __ssnop();
>> >  +       __ssnop();
>> >  +       barrier();
>> >    }
>> >
>> >    #endif /* !defined(__ASSEMBLY__) */
>> >
> Kevin or Florian, can you comment on this?
>

any comments on this ?

	John
