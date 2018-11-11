Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2018 21:18:56 +0100 (CET)
Received: from mail-wr1-x443.google.com ([IPv6:2a00:1450:4864:20::443]:42115
        "EHLO mail-wr1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990757AbeKKURury7pe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2018 21:17:50 +0100
Received: by mail-wr1-x443.google.com with SMTP id u5-v6so1836694wrn.9
        for <linux-mips@linux-mips.org>; Sun, 11 Nov 2018 12:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sngmm96Z9HsNEvqgT2i1q25cJ7sOvu12JY9z1ptp2QY=;
        b=Sei0tki9nJ+7IEkgAXoEnqbwalnurm67aufaTKAdYCt5CaDphlBkYlNrYR3yCqZHCz
         mqYj+0ejf80T0Ht3Omg/nIYHh3cpfuFHRtQQ/YIX/w8JFTiNJzn+eY3UzVOgMdf8GIlL
         f86wzp8lbcl44QESxnPkngWPGqb6xekdga2WBXc/QPSz+02C4v94YZffqHCFIV9DyPGc
         DUxYYoCNvCOOKVDk/jj/SFpXrPItFoR2U1+sa0ULI4n6KlDvQzXp1AO3JhO1W9v9QMAC
         JsSXrhSoTK+FjoYTZeGyS1mHpH8RuzuO/GYXplj3EkFFHGlazYCHGBkOgK9t6U6n+yWM
         grbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sngmm96Z9HsNEvqgT2i1q25cJ7sOvu12JY9z1ptp2QY=;
        b=DNas9OioUPwnok+F1Xwrs78cQWV6uvzqCjZ3eXMRLlPlfBA4iKVU3tcRNkyDpjxHuk
         lhhppAKojUii5ElC6RuPOuRy4anVyrc+d89U11wAWfzckXZkl/elXHBNhxa7fAf1Waec
         Pv1Z+gEx7RjzjgGOGGBVyKKREIGd7Fr8IMLf2NTbGtCVnoNHsd2L3l6lOK7LBspMjPFw
         Y6/IvZHwEJ23ZECsOv1v7BKWuB0l2CojmWljIHT60xSk0kjKInAxvxsB+umpeXeUi0fl
         0nwFvJ27vLag0WNRa8QXgibMC+vvrOZ6DJkfWq83M9TEJVgpbrfY0V4aoP8pjxqsn8Am
         35Tg==
X-Gm-Message-State: AGRZ1gK2tM9sLkDUk2c4+WucsD/F6h5YHTzZm/9w3He+SR6nPT1JfMST
        PPyX8Sm/kvbqdy5KNMshOCRlHC0fs5pzgtvMkiw=
X-Google-Smtp-Source: AJdET5eAaCZm0KE5FeZzlaJhdoUSnt8b4C1/HdMwwzpAMUyt4+nQJIQKacRGm/wU2LNNBIAyX/k71y9cQGqmqZUaNdA=
X-Received: by 2002:a5d:4747:: with SMTP id o7-v6mr14412215wrs.256.1541967469482;
 Sun, 11 Nov 2018 12:17:49 -0800 (PST)
MIME-Version: 1.0
References: <lsq.1541965744.387173642@decadent.org.uk> <lsq.1541965745.189575243@decadent.org.uk>
In-Reply-To: <lsq.1541965745.189575243@decadent.org.uk>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Sun, 11 Nov 2018 21:17:38 +0100
Message-ID: <CACna6rx3LPxuYKtJOmZP-Pt-HMAhh99qHVsxVFv=XoPuJ1azbw@mail.gmail.com>
Subject: Re: [PATCH 3.16 151/366] MIPS: BCM47XX: Enable 74K Core ExternalSync
 for PCIe erratum
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        James Hogan <jhogan@kernel.org>,
        Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67238
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

On Sun, 11 Nov 2018 at 21:05, Ben Hutchings <ben@decadent.org.uk> wrote:
> 3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

Nack. This patch has caused a regression and had to be reverted.
Please check upstream repository for a revert (search git log for
2a027b47dba6).
