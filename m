Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 02:42:15 +0200 (CEST)
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34891 "EHLO
        mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008096AbbFDAmOADXLp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 02:42:14 +0200
Received: by wiga1 with SMTP id a1so31420306wig.0;
        Wed, 03 Jun 2015 17:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GNcUR7B9cWcJtpECrD7q56HYm8xHUJzsOb1TgLJcfiY=;
        b=lQjq9vn/xtRztCSXqwYzg470HoCmoAR4gNZgSfHTAEO8P+VT0VcH7oU0siKXc79YB6
         mZvjd4kIQJ+oeOryj3kYChl/jpucxHYJ+MQkpZ+gLKq6/+GjcW1NsM5TDGQ46Ru09z7R
         IcKFF/VTz5+OIGgkPo+xc+keKNl2xmsc4vQOQEnhL8DEhz2jKJxJJqGqj7KyE8syLrJu
         eUob6Ip6BcHlluCGs1buNpgNEuM6EaTlyx517LuA0vy5zOqxR0mnCfhZQRLH8031e3MF
         3a8WuPpdn/8FZx7RxL0j9sB2zWFD9io1052mcQfuaQ+pVPAL6gKiFOZCe0xsIwBIeuR/
         MzwQ==
MIME-Version: 1.0
X-Received: by 10.180.38.68 with SMTP id e4mr2422123wik.32.1433378528808; Wed,
 03 Jun 2015 17:42:08 -0700 (PDT)
Received: by 10.28.11.4 with HTTP; Wed, 3 Jun 2015 17:42:08 -0700 (PDT)
In-Reply-To: <20150603062308.GL26432@linux-mips.org>
References: <20150603062308.GL26432@linux-mips.org>
Date:   Thu, 4 Jun 2015 08:42:08 +0800
Message-ID: <CAAhV-H4_35Hv_A_LQQe027E9hmfcSGcTppLPN5-AZq7ePHRDUQ@mail.gmail.com>
Subject: Re: ADMIN: Patchwork outage
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Hi, Ralf

Should we resend the patches which have been submitted in last month?

Huacai

On Wed, Jun 3, 2015 at 2:23 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> Hi,
>
> patchwork became one of the victims of the lmo upgrade on the weekend.
> Right now the web user interface of patchwork is functional but it
> doesn't accept new emails from the web.  That shouldn't be too much
> of an issue because you all submitted your patches in time so they
> made it into patchwork before the deadline ;-)  Anything submitted
> later sits safely in the list archives which will be fed to patchwork
> once the issue is sorted.
>
>   Ralf
>
