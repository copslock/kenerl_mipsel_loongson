Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 14:48:40 +0100 (CET)
Received: from mail-ie0-f179.google.com ([209.85.223.179]:45710 "EHLO
        mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007388AbbBZNsjjh3RB convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Feb 2015 14:48:39 +0100
Received: by iecat20 with SMTP id at20so15195361iec.12;
        Thu, 26 Feb 2015 05:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/FEiy9Ovx/TqLFF3rqSHGruB+TvEi1kCQr0CQA4DmNA=;
        b=E5gHXB8R5DvKu67HY8pJwFvmoZOS49Ge9X2cvkqPlFGAZ7mA4/49njO/muSLd5KiDf
         ds4a4BdZckDN1KNlS2zCdwu0GHR7aCK11KcVvJStBhGTb3qRbI0XuWKPS1d4VplegAkj
         tAtMl73gNiahovw3NXrMQ1k4z2hM0XS9oViXeakAlLJb+9fTRlFyjU08Gm/591KzyMht
         r3KtF3o9EkQ7XS1CpT53hZiESa7lA+TUcg72WKe938tiPkXRx5s9WFuGwpn9+FT8JHD+
         d/gM06sAEubxwgj8BZrV5+3K/3rv/blaJhEh22kvpH80kyfSRpb3+/E+bVIFeP2rXXjn
         RFpA==
X-Received: by 10.107.170.220 with SMTP id g89mr11442616ioj.31.1424958514167;
 Thu, 26 Feb 2015 05:48:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.252.202 with HTTP; Thu, 26 Feb 2015 05:48:14 -0800 (PST)
In-Reply-To: <tencent_5337E0085A0993E56C99045F@qq.com>
References: <tencent_5337E0085A0993E56C99045F@qq.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Thu, 26 Feb 2015 22:48:14 +0900
Message-ID: <CAAVeFuJM8zxvAx_+00ezWCe5aD+bjY=a7WgoBrAEn56pS_dCeA@mail.gmail.com>
Subject: Re: Re: [PATCH V7 3/8] MIPS: Cleanup Loongson-2F's gpio driver
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnurou@gmail.com
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

On Thu, Feb 26, 2015 at 10:35 PM, 陈华才 <chenhc@lemote.com> wrote:
> I have tested, could I add myself?

No. :) But it's good to know that you have tested, too many patches
get submitted without care.

What I would like to get is an ack from a MIPS maintainer so we can
move this code away from that architecture
