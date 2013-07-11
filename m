Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jul 2013 11:32:16 +0200 (CEST)
Received: from mail-bk0-f42.google.com ([209.85.214.42]:56660 "EHLO
        mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671Ab3GKJcDiPWO0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Jul 2013 11:32:03 +0200
Received: by mail-bk0-f42.google.com with SMTP id jk13so3248911bkc.1
        for <multiple recipients>; Thu, 11 Jul 2013 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=B8+9cOeZ1wAZ5i59esQ3jDFF4jPQvUMXkv/lLEewQAc=;
        b=Kb2WLPZGFoYLBU/r7JyUiEZaeaxcECVreg7O7Ze3nrXSf8SEC0n3Q4ni+Q08UqOBqC
         SxP3iSvIhxcB95fPxqpMV5tgdQCU19s1OfelaDHEseksvTxSis8kisGNYbOqp5hdMiEc
         4rYZE5FumLTKes0hBBiYLdMHVbJ5dUUtiSCiSGeQ4j90IoZ60UTe3Ua0SRfyCmj9McC2
         6GAB6PwBH3tTJHJjETPdi1lbfSSb+GvRtmu9xZIUggqG9x6hJ/6H2eQSbkU8B7eSq70R
         oSihE+wI2Pahu+PmwLPz6UkQEmSE9d0XsYkDXGSsPHXTXnSMwETnXqxRUr6BtydXYLyd
         FUEQ==
MIME-Version: 1.0
X-Received: by 10.205.9.129 with SMTP id ow1mr5437355bkb.43.1373535118076;
 Thu, 11 Jul 2013 02:31:58 -0700 (PDT)
Received: by 10.204.73.1 with HTTP; Thu, 11 Jul 2013 02:31:58 -0700 (PDT)
In-Reply-To: <20130628070829.GJ10727@linux-mips.org>
References: <1366030028-5084-1-git-send-email-chenhc@lemote.com>
        <1366030028-5084-13-git-send-email-chenhc@lemote.com>
        <20130628070553.GI10727@linux-mips.org>
        <20130628070829.GJ10727@linux-mips.org>
Date:   Thu, 11 Jul 2013 17:31:58 +0800
X-Google-Sender-Auth: 7v7trgsqTHccDaak4it5ztL9IZU
Message-ID: <CAAhV-H4m5c++fFTtr9kd294MXtRH-DwTMmXP2Ds7w+6S==jorw@mail.gmail.com>
Subject: Re: [PATCH V10 12/13] MIPS: Loongson 3: Add CPU hotplug support
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Normal labels and nops can be removed, but loongson3_play_dead()
should be run at CKSEG0, I'm afraid that it will have a wrong behavior
if I write it with C.

On Fri, Jun 28, 2013 at 3:08 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Jun 28, 2013 at 09:05:53AM +0200, Ralf Baechle wrote:
>
>> > +           "flush_loop:                             \n" /* flush L1 */
>>
>> Please don't use normale in inline assembler.  This might result in build
>> errors.  it's horrible to read but number local labels like:
>
> That was meant to read "Please don't use normal labels" in inline assembler.
>
>   Ralf
>
