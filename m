Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2014 17:57:57 +0200 (CEST)
Received: from smtpbgsg2.qq.com ([54.254.200.128]:51706 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6855266AbaHSP5xKWXa3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Aug 2014 17:57:53 +0200
X-QQ-mid: bizesmtp5t1408463787t756t311
Received: from mail-ie0-f179.google.com (unknown [209.85.223.179])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 19 Aug 2014 23:56:26 +0800 (CST)
X-QQ-SSF: 01100000002000F0FF22B00A0000000
X-QQ-FEAT: eldlmQs3gWnw92zUYfgLBc5oIibdIEKBI/05agUrMJUFLtawtI7xsyZVuLn2X
        rid9G/RAfESRIwij2ChWRhuGsh32y0APXIFvqOItahbzgHatz8YClVND6AGqc6MF9lpBDnh
        RKPKrqAwyDZHBl9oPHQcpT9/9KLxtchF9EiKhirP0lP/pMzNMcusz2Jea7U7OTDPEYWgIYM
        =
X-QQ-GoodBg: 0
Received: by mail-ie0-f179.google.com with SMTP id rl12so1349161iec.38
        for <multiple recipients>; Tue, 19 Aug 2014 08:56:25 -0700 (PDT)
X-Received: by 10.50.147.70 with SMTP id ti6mr6683512igb.45.1408463785057;
 Tue, 19 Aug 2014 08:56:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.42.198 with HTTP; Tue, 19 Aug 2014 08:56:05 -0700 (PDT)
In-Reply-To: <20140801164803.GA17520@linux-mips.org>
References: <1405047990-12519-1-git-send-email-chenhc@lemote.com>
 <1405048453-12633-1-git-send-email-chenj@lemote.com> <20140711155631.GE8187@pburton-laptop>
 <CAGXxSxV2KWiArguRRKWcbC82sZJweyjiDBBpJdWPne_Ag_Z_+w@mail.gmail.com>
 <CAAhV-H5z1Xu5Mg0X68Yf_mpi8ZBg96TEYLkk4_2_Grb8=ET05Q@mail.gmail.com>
 <20140712093003.GF8187@pburton-laptop> <CAAhV-H4PbCLam5jdUjCdn9X9+pL6HR5=8wT_6TPWMt31qv4gMA@mail.gmail.com>
 <20140801164803.GA17520@linux-mips.org>
From:   Chen Jie <chenj@lemote.com>
Date:   Tue, 19 Aug 2014 23:56:05 +0800
Message-ID: <CAGXxSxWnO8KiDBn_9-YF0TfXCmkRSxs-YcySVb+CEENeGU-f=Q@mail.gmail.com>
Subject: Re: [PATCH] Not preempt in CP1 exception handling
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42148
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

Please mark this patch as "Superseded", since patch "MIPS: Don't
BUG_ON(!is_fpu_owner()) in do_ade()"[1] was accepted :)

2014-08-02 0:48 GMT+08:00 Ralf Baechle <ralf@linux-mips.org>:
> On Mon, Jul 14, 2014 at 10:22:47AM +0800, Huacai Chen wrote:
>
>> What do you think about? If you also prefer to totally remove the
>> BUG_ON(), I will send a new patch.
>
> I agree, removing the BUG_ON() is the right way.
>
>   Ralf

---
1. http://patchwork.linux-mips.org/patch/7354/
