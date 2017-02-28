Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2017 14:55:55 +0100 (CET)
Received: from mail-ot0-x230.google.com ([IPv6:2607:f8b0:4003:c0f::230]:35525
        "EHLO mail-ot0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbdB1Nzst5Jbs convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Feb 2017 14:55:48 +0100
Received: by mail-ot0-x230.google.com with SMTP id w44so7988003otw.2;
        Tue, 28 Feb 2017 05:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=B+M+OjzQpJgeoj4uNUvnX1qG5ys2nLsMnByQSRZwzD0=;
        b=oacuM2fq4ktPwlaYKBvfLxYyR8UmWXNdqJdkvs4s6Qwf8T47PpyBhABvZkaGypcMaY
         vlCoeje92onxfCWRuleuZAigygL0Fqic9KzG2pNIaigsMerCKMGBedUFzC70NrPKFyAz
         1eH7BAkATWqNAHi9OMoFI5EyLilZejTFCdw30U22RdI/N/Y+cMgv6TT5BS9WBhqJqj9E
         gKB09xCxWlf/JRC/7QzmbosY6BhdbRZXVt70yJXCgT1/gkHecc4YJzqJxNdpQoETLiT5
         m/5BTbmnY3gPmhg1dq5ejPdybxQfCwyE35DyLb+LA2RB1p5GJd/nX1+4b8f4KI9QO+Qh
         MwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=B+M+OjzQpJgeoj4uNUvnX1qG5ys2nLsMnByQSRZwzD0=;
        b=UlybceJWG9SYaEB3onmWhDh73tw1PhpTgQe1G7w+w4k6O3E5EZKvEeUlNU0bMrbJMT
         SbIoqfc+67cnOPuWPsmIVE8FoE7LUEw9e/GrqjgOq9cyiwekmWMV2TOurrszW88rQtga
         I1JQdw1ruw/ftiWMgc4gZ57Px07CTsNIBWQacGYYwLCV7cGg68UAm73DocugU3DlfPs9
         vUWYHLX1ZgGtxg0LUk40C0tai3n+IbBUEDhyOFn1Eakwxu8tSNn68hy5EjgR/dPMDuy0
         XwZbO5H0DkMqtWO0u2zwYnxXlhbecdyqx6IdnTDQvUnDAUR5FdizjVFX7UOnk3ieFR/D
         U2mg==
X-Gm-Message-State: AMke39n3v2bp9qfzcJQRafDz6G5nTFIEp/vNi0vhk5bgu7R0BGtgV7Z7cnOf3sGIthbyZ6Jgwt9SqQTvjXE64Q==
X-Received: by 10.157.0.42 with SMTP id 39mr1455010ota.41.1488290142537; Tue,
 28 Feb 2017 05:55:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.6.42 with HTTP; Tue, 28 Feb 2017 05:55:42 -0800 (PST)
In-Reply-To: <58b2e1b1.16502e0a.696c.aa4e@mx.google.com>
References: <58b2e1b1.16502e0a.696c.aa4e@mx.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Feb 2017 14:55:42 +0100
X-Google-Sender-Auth: KyKYlUH1h5uTSt4YJdGw_LfGGZk
Message-ID: <CAK8P3a2YDcM3t2aJHNEv8C6EFN2P4hN1hKsqJ8K--_XEC12b5A@mail.gmail.com>
Subject: Re: stable build: 199 builds: 1 failed, 198 passed, 1 error, 31
 warnings (v4.4.52)
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     kernel-build-reports@lists.linaro.org,
        "kernelci.org bot" <bot@kernelci.org>, stable@vger.kernel.org,
        linux-mips@linux-mips.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Sun, Feb 26, 2017 at 3:09 PM, kernelci.org bot <bot@kernelci.org> wrote:
> stable build: 199 builds: 1 failed, 198 passed, 1 error, 31 warnings

A few additional patches are missing here, besides the ones I have
listed for 4.9 and v4.10

> Warnings:
> drivers/net/ethernet/ti/cpmac.c:1240:2: warning: #warning FIXME: unhardcode
> gpio&reset bits [-Wcpp]

d43e6fb4ac4a ("cpmac: remove hopeless #warning")

> ci20_defconfig (mips) — PASS, 0 errors, 1 warning, 0 section mismatches
>
> Warnings:
> mm/memcontrol.c:4153:27: warning: 'mem_cgroup_id_get_online' defined but not
> used [-Wunused-function]

358c07fcc3b6 ("mm: memcontrol: avoid unused function warning")

> decstation_defconfig (mips) — PASS, 0 errors, 3 warnings, 0 section
> mismatches
>
> Warnings:
> arch/mips/dec/int-handler.S:149: Warning: macro instruction expanded into
> multiple instructions in a branch delay slot
> arch/mips/dec/int-handler.S:198: Warning: macro instruction expanded into
> multiple instructions in a branch delay slot

3021773c7c3e ("MIPS: DEC: Avoid la pseudo-instruction in delay slots")

> nlm_xlp_defconfig (mips) — PASS, 0 errors, 4 warnings, 0 section mismatches
>
> Warnings:
> arch/mips/netlogic/common/reset.S:53:0: warning: "CP0_EBASE" redefined
> arch/mips/netlogic/common/smpboot.S:51:0: warning: "CP0_EBASE" redefined

32eb6e8bee14 ("MIPS: Netlogic: Fix CP0_EBASE redefinition warnings")

        Arnd
