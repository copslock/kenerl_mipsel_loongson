Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2013 13:18:56 +0100 (CET)
Received: from mail-la0-f51.google.com ([209.85.215.51]:46515 "EHLO
        mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832195Ab3AOMSz2Of-q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jan 2013 13:18:55 +0100
Received: by mail-la0-f51.google.com with SMTP id fj20so24754lab.24
        for <multiple recipients>; Tue, 15 Jan 2013 04:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=+PPuMZX3q7q/QYf4TPilurslNaYh1jyOQuSOKQUsKvc=;
        b=EX2E1vvM2q/O53XPt+++O/Y6Izw5cd4PrQNSq//bzZlr9xlQXdv6reg+AI1OQLWCaA
         7+tG9Bgp71BCguR9S/TAp3SRmt1dVO8aXhCPuejUVscl8bDi4Cua6/DjgdbT1gQq0V5N
         cw8qfavf0yHQ9xnYFRTbVt5+gogQfCsoZb6YGM6zb5dQ/7RI/EWvrjFEzVaL3POteVNu
         /xxCgwO6bn5PeDCBL31tB6P7w3d8iVSf5eZ4CP2l0fXoG1A0V+z+U/OE57nDuF5W4/Nm
         SU2FLoUKK7F62vEP4S/w/00JFYQtj+h8gSxQ6HIVfdLOf0sFOR3ObWg/YH5Qj/fajRX1
         fc1Q==
X-Received: by 10.152.145.37 with SMTP id sr5mr28713094lab.33.1358252329757;
        Tue, 15 Jan 2013 04:18:49 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id v7sm6686079lbj.13.2013.01.15.04.18.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 04:18:49 -0800 (PST)
Message-ID: <50F5488C.4010006@openwrt.org>
Date:   Tue, 15 Jan 2013 13:16:12 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Jayachandran C <jchandra@broadcom.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 03/10] MIPS: PCI: Byteswap not needed in little-endian
 mode
References: <1358179922-26663-4-git-send-email-jchandra@broadcom.com> <1358230746-13785-1-git-send-email-jchandra@broadcom.com> <50F5444C.5020209@mvista.com>
In-Reply-To: <50F5444C.5020209@mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

On 01/15/2013 12:58 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 15-01-2013 10:19, Jayachandran C wrote:
>
>> Wrap the xlp_enable_pci_bswap() function and its call with
>> '#ifdef __BIG_ENDIAN'. On Netlogic XLP, the PCIe initialization code
>> to setup to byteswap is needed only in big-endian mode.
>
>> Signed-off-by: Jayachandran C <jchandra@broadcom.com>

[snip]

>> +/*
>> + * If big-endian, enable hardware byteswap on the PCIe bridges.
>> + * This will make both the SoC and PCIe devices behave consistently with
>> + * readl/writel.
>> + */
>> +static void xlp_config_pci_bswap(void)
>>   {
>> +#ifdef __BIG_ENDIAN
>>       uint64_t pciebase, sysbase;
>>       int node, i;
>>       u32 reg;
>> @@ -222,7 +228,7 @@ static int xlp_enable_pci_bswap(void)
>>           reg = nlm_read_bridge_reg(sysbase, BRIDGE_PCIEIO_LIMIT0 + i);
>>           nlm_write_pci_reg(pciebase, PCIE_BYTE_SWAP_IO_LIM, reg |
>> 0xfff);
>>       }
>> -    return 0;
>> +#endif
>
>     You misunderstood. #ifdef within functions are frowned upon. Thios
> patch is hardly better than previous then.

Jayachandran, you probably need something like this:

#ifdef __BIG_ENDIAN
static void xlp_config_pci_bswap(void)
{
	/* perform the actual swapping */
}
#else
static inline void xlp_config_pci_bswap(void) { }
#endif
--
Florian
