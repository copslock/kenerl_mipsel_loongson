Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2017 03:23:35 +0200 (CEST)
Received: from mail-pg0-x235.google.com ([IPv6:2607:f8b0:400e:c05::235]:43791
        "EHLO mail-pg0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992540AbdJSBX259pJM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Oct 2017 03:23:28 +0200
Received: by mail-pg0-x235.google.com with SMTP id s75so5732001pgs.0;
        Wed, 18 Oct 2017 18:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=FFAw8mQFsN4dr9eI4jqhgaWKJAPtLeFvtiDIpNq3ZXk=;
        b=mumJ2mvbHxc1dMslBseZf9311GQtlRJmHO6nUpZTfuq2xAOSehBLqGGVZ3d1IFSTP8
         qoHqgKt+sCjLtaeRl3cSX0e+ZrSRm6HEw1BiWNBCPNFo5JV9tfWOUlIXDcda1izZViOi
         IdRGooV/PlDxjlfz+Zk0p2KVhGbstlGsZwHDhSmNEI1hrLdXQhoIafrL7PGsIkktfir6
         TttdHlq0VhRyQfW580/GG8XPjBjaKRidiOG61+47BrNJIXO8oFnIm41gGja054eu/5VY
         TrUwkDN+aMl0XwJp4I9o1bvZXwc74eW7yp9KsZVcebt2tTZw0kBeqcaWH8IJkrmyoz/+
         Yp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=FFAw8mQFsN4dr9eI4jqhgaWKJAPtLeFvtiDIpNq3ZXk=;
        b=m6sCDsKFdn/y9YTCRZoEPVKd8dlevYB/YMH1vTEBnyVZw2zO2/p64SsoY+ov8YYpY+
         DExZb6k6I1j/i/Tqa8ypb75uQilVOH/2+rTMnUxazyILTjTlKXxjhEpNWH3gx+VLWo0a
         Xm6y2tujhoYx3YT79BdW88TzeVakX6raizD+r+oM1B+J/ojkUUJfZN8DED3w84TC/lNg
         1DE4dIcPR9q+huwaVjlm0y7sJcbQ2Ui+6RvxkwlsAgCHiNZ9sBP7UyIFp0vmNIxme2fY
         /xZCjHvJvsOKnlEMZDjpgqktMyTbktulF4PvXKu0CiN5osMHEImUj4/h8zCCDLlEhSRr
         TN1w==
X-Gm-Message-State: AMCzsaXBQjeKWDkXvi/zMa2wqwK4stmdT1n8gyudKe48CpJMYj/yoKTi
        VmPSyXot6PrdgKmhlnip/VpAcCdz
X-Google-Smtp-Source: AOwi7QDw0TWdux/J5dsGYfFk6yp94mLnj2QUX/N+poOjVlcWFThyXce3/VgrFhJThUXUmcueJtIN1w==
X-Received: by 10.99.165.17 with SMTP id n17mr14591033pgf.405.1508376201082;
        Wed, 18 Oct 2017 18:23:21 -0700 (PDT)
Received: from [192.168.10.2] (99-74-168-106.lightspeed.sntcca.sbcglobal.net. [99.74.168.106])
        by smtp.gmail.com with ESMTPSA id d190sm21318716pgc.53.2017.10.18.18.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Oct 2017 18:23:20 -0700 (PDT)
From:   Xuebing Wang <xbing6@gmail.com>
To:     linux-mips@linux-mips.org, openwrt-devel@lists.openwrt.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [linux-usb] [openwrt] Does KGDB work on MIPS32 24kc (Atheros AR9331
 chip)?
Message-ID: <aa824bef-9aa7-c225-4238-04881e1280f8@gmail.com>
Date:   Thu, 19 Oct 2017 09:23:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <xbing6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xbing6@gmail.com
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

Hi community,

When I try KGDB (with kgdboc), and 'echo g > /proc/sysrq-trigger' to 
trigger kgdb, I got below error:
------
CPU 0 Unable to handle kernel paging request at virtual address 
00000000, epc == 00000000, ra == 80223f38
KGDB: re-enter exception: ALL breakpoints killed
(This causes a kernel panic)
------

My setup is:
-  Atheros AR9331 chip, which is MIPS32 24kc
-  OpenWRT tag 15.05
-  Linux kernel v3.18.29

The issue seems with inline assembly?
void arch_kgdb_breakpoint(void)
{
     __asm__ __volatile__(
         ".globl breakinst\n\t"
         ".set\tnoreorder\n\t"
         "nop\n"
         "breakinst:\tbreak\n\t"
         "nop\n\t"
         ".set\treorder");
}

There seems a fundamental question about OpenWRT linux kernel?
-  In file OpenWRT file target/linux/ar71xx/Makefile, there is CPU_TYPE=34kc
-  Atheros AR9331 datasheet says it is 24kc (rather than 34kc)
-  With CPU_TYPE=34kc, it uses gcc options "-mips32r2 -mtune=34kc"

Quotes from mips website: https://www.imgtec.com/mips/classic/
------
MIPS32 34Kc/f
The MIPS32 34K is a 9-stage pipeline multi-threaded processor core with 
support for up to two Virtual Processing Elements (VPE) and nine Thread 
Context (TC)s per VPE.
MIPS32 24K
The MIPS32 24K is a 8-stage pipeline processor core that implements the 
MIPS32 Release 2 Architecture,
------

Does KGDB work on MIPS32 24kc (Atheros AR9331 chip)? Thanks.

Xuebing Wang
