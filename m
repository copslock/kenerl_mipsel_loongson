Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Dec 2017 07:30:50 +0100 (CET)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:42265
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbdLGGaoUVSG2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Dec 2017 07:30:44 +0100
Received: by mail-pf0-x243.google.com with SMTP id d23so3963699pfe.9;
        Wed, 06 Dec 2017 22:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=2FTPCOEeILV6HgeV9uV4Vb35DeLsDBoPaUbOrY4ee1Q=;
        b=A1T23WvAHfJR3P8JkSJeH8OzvyDVoiM/Q/23+ATZmj9tEb6ElyCBM6hPeo0/K2p3Tz
         f2NJqfKNh9pJTKev3FI2l12O2jBgWBtyX0bzXHZvp6ReqIn9gz4CcloMprc4lrIfAz9S
         vP+T/nf+k3wfl/7tCrVTYPTsNkPMjubcf4pxdaPJ3lC8DgDcoWjtV4QudplircHsVKFC
         ulEqJ9PuTaue5KvRP29DMUYbjtmHxoUFCNeIps1Pa946NeBrOlp/34f/xb3Lr21hvSln
         QHlCbozXlU6N3LCgqna96YlXLOWVT8X3uQO4+IC5VYkHY1eoWkj7x92/kEzLnyUXFnnh
         KTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=2FTPCOEeILV6HgeV9uV4Vb35DeLsDBoPaUbOrY4ee1Q=;
        b=nl5G7wxS3PUbzYNSxU4sjSc7/ubMQxyvcwDynFQIpRtDfclsfHIOh+Pbfd7wR5g3dV
         g56TsayXrbC7z8tWM4bPe4dX2CK1OX2Zp5gASafobULvOxZ6cFVbg6e+VA+LyQwutLdg
         ArResiu1EoTfhLdrbXY2FFHBs9RJKx2tbhug2NvG1m5lMQEAgp2gY1ynz0+a5dDZ474W
         Jt1A8aeq5MMnidjCaC7htjQPN+QB893hlEa8E8BbKe6qsT6bySOFg82IqvmwBixvWO4S
         8P3FqOvFOTtMthP0/Wh/3eLXGQ1mC8aOiMpLazZCRnIet5MNzi2X4TMGKmRzwd9ehsuY
         bstw==
X-Gm-Message-State: AJaThX5UsAzRDso/d6Nv0aHdhAJ/RbzQ5/9/XVpQ/aV9HAJoWWOs7Mla
        CiuskYXFBp0VC1YRWqr+7eY=
X-Google-Smtp-Source: AGs4zMbm8MsL9YrXwCHXSCDh6/LHL7rGQvj3qNIlhrJqX5Tls3WCA7hUJTeuxBXznEvRw+LlI96UWA==
X-Received: by 10.99.167.6 with SMTP id d6mr23575424pgf.100.1512628237607;
        Wed, 06 Dec 2017 22:30:37 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id b67sm7586351pfm.19.2017.12.06.22.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Dec 2017 22:30:36 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
Cc:     Rui Wang <wangr@lemote.com>, Binbin Zhou <zhoubb@lemote.com>,
        Ce Sun <sunc@lemote.com>, Yao Wang <wangyao@lemote.com>,
        Liangliang Huang <huangll@lemote.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, r@hev.cc,
        zhoubb.aaron@gmail.com, huanglllzu@163.com, 513434146@qq.com,
        1393699660@qq.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 0/1] About MIPS/Loongson maintainance
Date:   Thu,  7 Dec 2017 14:31:07 +0800
Message-Id: <1512628268-18357-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61328
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

Hi, Linus, Stephen, Greg, Ralf and James,

We are kernel developers from Lemote Inc. and Loongson community. We
have already made some contributions in Linux kernel, but we hope we
can do more works.

Of course Loongson is a sub-arch in MIPS, but linux-mips community is
so inactive (Maybe maintainers are too busy?) that too many patches (
Not only for Loongson, but also for other sub-archs) were delayed for
a long time. So we are seeking a more efficient way to make Loongson
patches be merged in upstream.

Now we have a github organization for collaboration:
https://github.com/linux-loongson/linux-loongson.git

We don't want to replace linux-mips, we just want to find a way to co-
operate with linux-mips. So we will still use the maillist and patchwork
of linux-mips, but we hope we can send pull requests from our github to
linux-next and linux-mainline by ourselves (if there is no objections
to our patches from linux-mips community).

If we are doing something wrong, please let us know. Thanks very much!

--
2.7.0
