Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 22:29:22 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:53149 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6833254Ab3A1V3WNl6Cr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jan 2013 22:29:22 +0100
Message-ID: <5106ED18.5080309@openwrt.org>
Date:   Mon, 28 Jan 2013 22:26:48 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 7/10] MIPS: ralink: adds early_printk support
References: <1359358817-3867-1-git-send-email-blogic@openwrt.org> <51066C27.4070403@mvista.com>
In-Reply-To: <51066C27.4070403@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35604
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
Return-Path: <linux-mips-bounce@linux-mips.org>


>> +#include <linux/serial_reg.h>
>> +
>> +#include <asm/addrspace.h>
>> +
>> +/* UART registers */
>
>    this comment refers to the register #defines below, why it is here?
>
>> +#define EARLY_UART_BASE         0x10000c00
>> +

Hi,

i removed the comment inside the tree that ralf will pull the patches from.

     John
