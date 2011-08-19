Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2011 13:00:24 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:55416 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491148Ab1HSLAU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2011 13:00:20 +0200
Received: by wyh11 with SMTP id 11so2522513wyh.36
        for <linux-mips@linux-mips.org>; Fri, 19 Aug 2011 04:00:13 -0700 (PDT)
Received: by 10.216.255.18 with SMTP id i18mr1511080wes.64.1313751613688;
        Fri, 19 Aug 2011 04:00:13 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.76.218])
        by mx.google.com with ESMTPS id y61sm2089215wec.30.2011.08.19.04.00.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Aug 2011 04:00:12 -0700 (PDT)
Message-ID: <4E4E4216.1050903@mvista.com>
Date:   Fri, 19 Aug 2011 14:59:34 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:6.0) Gecko/20110812 Thunderbird/6.0
MIME-Version: 1.0
To:     Jason Kwon <jason.kwon@ericsson.com>
CC:     linux-mips@linux-mips.org
Subject: Re: Problems booting 3.0.3 kernel on Octeon CN58XX board
References: <4E4DA9DA.60305@ericsson.com>
In-Reply-To: <4E4DA9DA.60305@ericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13998

Hello.

On 19-08-2011 4:10, Jason Kwon wrote:

> Attempting to boot a 3.0.3 kernel on a CN58XX board produced the following oops:

[...]

> Code: 007e1824 0064182d 64840038 <dc620000> c84afff5 64c60001 66020200
> 66737000 1220000c

> All code
> ========
> 0: 24 18 and $0x18,%al
> 2: 7e 00 jle 0x4
> 4: 2d 18 64 00 38 sub $0x38006418,%eax
> 9: 00 84 64 00 00 62 dc add %al,-0x239e0000(%rsp,%riz,2)
> 10: f5 cmc
> 11: ff 4a c8 decl -0x38(%rdx)
> 14: 01 00 add %eax,(%rax)
> 16: c6 (bad)
> 17: 64 00 02 add %al,%fs:(%rdx)
> 1a: 02 66 00 add 0x0(%rsi),%ah
> 1d: 70 73 jo 0x92
> 1f: 66 data16
> 20: 0c 00 or $0x0,%al
> 22: 20 12 and %dl,(%rdx)

> Code starting with the faulting instruction
> ===========================================
> 0: 00 00 add %al,(%rax)
> 2: 62 (bad)
> 3: dc f5 fdiv %st,%st(5)
> 5: ff 4a c8 decl -0x38(%rdx)
> 8: 01 00 add %eax,(%rax)
> a: c6 (bad)
> b: 64 00 02 add %al,%fs:(%rdx)
> e: 02 66 00 add 0x0(%rsi),%ah
> 11: 70 73 jo 0x86
> 13: 66 data16
> 14: 0c 00 or $0x0,%al
> 16: 20 12 and %dl,(%rdx)

    This is x86 disassembly -- you should have used MIPS cross-tools.

WBR, Sergei
