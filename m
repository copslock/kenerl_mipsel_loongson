Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Oct 2014 20:47:17 +0200 (CEST)
Received: from mail-yh0-f43.google.com ([209.85.213.43]:41313 "EHLO
        mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010493AbaJCSrQArvMG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Oct 2014 20:47:16 +0200
Received: by mail-yh0-f43.google.com with SMTP id f73so353124yha.30
        for <multiple recipients>; Fri, 03 Oct 2014 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=llqis4DBGoJDYSDlULzXyAh/BLrdbQhLA01WuucknUk=;
        b=mLkFbrk3ssGFu4doi1NgAbwPz3gLfnQ3CpKscRWg7SUV1plbo8Zn+3R380qxDiuApV
         5MWEH0Frx2IxMk6UkTj8Qp2HNNZHdnZ5lzRp8NTsp+cGIpR3JRMQ13w6dXlVhO8IKXWe
         mXwJmuiXPd1Qoeds+UnqA3ENh12XYnR7waM5vuuY0SX/T5FSk7fl26TJ/gRhirmTP2Nw
         c9CvtdxFRFNhde0cYGj56SBragXWkakIS2FMITU82uLT+uaBVIB/muwyUkUYgTS55av3
         NOQIZhueFxatM7hpmiqftahCpc8Ydbet8yMcBPTJw/NaiCWCBSG81lnIPkRIGym0i2Dc
         O8HA==
X-Received: by 10.236.136.168 with SMTP id w28mr10535942yhi.132.1412362029607;
 Fri, 03 Oct 2014 11:47:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.153.135 with HTTP; Fri, 3 Oct 2014 11:46:49 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Fri, 3 Oct 2014 22:46:49 +0400
Message-ID: <CAHNKnsTkeeg6c4NGqBRVbaG4gF7_rkrGuGxZ3Ty5MeQOF6ox6g@mail.gmail.com>
Subject: Atheros AR231x MIPS machine name (ex [PATCH 01/16] MIPS: ar231x: add
 common parts)
To:     Jonas Gorski <jogo@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        OpenWrt Development List <openwrt-devel@lists.openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Add owrt mailing list to cc.

Any suggestions?

2014-09-30 0:57 GMT+04:00 Sergey Ryazanov <ryazanov.s.a@gmail.com>:
> 2014-09-29 13:30 GMT+04:00 Jonas Gorski <jogo@openwrt.org>:
>> On Sun, Sep 28, 2014 at 8:33 PM, Sergey Ryazanov <ryazanov.s.a@gmail.com> wrote:
>>> Add common code for Atheros AR5312 and Atheros AR2315 SoCs families.
>>>
[...]
>>>
>>> +config AR231X
>>
>> I would suggest naming it ATH25, to match the other atheros target (ATH79).
> I have been thinking about such name. But decided to keep code closer
> to owrt realization. May be maintainers could suggest smth. Ralf, what
> do you think?
>

-- 
BR,
Sergey
