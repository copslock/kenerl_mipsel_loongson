Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2014 23:20:20 +0100 (CET)
Received: from mail-qg0-f48.google.com ([209.85.192.48]:54651 "EHLO
        mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819678AbaCSWUSR303d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Mar 2014 23:20:18 +0100
Received: by mail-qg0-f48.google.com with SMTP id j107so27651247qga.7
        for <linux-mips@linux-mips.org>; Wed, 19 Mar 2014 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rfHQbtXkKKjHkLwkVWDuxjMNpIvA0SMwlxgCQ9nusOc=;
        b=uunlo+XeEMUgytGjhqj32afYlVCdTaUYf5mv/YkTS316F7UyQQqZcLCfHtCh5KiWe7
         td5rZse76ER2BZ9WtI69rzor4uMoaU9Woizj3/AYJuh6LtFjcZ/xvve/nBozPUDV3epX
         lj9wlWPk0+xCxlkS2zrwaxD5rQ7A0dyTrl/XPSyu4QOLYKtaRZ7DgDvpdrpBTI8Rhjlo
         vV3adxJO9LRN48Eq7bckNnZ/j1DZ3Q/b6RHueN3CyH3jKzYHmbrjNsICY1E1+2uW7LtM
         EyGKEmUdMGkuFByyV99bPX23IrOdD4lJCEk0T8IdRhHevEVugckM8/zvhkwNfHHwTz/7
         PWBg==
X-Received: by 10.140.16.198 with SMTP id 64mr32388066qgb.10.1395267611909;
 Wed, 19 Mar 2014 15:20:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.207.65 with HTTP; Wed, 19 Mar 2014 15:19:51 -0700 (PDT)
In-Reply-To: <1395266643-3139-3-git-send-email-eparis@redhat.com>
References: <1395266643-3139-1-git-send-email-eparis@redhat.com> <1395266643-3139-3-git-send-email-eparis@redhat.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Wed, 19 Mar 2014 15:19:51 -0700
Message-ID: <CAEdQ38Ex47GxhN1ZZMu+RETpWs-ENbfCr8v=6iFg9p_QWaa9zw@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARCH: AUDIT: implement syscall_get_arch for all arches
To:     Eric Paris <eparis@redhat.com>
Cc:     linux-audit@redhat.com, linux-ia64@vger.kernel.org,
        microblaze-uclinux@itee.uq.edu.au,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux@openrisc.net,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mattst88@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
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

On Wed, Mar 19, 2014 at 3:04 PM, Eric Paris <eparis@redhat.com> wrote:
> For all arches which support audit implement syscall_get_arch()

support audit -- is that AUDIT_ARCH? If so, alpha gained support
recently, so I think this patch needs to handle alpha too?
