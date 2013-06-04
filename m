Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jun 2013 11:38:40 +0200 (CEST)
Received: from mail-pd0-f174.google.com ([209.85.192.174]:50291 "EHLO
        mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823034Ab3FDJigPjalH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jun 2013 11:38:36 +0200
Received: by mail-pd0-f174.google.com with SMTP id 3so6920201pdj.5
        for <linux-mips@linux-mips.org>; Tue, 04 Jun 2013 02:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=X33kMKGBr80Q8dqFpMg/zCJEsvAXjVxQYQT+hlNMEpY=;
        b=qIHrdV/jglkFjHdfCdtajSvPr/aaqrpBHdfobOIL9kOK8gu5SZEkfykysLAABVPayQ
         MQOh9HoVt7PBTnMAz95beImpo2bHb0NEs4G1axOWg10NiR09LthHVYjPXpMJgJyPGy+d
         AleZvoS1zpobDwciifN0TC+fngGdtc5bGBRNnR9nmKrfvoNgpvacMbvGf2PmuIEgF2Xg
         UA5jvP4cjygLEv5Y6c13Pf+HrxlT2vCoS1522GSEHHL6zSWqFbzxWdva9xaFtePfGnnf
         xM13OJq8do2basbokdc6CUknJxtYFCHmfqcCs6BzOhB08NmuM0YP+roZtD/B/i6d5mC7
         E7yw==
X-Received: by 10.68.231.37 with SMTP id td5mr27827355pbc.52.1370338709431;
 Tue, 04 Jun 2013 02:38:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.222.65 with HTTP; Tue, 4 Jun 2013 02:37:49 -0700 (PDT)
In-Reply-To: <51A8B753.4090900@phrozen.org>
References: <1370009264-22018-1-git-send-email-f.fainelli@gmail.com> <51A8B753.4090900@phrozen.org>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Tue, 4 Jun 2013 10:37:49 +0100
X-Google-Sender-Auth: Pa6vq_V628GUpzy572o5ZGk41RE
Message-ID: <CAGVrzcYuQxbWrc58RG=iiwOzvs7QdwifzswEAfiQ--S22CD7zA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: define write{b,w,l,q}_relaxed
To:     John Crispin <john@phrozen.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36670
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

2013/5/31 John Crispin <john@phrozen.org>:
> On 31/05/13 16:07, Florian Fainelli wrote:
>>
>> MIPS does define read{b,w,l,q}_relaxed but does not define their write
>> counterparts: write{b,w,l,q}_relaxed. This patch adds the missing
>> definitions for the write*_relaxed I/O accessors.
>>
>> Signed-off-by: Florian Fainelli<f.fainelli@gmail.com>
>
>
> Acked-by: John Crispin <blogic@openwrt.org>

This probably needs consolidation at the include/asm-generic/io.h
level, quite a lot of architectures have the same definition as MIPS
here.
