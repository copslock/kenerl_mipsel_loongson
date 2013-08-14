Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Aug 2013 21:37:09 +0200 (CEST)
Received: from mail-oa0-f42.google.com ([209.85.219.42]:44513 "EHLO
        mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827311Ab3HNTfrhxVhx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Aug 2013 21:35:47 +0200
Received: by mail-oa0-f42.google.com with SMTP id i18so13788321oag.15
        for <linux-mips@linux-mips.org>; Wed, 14 Aug 2013 12:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7RLEIjJiHc0MGrPzTKzPftFZHNz4r7Ewjnz3TnaPtdY=;
        b=A2fLDyGc/yoRrXJ1Y4WJELQIe1sXTUWsw04oGoS/Xr125ejgy4wOlpEq1zcb7qi7jJ
         FS/eGsGfdxx/SebyYZ7gSEvSiXODVaf4+PLkVzyc1gPJjBrsWfWlYEbsCOuevQ4rWQ6j
         LXnNFEZ9KvmmnXWMLu3u5VfSjPJJT8NaXme0sWWmBrHUsgAj8yzw1CQYNKRAkS4KB43y
         ezyM/Y4TD4BjscBPAXMmPb71Sl6WAVcNRFSDWiPqeqQfjaxrTe9TJ357xxDlGMAC5nf4
         tRu0J/D1cmgwMcnfpZmLaB9uY0/a6t+035ePPFsppxFyNeowpaA7Fx73ldhsQGth4iN6
         XF4Q==
X-Gm-Message-State: ALoCoQlr8yCWOjS0IuV0hsQAIDUZ/KcSgRlM1PXlMpk/myStk88V8fMqMFi43kPQ7si5JkGQLdo3
MIME-Version: 1.0
X-Received: by 10.182.204.4 with SMTP id ku4mr25257350obc.21.1376508934891;
 Wed, 14 Aug 2013 12:35:34 -0700 (PDT)
Received: by 10.182.120.7 with HTTP; Wed, 14 Aug 2013 12:35:34 -0700 (PDT)
In-Reply-To: <1375955300-31682-2-git-send-email-blogic@openwrt.org>
References: <1375955300-31682-1-git-send-email-blogic@openwrt.org>
        <1375955300-31682-2-git-send-email-blogic@openwrt.org>
Date:   Wed, 14 Aug 2013 21:35:34 +0200
Message-ID: <CACRpkdYMT23a+nhet6vffg0R-uft5aGiUc3KRipFHgyY3CwUYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl/lantiq: add missing gphy led setup
From:   Linus Walleij <linus.walleij@linaro.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Thu, Aug 8, 2013 at 11:48 AM, John Crispin <blogic@openwrt.org> wrote:

> Signed-off-by: John Crispin <blogic@openwrt.org>

Patch applied.

Yours,
Linus Walleij
