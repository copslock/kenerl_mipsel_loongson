Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Aug 2010 11:46:14 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:48848 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491114Ab0H3JqK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Aug 2010 11:46:10 +0200
Received: by bwz13 with SMTP id 13so4421164bwz.36
        for <linux-mips@linux-mips.org>; Mon, 30 Aug 2010 02:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=ynTkDMnu4gmdZwb9q8sUhXTV7geg8gTw8gLWQFK3cl4=;
        b=Dn76fAhOLUN4jAbJAd7f8xDMabvryq88o217egwVflBD+6Wk6tZlm66vSJi70t4hO/
         /zXpAa4loZLVzG3TKWuXCSNIIU5hGw3KgKvNeXaqG+Pzx6+kTlFIvfaemSJuPMtek+vf
         Ep2NbkHqE30s0Wu/RhqmXlf/5upjpCdo0RRgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=OV7PztkhcWpfQLuCzHJOVA3I3SnZdojmBYtlAaOY19bnwcKKvP6yecJYpCach6J79X
         ELvmRo2zfKYKB1HS9OQvQggc07HCqnSEogBzkxfQjDRing5U6sDUrK2lYQGCNq+kO1sO
         Pub/oiElVvz521p2Cu8IyWPKFgeF69G2DdssI=
Received: by 10.204.82.200 with SMTP id c8mr3039080bkl.102.1283161570443;
        Mon, 30 Aug 2010 02:46:10 -0700 (PDT)
Received: from [192.168.102.9] (DSL01.212.114.252.242.ip-pool.NEFkom.net [212.114.252.242])
        by mx.google.com with ESMTPS id g12sm5059013bkb.2.2010.08.30.02.46.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 02:46:09 -0700 (PDT)
Message-ID: <4C7B7DE0.9020800@googlemail.com>
Date:   Mon, 30 Aug 2010 11:46:08 +0200
From:   =?ISO-8859-15?Q?Andreas_Bie=DFmann?= <andreas.devel@googlemail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100805 Lightning/1.0b1 Icedove/3.0.6
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: broken eglibc
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Return-Path: <andreas.devel@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.devel@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi all,

we have a problem building eglibc-2.12 (svn 11187) with current (some
days old) head 2.6.35.3 (stable tree). Same sources for eglibc but
sysroot headers from 2.6.35-rc3 does work fine.
The problem shows up when using the built libc on target. We use n32
built and start a homebrew rootfs. The broken libc has (at least) errors
in showing directory listings. A ls shows wired output:

---8<---
/ # ls
ls: ./sr: No such file or directory
ls: ./ar: No such file or directory
ls: ./ib: No such file or directory
ls: ./oot: No such file or directory
ls: ./tc: No such file or directory
ls: ./inuxrc: No such file or directory
ls: ./ib32: No such file or directory
ls: ./ev: No such file or directory
ls: ./nit: No such file or directory
ls: ./nt: No such file or directory
ls: ./mp: No such file or directory
ls: ./in: No such file or directory
ls: ./ys: No such file or directory
ls: ./roc: No such file or directory
bin
--->8---

As you may see the first character is truncated. Only changing the
contents of /lib32 directory (libc related stuff) with working built
(sysroot include out of 2.6.35-rc3 kernel headers) the 'ls' is working.

Has anyone encountered similar behaviour?

regards

Andreas Bieﬂmann
