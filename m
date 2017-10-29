Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Oct 2017 16:27:52 +0100 (CET)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:52411
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992036AbdJ2P1qKY6e7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Oct 2017 16:27:46 +0100
Received: by mail-wm0-x242.google.com with SMTP id t139so11739732wmt.1;
        Sun, 29 Oct 2017 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vEZcvr4wDLQxs9dh7xn4+/KXvTaHtZOMr9eJ1pGTwGI=;
        b=byUks6Cmc1UQpeCBM4PG8mSfxe9zzksSc20uxqowdPYZaSZ0o+MFqlCakn5sSclQ0O
         FjXGk4bUzRjulhNoCVOmezQ/AnB/e7C3RjTGZeoIz6cBrVqXS8VK4QQaYR7xMVqZsbzm
         SCPX5gk+/MUH4Licrt/nQ+h4hDvZ6uY05XtKUmVXwTYqXNyylA5WSkDEVMTupylBEW/Y
         9pnWFNeRIq/mg+FLYRQM9NZ0HLcZh1DzaimudCg+DOyCxKyxEVaYBR5yC/EAsktwwXzK
         MtVqx/I9wmtPqQm9MKWTWzZM5O3AN+HOi6tfvkZYi2MAJFZS1yNR3EK1UGvblFmCjuh7
         lr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vEZcvr4wDLQxs9dh7xn4+/KXvTaHtZOMr9eJ1pGTwGI=;
        b=Dj+YWhWOY0hNuRwETMdklvg6BY80+hsVNbCTXOXrkCMPXZFl8SU/Ts21tbR5Ta9rbp
         Vo+2SSVEQAlPS1XllkuuYb59zYIHU9llO3iA/joZi6jrLW1SF0ocHDmLl7Fe8o8lL99T
         b1IY+T8Nz3H1CTOpfZC3CEsemw5WLuPkZ3Kk1xF7W4DKZdMITUZcb1Yw2zv5+cjlB2ik
         mZWlkGCcHW0nqXcNyfVpch0A14Xz0hC4CoV0WDQU8Noikw/Bim5M6rK3WSpWR/p3LpBc
         rMhrRbdmQvGDD7yaYNVMvAxe51KbqqIBhWw9wX9Za0yKDs6Mw8RElAawpvXUvxeH1/WY
         KDdw==
X-Gm-Message-State: AMCzsaWya4YO1n8Uw4FcXAVbMCtAa1xcmIuilDxqHZcYYu89+Nc4usOj
        S3I6FVcJjXgopOeG39wX6X6ASA==
X-Google-Smtp-Source: ABhQp+Twsaxfi6KB2K728Dw15txufZiZzDVHeN8QC9E9fB+lX7I7Ftw38UA7wJiB4M5W7LxexPFnfA==
X-Received: by 10.28.197.65 with SMTP id v62mr1504108wmf.9.1509290860597;
        Sun, 29 Oct 2017 08:27:40 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id m26sm12498532wrb.81.2017.10.29.08.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Oct 2017 08:27:40 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: [PATCH 0/3] MIPS: AR7: assorted fixes
Date:   Sun, 29 Oct 2017 16:27:18 +0100
Message-Id: <20171029152721.6770-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60576
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

This patchset fixes a few issues found in AR7 that accumulated in the
past few years. One was fixed for ages in OpenWrt/LEDE and never made
it upstream, the others weren't noticed until now.

Jonas Gorski (2):
  MIPS: AR7: defer registration of GPIO
  MIPS: AR7: ensure the port type's FCR value is used

Oswald Buddenhagen (1):
  MIPS: AR7: ensure that serial ports are properly set up

 arch/mips/ar7/platform.c | 5 +++++
 arch/mips/ar7/prom.c     | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.13.2
