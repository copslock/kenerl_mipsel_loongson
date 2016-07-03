Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jul 2016 15:17:54 +0200 (CEST)
Received: from mail-it0-f53.google.com ([209.85.214.53]:36217 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992478AbcGCNRrjLO0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jul 2016 15:17:47 +0200
Received: by mail-it0-f53.google.com with SMTP id g4so4317003ith.1;
        Sun, 03 Jul 2016 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jnuSCwkjTBvBKySixLS++YKPko5CCOZlii/TAYzafLg=;
        b=J3f+Jx/Pa/cweRkkpLmQao7LOgrSxuBQXikQK1UVwEXrWC9b9Pr+YoKATyZBKNeq+K
         h6Gg8Cu6VUzefUmhv8cHUguRqAXAEqVV3sojm57jQwbit8OEGQf6u1496FPIesIDJ5hD
         MN7D2Dcn/H/XKc6LRk7BITvThTePcda2aQsUKwQ3yK67yzrM47/4HleR9/M49pnBG4Zb
         ApaY40beJjPOqJFHhbJILS8Nt6BCuGL3UdZtCzvbzLVJ34th4Momni/sPhc5iRTF5Ydf
         vVkEQIkiBu1UXOo+zlIXSqcSN/43goFn7cDeqn8ngwdDeyL1oBxkSuHXofryE5IPZ8Ah
         FgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jnuSCwkjTBvBKySixLS++YKPko5CCOZlii/TAYzafLg=;
        b=Sc/gq7oHykJU3aIU4WUuPOcPP4jK0ciGuNraaRIF4yiC02fHiq6f00cR8GNQexVRx7
         ohZFrpj9JTGcXMutFZPs6abjMFrm6XX6ecpJfLY1xpHvxlIaVrmO/9ZIAzWOzLAvyZ+4
         Yu6faKWJwOHRAVRgbGcR4WNQV5vOVwOPu/37F8W7zuq8UmsY1azFdyB07KxRqcMvbfdJ
         ImLylUCccH7HVFsaIuemlaZGqc1Zke0mhJf/4oJzoN2W6ULrhhJCtvqp2+WmTctsN3fy
         wxhzDctyminSHZj2oFYInxrbSqpKf1yTkauAmvlwjtZANIdNIshptMWdpkV1/hLe5g3a
         M0pA==
X-Gm-Message-State: ALyK8tJhB69U4he2c+JFHdOEV3TjKLybEW30If6xMaRl5K/uRW1wnlawyP9kLQ0/Kxz0+qSbPTCC1QHfrOM76g==
X-Received: by 10.36.33.208 with SMTP id e199mr5714206ita.41.1467551859897;
 Sun, 03 Jul 2016 06:17:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.168.168 with HTTP; Sun, 3 Jul 2016 06:17:39 -0700 (PDT)
In-Reply-To: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com>
References: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sun, 3 Jul 2016 18:47:39 +0530
Message-ID: <CANc+2y5uU+9x7Sppa4avjU53_ncxpJ2VpA8DKvj0z6W8CmUJ5A@mail.gmail.com>
Subject: Re: [RFC] mips: Add MXU context switching support
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        John Stultz <john.stultz@linaro.org>, mguzik@redhat.com,
        athorlton@sgi.com, mhocko@suse.com, ebiederm@xmission.com,
        gorcunov@openvz.org, luto@kernel.org, cl@linux.com,
        serge.hallyn@ubuntu.com, Kees Cook <keescook@chromium.org>,
        jslaby@suse.cz, akpm@linux-foundation.org, macro@imgtec.com,
        Florian Fainelli <f.fainelli@gmail.com>, mingo@kernel.org,
        alex.smith@imgtec.com, markos.chandras@imgtec.com,
        Leonid.Yegoshin@imgtec.com, david.daney@cavium.com,
        zhaoxiu.zeng@gmail.com, chenhc@lemote.com,
        Zubair.Kakakhel@imgtec.com, james.hogan@imgtec.com,
        Paul Burton <paul.burton@imgtec.com>, ralf@linux-mips.org,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Will be great if someone could review this. Thanks in advance.
