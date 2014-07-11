Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 05:15:01 +0200 (CEST)
Received: from smtpproxy19.qq.com ([184.105.206.84]:34043 "HELO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S6838840AbaGKDO6TeyZH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 05:14:58 +0200
X-QQ-mid: bizesmtp1t1405048450t442t261
Received: from mail-lb0-f174.google.com (unknown [209.85.217.174])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 11 Jul 2014 11:14:07 +0800 (CST)
X-QQ-SSF: 01100000002000F0FF22B00A0000000
X-QQ-FEAT: IT9GZpsyfQQIxWn8kwmwptVraHAAcjlurgME8lc6NquG3y7QqJ5gA3I9AwwRl
        fJycOjHn/29moCviMbkV3tL+WETXMi9V/q0cYWAKWD1cdhDIb4gtTiBmgTH4aWVFTq/Bpqz
        FIRNtHAAMdZzee+j79MflvTqJ4uR2iB0RhbR3VZMKcN/DcWJwQ==
X-QQ-GoodBg: 0
Received: by mail-lb0-f174.google.com with SMTP id u10so367601lbd.19
        for <multiple recipients>; Thu, 10 Jul 2014 20:14:05 -0700 (PDT)
X-Received: by 10.152.27.194 with SMTP id v2mr2085585lag.57.1405048445146;
 Thu, 10 Jul 2014 20:14:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.114.200.39 with HTTP; Thu, 10 Jul 2014 20:13:45 -0700 (PDT)
In-Reply-To: <1405048453-12633-1-git-send-email-chenj@lemote.com>
References: <1405047990-12519-1-git-send-email-chenhc@lemote.com> <1405048453-12633-1-git-send-email-chenj@lemote.com>
From:   Chen Jie <chenj@lemote.com>
Date:   Fri, 11 Jul 2014 11:13:45 +0800
Message-ID: <CAGXxSxU873vrqqJciGAaENq3r6tt6OQsCkc6jgOKiT9GJwp-Ug@mail.gmail.com>
Subject: Re: [PATCH] Not preempt in CP1 exception handling
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?546L6ZSQ?= <wangr@lemote.com>, chenj <chenj@lemote.com>
Content-Type: text/plain; charset=UTF-8
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41134
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

Note this is another example patch to solve the problems in
http://patchwork.linux-mips.org/patch/7297/

gin 	
