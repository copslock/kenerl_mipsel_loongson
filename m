Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 08:37:03 +0100 (CET)
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:24453 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011082AbaKMHhCddKdp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 08:37:02 +0100
Received: from beldin ([90.16.212.42])
        by mwinf5d25 with ME
        id Evcp1p0080vSahW03vcpx8; Thu, 13 Nov 2014 08:36:57 +0100
X-ME-Helo: beldin
X-ME-Date: Thu, 13 Nov 2014 08:36:57 +0100
X-ME-IP: 90.16.212.42
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 00/10] UART driver support for BMIPS multiplatform kernels
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Thu, 13 Nov 2014 08:36:49 +0100
In-Reply-To: <1415825647-6024-1-git-send-email-cernekee@gmail.com> (Kevin
        Cernekee's message of "Wed, 12 Nov 2014 12:53:57 -0800")
Message-ID: <87oasbtuum.fsf@free.fr>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.3.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <robert.jarzmik@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44105
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.jarzmik@free.fr
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

Kevin Cernekee <cernekee@gmail.com> writes:

> V1->V2:
>
> Add a new UPIO_MEM32BE iotype instead of a separate big_endian flag.
>
> Change some of the of_*_is_* APIs to return bool, where appropriate.
>
> Fix a few minor comment issues.

Hi Kevin,

I'll review the pxa part tonight or tomorrow, just a simple preliminary question
: did you test this serie with the triple activation of DEBUG_UART, early
console, and kernel console, all of them on the same tty ?

Cheers.

--
Robert
