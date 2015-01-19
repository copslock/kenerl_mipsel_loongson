Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 07:22:26 +0100 (CET)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:63520 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011199AbbASGWZ3UKn7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 07:22:25 +0100
Received: by mail-ig0-f177.google.com with SMTP id h15so3545978igd.4;
        Sun, 18 Jan 2015 22:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=S8oL9oNIEmX56bTi912562uOkhGOgSPhSZS69lcDo4I=;
        b=XCBPDjc2w9JmaXvzMsOUE1as1NuTckh360Slit1IfS6xTOu3/GaGduLnT9KBlnaGYc
         wfABsSAMHY1E6nj7xsIcpAk8oxhFIDkD35B8FpozKueoVIajHo+VpA6ctHkru2rINpQi
         fgtDLY4t3w70cGtAmfjY3LmzJWlY2k+6f5UXCT4d3PZPOxYD8iWq3S8xzShMe03Vmino
         8FYT3Ii8t/5tsLSXz5dR8WiOxqISGalTwzp7scFElMdlH9cN7hMHo82tfsnOW4ODEY4i
         1YMwNpT49eckiwFT1r6A6NDJsuWKNym8A3RVAQkYnnPHcob8z2o9Rhne+whoTUjwzkaV
         zqpw==
X-Received: by 10.43.95.2 with SMTP id ca2mr26976690icc.89.1421648539684; Sun,
 18 Jan 2015 22:22:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.139.99 with HTTP; Sun, 18 Jan 2015 22:21:59 -0800 (PST)
In-Reply-To: <1419742654-15094-3-git-send-email-chenhc@lemote.com>
References: <1419742654-15094-1-git-send-email-chenhc@lemote.com> <1419742654-15094-3-git-send-email-chenhc@lemote.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Mon, 19 Jan 2015 15:21:59 +0900
Message-ID: <CAAVeFuJ=1BS3-_vDjiQCJuTDuTvRwzCJRhaFOqegzninOnYFVQ@mail.gmail.com>
Subject: Re: [PATCH V6 5/8] GPIO: Add Loongson-3A/3B GPIO driver support
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <gnurou@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45292
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

On Sun, Dec 28, 2014 at 1:57 PM, Huacai Chen <chenhc@lemote.com> wrote:
> Improve Loongson-2's GPIO driver to support Loongson-3A/3B, and update
> Loongson-3's default config file.

This looks ok at first sight, but I will make a more complete review
on the next revision of this series with the comments of patches 3
addressed and the assurance that these patches have been tested
individually.
