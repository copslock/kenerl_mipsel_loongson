Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2005 12:42:58 +0100 (BST)
Received: from gw.voda.cz ([IPv6:::ffff:212.24.154.90]:14254 "EHLO
	smtp.voda.cz") by linux-mips.org with ESMTP id <S8225249AbVE1Lmk>;
	Sat, 28 May 2005 12:42:40 +0100
Received: from localhost (localhost [127.0.0.1])
	by smtp.voda.cz (Postfix) with ESMTP id DCF891DBA9
	for <linux-mips@linux-mips.org>; Sat, 28 May 2005 13:42:38 +0200 (CEST)
Received: from smtp.voda.cz ([127.0.0.1])
 by localhost (gw [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 09749-01 for <linux-mips@linux-mips.org>;
 Sat, 28 May 2005 13:42:18 +0200 (CEST)
Received: from [10.1.1.111] (unknown [10.1.1.111])
	by smtp.voda.cz (Postfix) with ESMTP id 0A20A1D802
	for <linux-mips@linux-mips.org>; Sat, 28 May 2005 13:42:12 +0200 (CEST)
Message-ID: <42985913.2040606@voda.cz>
Date:	Sat, 28 May 2005 13:42:11 +0200
From:	=?ISO-8859-2?Q?Tom=E1=B9_Vr=E1na?= <tom@voda.cz>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc:	linux-mips@linux-mips.org
Subject: Re: Kernel crash in ip_nat on ADM5120
References: <42984BFC.3000800@voda.cz>
In-Reply-To: <42984BFC.3000800@voda.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at voda.cz
To:	unlisted-recipients:; (no To-header on input)
Return-Path: <tom@voda.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tom@voda.cz
Precedence: bulk
X-list: linux-mips

Please reply to tom@voda.cz, I posted from wrong profile first.

       Sorry and thanks, Tom

VODA IT wrote:

> Hello,
>
> I get following problem using the 2.6.11 kernel on ADM5120 platform:
> Under heavy network load (ie. flood ping) the kernel crashes in NAT 
> (no nat is done actually), removing IP filtering from kernel leaves 
> everything perfectly stable....  I am attaching dumps, including 
> parsed ksyms. Anyone able to help ?
>
>       Thanks, Tom
>
> Kernel panic - not syncing: Caught Machine Check exception - caused by
>
> multiple matching entries in the TLB
>
> ksymoops 2.4.9 on i686 2.6.5-7.151-default.  Options used
>     -v ../linux-2.6.11-mipscvs-20050326/vmlinux (specified)
>     -K (specified)
>     -L (specified)
>     -O (specified)
>     -m ../linux-2.6.11-mipscvs-20050326/System.map (specified)
>     -t mipsel -a mipsel
>
> Cpu 0
> $ 0   : 00000000 801f0000 c00042a8 000002a8
> $ 4   : 801cc6f0 8faf4800 00000080 00000001
> $ 8   : 0302a8c0 0102a8c0 8025baf0 8025baf8
> $12   : 00ff0000 00000278 0000003e 72756f73
> $16   : 00000055 80fd4cac 8025baf0 80fd4d28
> $20   : 00000001 00000001 00000000 80f36c00
> $24   : 00000008 00426bc0
> $28   : 8025a000 8025bac8 8025bc78 801a0d78
> Hi    : 00000055
> Lo    : 0140d97a
> epc   : 801a0f18 ip_nat_setup_info+0x27c/0x59c     Not tainted
> Status: 10208403    KERNEL EXL IE
> Cause : 00800060
> Kernel panic - not syncing: Caught Machine Check exception - caused by
> Warning (Oops_read): Code line not seen, dumping what data is available
>
>
>>> $12; 00ff0000 <__crc_nf_ct_attach+d834e/e919f>
>>> $15; 72756f73 <__crc_generic_make_request+1144ec/6a77e7>
>>> $17; 80fd4cac <__crc_tcf_exts_destroy+7086d4/72f879>
>>> $18; 8025baf0 <__crc_simple_transaction_release+1bada/c6e8a>
>>> $19; 80fd4d28 <__crc_tcf_exts_destroy+708750/72f879>
>>> $23; 80f36c00 <__crc_tcf_exts_destroy+66a628/72f879>
>>> $25; 00426bc0 <__crc_notify_change+2f24b/1fc50f>
>>> $28; 8025a000 <__crc_simple_transaction_release+19fea/c6e8a>
>>> $29; 8025bac8 <__crc_simple_transaction_release+1bab2/c6e8a>
>>> $30; 8025bc78 <__crc_simple_transaction_release+1bc62/c6e8a>
>>> $31; 801a0d78 <ip_nat_setup_info+dc/59c>
>>
>
>>> PC;  801a0f18 <ip_nat_setup_info+27c/59c>   <=====
>>
>
> --------------------
> Got mcheck at 801a0f18
> Cpu 0
> $ 0   : 00000000 801f0000 c00042a8 000002a8
> $ 4   : 801cc6f0 8faf4800 00000080 00000001
> $ 8   : 0302a8c0 0102a8c0 8026fbc8 8026fbd0
> $12   : 00ff0000 00000000 00000000 00000000
> $16   : 00000055 80270cac 8026fbc8 80270d28
> $20   : 00000001 00000001 00000000 80f36c00
> $24   : 00000000 0044ffb4
> $28   : 8026e000 8026fba0 8026fd50 801a0d78
> Hi    : 00000055
> Lo    : 0140d97a
> epc   : 801a0f18 ip_nat_setup_info+0x27c/0x59c     Not tainted
> ra    : 801a0d78 ip_nat_setup_info+0xdc/0x59c
> Status: 10208403    KERNEL EXL IE
> Cause : 00800060
> PrId  : 0001800b
>
> Index:  2 pgmask=4kb va=7fff6000 asid=09
>                        [pa=00236000 c=3 d=0 v=0 g=0]
>                        [pa=00fdb000 c=3 d=1 v=1 g=0]
>
> Index: 12 pgmask=4kb va=10004000 asid=09
>                        [pa=0023d000 c=3 d=1 v=0 g=0]
>                        [pa=00fcc000 c=3 d=0 v=0 g=0]
>
> Index: 13 pgmask=4kb va=2ab96000 asid=09
>                        [pa=00d86000 c=3 d=0 v=1 g=0]
>                        [pa=00000000 c=0 d=0 v=0 g=0]
>
> Index: 14 pgmask=4kb va=00442000 asid=09
>                        [pa=00c6f000 c=3 d=0 v=0 g=0]
>                        [pa=00c70000 c=3 d=0 v=1 g=0]
>
> Index: 15 pgmask=4kb va=00450000 asid=09
>                        [pa=00c7d000 c=3 d=0 v=1 g=0]
>                        [pa=00000000 c=0 d=0 v=0 g=0]
>
> Kernel panic - not syncing: Caught Machine Check exception - caused by
> multiple matching entries in the TLB.
>
>
>>> $12; 00ff0000 <__crc_nf_ct_attach+d834e/e919f>
>>> $17; 80270cac <__crc_simple_transaction_release+30c96/c6e8a>
>>> $18; 8026fbc8 <__crc_simple_transaction_release+2fbb2/c6e8a>
>>> $19; 80270d28 <__crc_simple_transaction_release+30d12/c6e8a>
>>> $23; 80f36c00 <__crc_tcf_exts_destroy+66a628/72f879>
>>> $25; 0044ffb4 <__crc_notify_change+5863f/1fc50f>
>>> $28; 8026e000 <__crc_simple_transaction_release+2dfea/c6e8a>
>>> $29; 8026fba0 <__crc_simple_transaction_release+2fb8a/c6e8a>
>>> $30; 8026fd50 <__crc_simple_transaction_release+2fd3a/c6e8a>
>>> $31; 801a0d78 <ip_nat_setup_info+dc/59c>
>>
>
>>> PC;  801a0f18 <ip_nat_setup_info+27c/59c>   <=====
>>
>
> Kernel panic - not syncing: Caught Machine Check exception - caused by
>
>
>


-- 
 Tomas Vrana  <tom@voda.cz>
 --------------------------
 VODA IT consulting, Borkovany 48, 691 75
 http://www.voda.cz/
 phone: +420 519 419 416 mobile: +420 603 469 305 UIN: 105142752
