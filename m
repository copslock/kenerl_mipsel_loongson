Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2014 17:04:32 +0200 (CEST)
Received: from smtpbg298.qq.com ([184.105.67.102]:45065 "HELO smtpbg298.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6843087AbaFCPE2iEXGX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Jun 2014 17:04:28 +0200
X-QQ-mid: bizesmtp5t1401807853t021t238
Received: from mail-lb0-f169.google.com (unknown [209.85.217.169])
        by esmtp4.qq.com (ESMTP) with 
        id ; Tue, 03 Jun 2014 23:04:09 +0800 (CST)
X-QQ-SSF: 0110000000600010F522B00A0000000
X-QQ-FEAT: R/rVWRApojH6x3BiKl5rpsYzCBjBkIWxAtBG/IkqA4AL0CV0spXTiDTln0vda
        jK7IAfiz41m/+LryMIVKPzfi8tMIcS7qup8RFF70KKXJMVpPwEDKwzg0zXS72RSibCjLTo6
        5Ok0ovqvG/58eKgCl46lSyA/guS7lk723c8R7chiaEXEc0VUpw==
X-QQ-GoodBg: 0
Received: by mail-lb0-f169.google.com with SMTP id s7so3543356lbd.0
        for <multiple recipients>; Tue, 03 Jun 2014 08:04:06 -0700 (PDT)
X-Received: by 10.112.64.33 with SMTP id l1mr2619592lbs.79.1401807846763; Tue,
 03 Jun 2014 08:04:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.63.198 with HTTP; Tue, 3 Jun 2014 08:03:46 -0700 (PDT)
In-Reply-To: <20140603110321.GR17197@linux-mips.org>
References: <1400137743-8806-1-git-send-email-chenj@lemote.com>
 <1400137743-8806-2-git-send-email-chenj@lemote.com> <20140603110321.GR17197@linux-mips.org>
From:   Chen Jie <chenj@lemote.com>
Date:   Tue, 3 Jun 2014 23:03:46 +0800
Message-ID: <CAGXxSxWnqiywgbRRCtKAuip+eXy++N3mB_3CkoLXva5hD18nrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?UTF-8?B?546L6ZSQ?= <wangr@lemote.com>
Content-Type: text/plain; charset=UTF-8
X-QQ-SENDSIZE: 520
X-QQ-FName: C4B6B82F70544590B27EE4E524F7663A
X-QQ-LocalIP: 163.177.66.155
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40420
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

2014-06-03 19:03 GMT+08:00 Ralf Baechle <ralf@linux-mips.org>:
> On Thu, May 15, 2014 at 03:09:03PM +0800, chenj wrote:
>
>> wsbh & movn are available on loongson3 CPU.
>> ---
>>  arch/mips/lib/csum_partial.S | 10 ++++++++--
>
> Does Loongson 3 also have both the DSBH and DSHD instructions?
Both of these two instructions are available on Loongson 3a.
