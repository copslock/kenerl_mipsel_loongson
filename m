Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2015 17:29:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:29491 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012408AbbBBQ3CueHHx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Feb 2015 17:29:02 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3E74E50CA4A9F;
        Mon,  2 Feb 2015 16:28:54 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 2 Feb 2015 16:28:57 +0000
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 2 Feb 2015 16:28:55 +0000
Message-ID: <54CFA5BC.2070103@imgtec.com>
Date:   Mon, 2 Feb 2015 16:28:44 +0000
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Lars-Peter Clausen <lars@metafoo.de>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 26/36] serial: 8250_jz47xx: support for Ingenic jz47xx
 UARTs
References: <1421620067-23933-1-git-send-email-paul.burton@imgtec.com> <1421620881-25136-1-git-send-email-paul.burton@imgtec.com> <20150130233105.GA10564@kroah.com>
In-Reply-To: <20150130233105.GA10564@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.89]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Hi Greg,

On 30/01/15 23:31, Greg Kroah-Hartman wrote:
> On Sun, Jan 18, 2015 at 02:41:21PM -0800, Paul Burton wrote:
>> Introduce a driver suitable for use with the UARTs present in
>> Ingenic jz47xx series SoCs. These are described as being ns16550
>> compatible but aren't quite - they require the setting of an extra bit
>> in the FCR register to enable the UART module. The serial_out
>> implementation is the same as that in arch/mips/jz4740/serial.c - which
>> will shortly be removed.
>>
>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: linux-serial@vger.kernel.org
>> ---
>>  drivers/tty/serial/8250/8250_jz47xx.c | 228 ++++++++++++++++++++++++++++++++++
>>  drivers/tty/serial/8250/Kconfig       |   8 ++
>>  drivers/tty/serial/8250/Makefile      |   1 +
>>  3 files changed, 237 insertions(+)
>>  create mode 100644 drivers/tty/serial/8250/8250_jz47xx.c
> 
> This patch blows up on x86 systems, breaking the build :(

Ouch.

Did you compile after all the patches applied? Or after every single patch.

I can't manage to reproduce the build error with all of them applied.

Used x86_64_defconfig and enabled CONFIG_SERIAL_8250_JZ47XX=y

Thanks,
ZubairLK

> 
> Sorry, I can't take it.
> 
> greg k-h
> 
