Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jul 2013 13:21:10 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:53105 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6818993Ab3G2LVIMriG9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Jul 2013 13:21:08 +0200
Message-ID: <51F64E9B.8070306@phrozen.org>
Date:   Mon, 29 Jul 2013 13:14:35 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: add proper set_mode() to cevt-r4k
References: <1375091743-20608-1-git-send-email-blogic@openwrt.org> <CAGVrzcYXyWB1bwoKyEFrSO7YEJx9Q_v2vOnnPnqVrFVKiigFrA@mail.gmail.com> <51F6495D.9000008@phrozen.org> <CAGVrzcYcP8kUueLkDtL+fT9g+HFUKGgdw_hTRXkhA8P+4LbL8A@mail.gmail.com>
In-Reply-To: <CAGVrzcYcP8kUueLkDtL+fT9g+HFUKGgdw_hTRXkhA8P+4LbL8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37388
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


>> the actual problem is not the irq sharing but that the cevt-r4k registers
>> the irq when the cevt is registered and not when it is activated. i believe
>> that the patch fixes this problem
>
> Your patch certainly does what you say it does, but that is kind of an
> abuse of the set_mode() callback.

well there are 2 modes "run as oneshot timer and dont run. i dont see 
how this is an abuse?
