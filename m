Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Oct 2010 23:46:17 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4787 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491145Ab0JMVqO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Oct 2010 23:46:14 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cb628c50000>; Wed, 13 Oct 2010 14:46:45 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 13 Oct 2010 14:46:24 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 13 Oct 2010 14:46:24 -0700
Message-ID: <4CB628A2.5060705@caviumnetworks.com>
Date:   Wed, 13 Oct 2010 14:46:10 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     ralf@linux-mips.org
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Make TASK_SIZE reflect proper size for both
 32 and 64 bit processes.
References: <1286992415-21167-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1286992415-21167-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2010 21:46:24.0798 (UTC) FILETIME=[1523BBE0:01CB6B20]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 10/13/2010 10:53 AM, David Daney wrote:
[...]
>
> -#define __UA_LIMIT	(- TASK_SIZE)
> +#define __UA_LIMIT	(1ul<<  63)
>

This doesn't work:

Unhandled kernel unaligned access[#1]:
Cpu 7
$ 0   : 0000000000000000 10c38ca810c38c78 0000000000000000 0000000000000000
$ 4   : ffffffff811238ac 10c38ca810c38c68 0000000010108ce3 10c38ca810c38c68
$ 8   : 0000000000000000 10c38ca810c38c68 10c38ca810c38c68 10c38ca810c38c68
$12   : 0000000010108ce1 000000001000001e ffffffff8117aa08 ffffffff815905c8
$16   : ffffffffdca80000 a80000009271bcd0 8000000000000000 00000001208d0094
$20   : 10c38ca810c38c68 0000005558776460 ffffffffffffffa7 0000005558776428
$24   : 0000000000000000 0000005558aace60
$28   : a800000092718000 a80000009271bca0 0000005558776420 ffffffff81100880
Hi    : 0000000000000249
Lo    : 077c561f20000000
epc   : ffffffff811238c4 do_ade+0x1f4/0x490
     Not tainted
ra    : ffffffff81100880 ret_from_exception+0x0/0x8
Status: 10108ce3    KX SX UX KERNEL EXL IE
Cause : 00800010
BadVA : 10c38ca810c38c68
PrId  : 000d0409 (Cavium Octeon+)
Modules linked in:
Process loop-3.exe (pid: 31583, threadinfo=a800000092718000, 
task=a8000000b6529fc8, tls=000000555c5ca880)
Stack : 0000000000000008 0000000000000080 10c38ca810c38c68 0000000000000008
         00000001208d0094 ffffffff81100880 0000000000000000 10c38ca810c38c78
         0000000000000000 8000000000000000 a80000009271be38 10c38ca810c38c68
         0000000000000010 10c38ca810c38c68 0000000000000000 10c38ca810c38c68
         10c38ca810c38c68 10c38ca810c38c68 0000000000000000 0000000000000000
         ffffffff8117aa08 ffffffff815905c8 0000000000000080 10c38ca810c38c68
         0000000000000008 00000001208d0094 10c38ca810c38c68 0000005558776460
         ffffffffffffffa7 0000005558776428 0000000000000000 0000005558aace60
         ffffffff814f8ba8 ffffffff81123f14 a800000092718000 a80000009271be30
         0000005558776420 ffffffff8117aae8 0000000010108ce3 0000000000000249
         ...
Call Trace:
[<ffffffff811238c4>] do_ade+0x1f4/0x490
[<ffffffff81100880>] ret_from_exception+0x0/0x8
[<ffffffff81100590>] less_than_4units+0xc/0x5c
[<ffffffff8117aae8>] SyS_futex+0xe0/0x1c0
[<ffffffff81102bc4>] handle_sys64+0x44/0x60



We are doing a copy_from_user(), with a bad address passed in from 
userspace.  The access_ok() says it is fine, but when we drop into the 
memcpy, we get the Address Error Exception because we exceeded SEGBITS.

Really we want to clamp things at the SEGBITS boundry.

David Daney
