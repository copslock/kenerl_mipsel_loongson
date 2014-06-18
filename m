Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 15:20:03 +0200 (CEST)
Received: from mail-yh0-f51.google.com ([209.85.213.51]:62914 "EHLO
        mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819446AbaFRNUAQuI7M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2014 15:20:00 +0200
Received: by mail-yh0-f51.google.com with SMTP id f10so579124yha.10
        for <linux-mips@linux-mips.org>; Wed, 18 Jun 2014 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dZWwoZl++WsVVxO9O7k1cexyERXOb9hahkZOH503jsI=;
        b=pbPM/fC1KWy+Vv0p+bjJi9uTA3dUISyUaoJG9jslzzjviqj/bo4a04+OINsoIJBsng
         D/zvdktO6aAkW3b5j1fqfmMG5xUgAIK7Ft0gdB0I/BL8/3xAPE4q98R6768/1SissvH9
         FKOTiAMgYBlK4p/oh1hrj454D/aJWPl4J4TPy4vcZj0AGD0W5QDouWmjrEMkbSlOPahv
         q2Ye0NXnDnbM41Mdl2bCWVUFMvPbFoSY923YUUO6c+Rg8q4qN8uH6B0mVYWd/wsdxuv1
         auYKyUItG2Z+Uum/IuUfpw6BAnzJVJWl3mpxyg1f4kEU4bEmUY64t6Gu7SpTGNuDYaaD
         fhFQ==
X-Received: by 10.236.166.169 with SMTP id g29mr32023649yhl.135.1403097153860;
 Wed, 18 Jun 2014 06:12:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.170.168.136 with HTTP; Wed, 18 Jun 2014 06:12:13 -0700 (PDT)
In-Reply-To: <53A18DEC.3030609@phrozen.org>
References: <CAHNKnsSMvc+VeKumoDY5doR4YDhZ+3ezgY903uHnFH7BGQ+XRQ@mail.gmail.com>
 <53A17CD5.2060504@phrozen.org> <CAHNKnsS25qSenaXKCTB4URnOMAVvJmbotQz4hv4iukBTMcn0QA@mail.gmail.com>
 <53A18DEC.3030609@phrozen.org>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Wed, 18 Jun 2014 17:12:13 +0400
Message-ID: <CAHNKnsRrsAVHgUZExagVDVR+dkWGj9b6E_BfGek3Bv0syULsWQ@mail.gmail.com>
Subject: Re: Introducing Atheros AR231x/AR531x WiSoC support
To:     John Crispin <john@phrozen.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40631
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

2014-06-18 17:02 GMT+04:00 John Crispin <john@phrozen.org>:
> On 18/06/2014 14:51, Sergey Ryazanov wrote:
>>> is your code already available somewhere or do you plan to pusht
>>> he
>>>> owrt support upstream as is ?
>> I does not do any forks, all changes were made as patches that
>> were accepted to owrt. Then I plan to rebase the code on to
>> linux-mips.git and send upstream.
>
> so these are the patches in question ? ->
> https://dev.openwrt.org/browser/trunk/target/linux/atheros/patches-3.10
>
Yes. First three of them, other patches should be passed through
appropriate trees: netdev, mtd, etc. Seems that 100-board.patch should
be splitted on to small parts since it contains ~90 Kb (3000 lines) of
code.

-- 
BR,
Sergey
