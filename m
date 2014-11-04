Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2014 14:40:17 +0100 (CET)
Received: from mail-ob0-f169.google.com ([209.85.214.169]:54988 "EHLO
        mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012586AbaKDNkQoLgSB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Nov 2014 14:40:16 +0100
Received: by mail-ob0-f169.google.com with SMTP id va2so10934730obc.0
        for <linux-mips@linux-mips.org>; Tue, 04 Nov 2014 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=QSyIkFJqaVcltnUFBRCXkNzcJasIiB9Dur7j0cdEbNA=;
        b=oSAc9v+laxUNdCGPElctPlzv+ydcANpfuWUn/T5anwgNiV3ihrGzZBHVdgq9WQqusM
         n/MBjboj3HzJ7MXYbFnuiPNAQsEtlg3IRmpp7lB98qrQtxvjzA9Q0PfPWQgX1cDUkEXt
         ZfgBlX1cy1WSL7BMTXmU2TH2FHUrWAv5q22Ien9umzb6Xb4KtMP3yTxwz6+/3U2eQIyj
         veot64gAffpe+nr9QOIrfeAYPwwg5wm1JLbtxX05OVlek5hwEtyP/SByrrdeboVJCRFu
         b61etu5rjPW+f7f2zzjw0wx7qHFpdhl/uzD5SSM5TrJ46l7s8WeaQOLpZ6drOszDkli2
         ZxVw==
MIME-Version: 1.0
X-Received: by 10.182.120.10 with SMTP id ky10mr1653564obb.68.1415108410291;
 Tue, 04 Nov 2014 05:40:10 -0800 (PST)
Received: by 10.60.41.193 with HTTP; Tue, 4 Nov 2014 05:40:09 -0800 (PST)
Date:   Tue, 4 Nov 2014 21:40:09 +0800
Message-ID: <CAKcpw6WiuqJ5Cn4FNoYQEga8KBhZAZ4ohx35MqsdaOZDL6bABA@mail.gmail.com>
Subject: Problems of kernel of Loongson 3
From:   YunQiang Su <wzssyqa@gmail.com>
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     linux-mips@linux-mips.org, Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <wzssyqa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wzssyqa@gmail.com
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

I have tested the kernel 3.16, and 3.17 of Debian on loongson 3.
I met 2 major problems:

1. On the Lemote 6100 and Yeeloong 8133, load command hangs

 PMON> load (wd0,0)/vmlinux-3.16-3-loongson-3
 Loading file: (wd0,0)/vmlinux-3.16-3-loongson-3
 (elf64)
 0x80200000/9171584 + 0x80abf280/34201152(z)

 It also hangs on the dev board from Lemote.
 While it can boot on dev boards from Loongson.

 3.15 kernel works fine on both boards.

2. If without radeon non-free firmware in initrd/vmlinux,
 the screen can display nothing.
 It makes us difficult to patch debian-install to support Loongson 3.
 A automatic fallback may be needed when nonfree firmware is not available.

-- 
YunQiang Su
