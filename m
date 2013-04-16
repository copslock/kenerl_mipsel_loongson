Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 18:15:22 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:59970 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816521Ab3DPQPSVQWW8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 18:15:18 +0200
Message-ID: <516D781C.8010206@openwrt.org>
Date:   Tue, 16 Apr 2013 18:11:08 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jonas Gorski <jogo@openwrt.org>, linux-serial@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH V2] tty: serial: ralink: fix SERIAL_8250_RT288X dependency
References: <1366093125-19352-1-git-send-email-blogic@openwrt.org> <CAOiHx=npmzXe8yk1NLwzK0dQ-XsM-0bbT+L5Yg5LL05n0a3BKA@mail.gmail.com>
In-Reply-To: <CAOiHx=npmzXe8yk1NLwzK0dQ-XsM-0bbT+L5Yg5LL05n0a3BKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

> This won't work, Having RALINK=y, but SERIAL_8250=n will still result
> in SERIAL_8250_RT288X=y, as select ignores dependencies. What could
> work is removing the select from RALINK, and changing the depends from
> this one to "default y if SERIAL_8250&&  MIPS&&  RALINK".
>
>

ok, these tty patches were rushed too much. i think trying to get them 
ready quickly for 3.10 was a bad bad idea, that already wasted too much 
of other peoples time. instead of making even more of a fool of myself 
and wasting yet more time we should just drop it and i will try again 
with more time for 3.11.

Sorry for the noise :-)
     John
