Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jun 2011 19:00:58 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:42644 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491835Ab1FARAx convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Jun 2011 19:00:53 +0200
Received: by fxm14 with SMTP id 14so271842fxm.36
        for <multiple recipients>; Wed, 01 Jun 2011 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KpPEf4LLr9n8sDDxoaiv5s6pKcWw3mocvYJd39gSYcs=;
        b=qTHYqlfs/NHw3B2/Tna+w+EPozkPp59n+cW1jr4Vc9IO+DB5jRM1D1Zfk29PGNt3r6
         +bIQRMaKhLM0eyr2PNcfYcM+zZ8Tj5MFhn0V05b69T5CKjsn2swomtzGRs1MSYPEDy7J
         pO5GPrw7DabUXJ9+CVRtw5Aguj1ACDtUM2+YQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=otTydPVSSge4X4RPr279iPjuC8gex/ObSJDnJzzqIiMvQE3szWiAeTkBIL8E/0oDxN
         WshBkkNurbbiRrDrkQBLPLiRLmLLqlL9D7sxpAESGbkyYBylRS7LawMEH5djpouT4AmP
         ntZ5L0Fp0GJ9jVdfumAFPATnHHEKY5plOReQA=
Received: by 10.223.1.209 with SMTP id 17mr5387359fag.89.1306947648106; Wed,
 01 Jun 2011 10:00:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.149.133 with HTTP; Wed, 1 Jun 2011 10:00:28 -0700 (PDT)
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
From:   Mike Frysinger <vapier@gentoo.org>
Date:   Wed, 1 Jun 2011 13:00:28 -0400
X-Google-Sender-Auth: EdDBFDhUtmES1ioY6e6-8QVrqfY
Message-ID: <BANLkTinEc8OLHnkVCZVpHK4ZnC1DHbEsvw@mail.gmail.com>
Subject: Re: [PATCH] Fix build warning of the defconfigs
To:     Wanlong Gao <wanlong.gao@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        uclinux-dist-devel@blackfin.uclinux.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux@arm.linux.org.uk, hans-christian.egtvedt@atmel.com,
        ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org,
        lethal@linux-sh.org, gxt@mprc.pku.edu.cn,
        david.woodhouse@intel.com, akpm@linux-foundation.org,
        u.kleine-koenig@pengutronix.de, mingo@elte.hu, rientjes@google.com,
        w.sang@pengutronix.de, sam@ravnborg.org,
        manuel.lauss@googlemail.com, anton@samba.org, arnd@arndb.de
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier@gentoo.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 970

On Wed, Jun 1, 2011 at 12:29, Wanlong Gao wrote:
>  arch/blackfin/configs/CM-BF548_defconfig   |    2 +-

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
