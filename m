Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 13:45:24 +0100 (CET)
Received: from mail-ie0-f176.google.com ([209.85.223.176]:52887 "EHLO
        mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013195AbaKKMpWxJHv8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 13:45:22 +0100
Received: by mail-ie0-f176.google.com with SMTP id rd18so10927595iec.7
        for <multiple recipients>; Tue, 11 Nov 2014 04:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zAXFvdUDUVGoIGt6CnT8ufakY83Pz9HXrmYWUoTSJ4I=;
        b=HecwrtYfJTI5GvJ6SeErybPt6r+KomF+ALKnEjaijxcytGw8IFfKdkgJpVPU7I5smM
         SgvizDB5+gZl9vnOJ09CATX8ldWJs7OiCMB5NAuQldNiKEUz0Sz/uumIH0A5cTkNTx49
         DdOLT8ilVAft14O3iN/hQo+HpLyZpsNDZxMkAgfNHPMz/TH4JQjk2+K/1OKCYgtniRLL
         y0VsTu98jKKRCXrGO9nfuNZbbFV3CODYd0LJldqfYXZQyXfEUAPnN4t1PLITfMwS9Wju
         qInYm2iwzIaau380WqMxjH7j69c8D9o26ykwofXLMvFdoP9vTwduN0qabW3UURqyUPc6
         RWlg==
MIME-Version: 1.0
X-Received: by 10.50.138.76 with SMTP id qo12mr32329530igb.43.1415709917148;
 Tue, 11 Nov 2014 04:45:17 -0800 (PST)
Received: by 10.64.176.211 with HTTP; Tue, 11 Nov 2014 04:45:17 -0800 (PST)
In-Reply-To: <20141111101811.GH27259@linux-mips.org>
References: <1415081610-25639-1-git-send-email-chenhc@lemote.com>
        <1415081610-25639-8-git-send-email-chenhc@lemote.com>
        <20141111101811.GH27259@linux-mips.org>
Date:   Tue, 11 Nov 2014 20:45:17 +0800
X-Google-Sender-Auth: VUlCufNCrcRkdPvrjLWjcv_ZGbE
Message-ID: <CAAhV-H7rLfSmndki5H3KSRzTc5i9dH1Y-X919y6DyFee+=dsSA@mail.gmail.com>
Subject: Re: [PATCH V2 07/12] MIPS: Loongson: Add Loongson-3A/3B GPIO support
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongbing Hu <huhb@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43999
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

It seems like I should send a V3 patchset since many of them need to modify.

On Tue, Nov 11, 2014 at 6:18 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Nov 04, 2014 at 02:13:28PM +0800, Huacai Chen wrote:
>
> This looks like a full blown GPIO driver and thus should be moved to
> drivers/gpio.
>
>   Ralf
>
