Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Mar 2015 15:57:45 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:58210 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008352AbbCPO5oOG9pa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Mar 2015 15:57:44 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 484CE460635
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 14:57:39 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EMOqZL+xd7vT for <linux-mips@linux-mips.org>;
        Mon, 16 Mar 2015 14:57:36 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id CCC864608C3
        for <linux-mips@linux-mips.org>; Mon, 16 Mar 2015 14:57:36 +0000 (GMT)
Received: from localhost ([::1] helo=paulmartin.codethink.co.uk)
        by pm-laptop.codethink.co.uk with esmtp (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YXWSW-0001x9-Dz
        for linux-mips@linux-mips.org; Mon, 16 Mar 2015 14:57:36 +0000
Date:   Mon, 16 Mar 2015 14:57:36 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/6] MIPS: OCTEON: Patches to enable Little Endian
Message-ID: <20150316145735.GB28205@paulmartin.codethink.co.uk>
Mail-Followup-To: linux-mips@linux-mips.org
References: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
 <20150313185258.GJ587@fuloong-minipc.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150313185258.GJ587@fuloong-minipc.musicnaut.iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

On Fri, Mar 13, 2015 at 08:52:58PM +0200, Aaro Koskinen wrote:
> Which drivers did you test? Did you test e.g. octeon-md5?

octeon-md5 does fail.  The hardware seems to be expecting big-endian
values.  I have got it to work by doing this:

https://github.com/nowster/linux-ubnt-e200/commit/019411e18e943624aa61796e54aa933397f8fdca?diff=unified

(I know that cut-and-paste will destroy the tabs in this.  I provide
the patch for comments as to whether this approach is sane.)

diff --git a/arch/mips/cavium-octeon/crypto/octeon-crypto.h b/arch/mips/cavium-octeon/crypto/octeon-crypto.h
index e2a4aec..0e157f1 100644
--- a/arch/mips/cavium-octeon/crypto/octeon-crypto.h
+++ b/arch/mips/cavium-octeon/crypto/octeon-crypto.h
@@ -32,7 +32,7 @@ do {                                                  \
        __asm__ __volatile__ (                          \
        "dmtc2 %[rt],0x0048+" STR(index)                \
        :                                               \
-       : [rt] "d" (value));                            \
+       : [rt] "d" (cpu_to_be64(value)));               \
 } while (0)

 /*
@@ -47,7 +47,7 @@ do {                                                  \
        : [rt] "=d" (__value)                           \
        : );                                            \
                                                        \
-       __value;                                        \
+       be64_to_cpu(__value);                           \
 })

 /*
@@ -58,7 +58,7 @@ do {                                                  \
        __asm__ __volatile__ (                          \
        "dmtc2 %[rt],0x0040+" STR(index)                \
        :                                               \
-       : [rt] "d" (value));                            \
+       : [rt] "d" (cpu_to_be64(value)));               \
 } while (0)

 /*
@@ -69,7 +69,7 @@ do {                                                  \
        __asm__ __volatile__ (                          \
        "dmtc2 %[rt],0x4047"                            \
        :                                               \
-       : [rt] "d" (value));                            \
+       : [rt] "d" (cpu_to_be64(value)));               \
 } while (0)

 #endif /* __LINUX_OCTEON_CRYPTO_H */



-- 
Paul Martin                                  http://www.codethink.co.uk/
Senior Software Developer, Codethink Ltd.
