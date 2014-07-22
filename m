Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 06:24:16 +0200 (CEST)
Received: from mail-vc0-f178.google.com ([209.85.220.178]:54356 "EHLO
        mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822197AbaGVEYMPDf1- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 06:24:12 +0200
Received: by mail-vc0-f178.google.com with SMTP id la4so13879810vcb.37
        for <multiple recipients>; Mon, 21 Jul 2014 21:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=4ZHmMBkyc6qr8W1X8Rm1yGky8hRnWB/xEIa6AVxfRSU=;
        b=NKljb0buatnuRlT1fAcR51ptkeoOoogaGkm2YCtXWPGHlA9JnhIntize7M3wCKG976
         X1Pz7TuVY/wu5v/vwQtzWjbqUeLFshLMgyo0fUf3ko46hfI6GMj6MZbLvh1PfUOLb540
         EmTcOV2dcGMF/pzmeq904Z9Wv7aFSqvIW1kpdPWg2saWWeF0acmO8XRyfi7YQyjdU5m6
         lejVRG6iu0NCvIqh+f5pzHz05zf/ao2hAacsCZTS6NVZt+bZCylxkVZ6ycocolwkmDgk
         bjE+8mtEcWA7f+NhUzQwUYIvzgPwSQtiEz2zK9EOD1p6jpHZL2wm9pqm2yafcg0nAKxm
         5zZw==
MIME-Version: 1.0
X-Received: by 10.220.30.69 with SMTP id t5mr36245540vcc.6.1406003045806; Mon,
 21 Jul 2014 21:24:05 -0700 (PDT)
Received: by 10.220.187.133 with HTTP; Mon, 21 Jul 2014 21:24:05 -0700 (PDT)
Date:   Tue, 22 Jul 2014 00:24:05 -0400
Message-ID: <CAPDOMVhUkF49L1jJgfXdRdMW2qkGsbPfGVwrdaETqTUs3bEcsQ@mail.gmail.com>
Subject: decompress.c : Add cache support
From:   Nick Krause <xerofoify@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, antonynpavlov@gmail.com, blogic@openwrt.org,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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

Hey Ralf and others
We seem to be flushing this cache after decompressing the kernel on
mips. Can't we cache this?
If anyone has any advice on how to fix this it would be great:).
Nick
