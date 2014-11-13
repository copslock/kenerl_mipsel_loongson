Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 07:26:53 +0100 (CET)
Received: from mail-ie0-f178.google.com ([209.85.223.178]:65365 "EHLO
        mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012561AbaKMG0fzI7rb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 07:26:35 +0100
Received: by mail-ie0-f178.google.com with SMTP id rp18so14813535iec.23
        for <multiple recipients>; Wed, 12 Nov 2014 22:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WaekuOCVFlG7vA0/P/u/amBAh0YnjdBOkwR4zDMieU4=;
        b=ucBwXfCzlf2opMI9lulm+qv4QLw2vA4cQdtQ2o8WInw0zTZgScN61D6RtK781pDuYA
         WIWSAI8cI/1ZNZ9CtEz+LJxqm3h1A3kt51+bTGDAhcxt3gJ15SwjSjdO0Phneo+Ppx5a
         5MlvXUIhpJoUBuuYHVeyvE98yIMi79CBN6urNFcemVUo6xvrPfa+J4O4kkkMKpVkPudE
         jWWYmRrkuwXMWe8fQRQk0f2GH3g71R8edW3ljQCxXmI22pq641j1chRXIHrvUuqnuuEP
         kgJ0l8HGlLVxwdjMQNWJ45HE8VAmDLXNMVYSZK/KIhxOOgsuQZZDwe9Qgf2d7c+heCF2
         3aeA==
X-Received: by 10.42.255.72 with SMTP id nh8mr3016771icb.1.1415859990080; Wed,
 12 Nov 2014 22:26:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.246.168 with HTTP; Wed, 12 Nov 2014 22:26:09 -0800 (PST)
In-Reply-To: <1415794700-7579-1-git-send-email-chenhc@lemote.com>
References: <1415794700-7579-1-git-send-email-chenhc@lemote.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Thu, 13 Nov 2014 15:26:09 +0900
Message-ID: <CAAVeFuJ1+y8wooVAHMST9zC4_Z8SE6x=VASsFkUwCVFcA8xuLg@mail.gmail.com>
Subject: Re: [PATCH V3 2/5] MIPS: Loongson: Add Loongson-3A/3B GPIO support
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Hongbing Hu <huhb@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44104
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

On Wed, Nov 12, 2014 at 9:18 PM, Huacai Chen <chenhc@lemote.com> wrote:
> Improve Loongson-2's GPIO driver to support Loongson-3A/3B, and move it
> to drivers/gpio directory.

Could you split this in two patches:
1/2: move GPIO driver to drivers/gpio
2/2: support new devices in GPIO driver

and add the "-C" option to git format-patch so that file renaming gets
detected. This will make the changes easier to evaluate.

Thanks,
Alex.
