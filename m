Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2015 22:27:06 +0200 (CEST)
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38454 "EHLO
        mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007283AbbEZU1EwSbKY convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 26 May 2015 22:27:04 +0200
Received: by igcau1 with SMTP id au1so62717440igc.1;
        Tue, 26 May 2015 13:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=IIWheii2gXIw05Bp8O7jJoymHW2p50fUzF4QM2rSins=;
        b=NA9YU3arVc/J8LmGp9DyIb9etM4UcsRsky641WsD32VkB1OyRpad7lshzX9dIKolMt
         plPAhc8FLwaPx+KqUQSYaRSO7X2Dp+u4Q0G7uCY9fHt+0U7zAIcPFs36Ny/sl9DDDSMf
         GKtD+vqDGLO0lv1LK3G3iQz2K79O7UTqF0yW8h35usFjJ4rnYP8/vnN00u7fLbrXOAWH
         p6fEX2+Q6TQ8aWYtKQznM3smkPGUFh1uWdtCYZ2CGXa+y9d+ZbVYT/I0vRdJjP3xG/Ug
         P6kkIZ1kq0SUwQrFcILY5O4ZhipEgDvfbI7ZHQgJJkSxACWdIkpk9V+qLi1Z6M0CIVIQ
         gq8w==
MIME-Version: 1.0
X-Received: by 10.50.138.74 with SMTP id qo10mr32255707igb.39.1432672021601;
 Tue, 26 May 2015 13:27:01 -0700 (PDT)
Received: by 10.107.36.73 with HTTP; Tue, 26 May 2015 13:27:01 -0700 (PDT)
In-Reply-To: <1429732713-9366-1-git-send-email-riproute@gmail.com>
References: <1429732713-9366-1-git-send-email-riproute@gmail.com>
Date:   Tue, 26 May 2015 22:27:01 +0200
Message-ID: <CACna6rxeu42D5YaOJEOikDSnFmCzuzW=NzbDS+=u4ysHKXh2HQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Support Luxul XWR-1750 board
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Dan Haab <riproute@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, Dan Haab <dhaab@luxul.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 22 April 2015 at 21:58, Dan Haab <riproute@gmail.com> wrote:
> From: Dan Haab <dhaab@luxul.com>
>
> Signed-off-by: Dan Haab <dhaab@luxul.com>

Acked-by: Rafał Miłecki <zajec5@gmail.com>
