Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Nov 2017 05:42:02 +0100 (CET)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:52692
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990413AbdKFElzmAdnZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Nov 2017 05:41:55 +0100
Received: by mail-it0-x244.google.com with SMTP id j140so3654060itj.1;
        Sun, 05 Nov 2017 20:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DrrjqGab+p4p/FVaQN+02YsQ1AGTo9kzaE3whHe+wEc=;
        b=UPsTN//Yb6yq/oUPnaY2nw1x9s7hnk7ijwGCjpe3+Byhlgwv7KoxwDFg1+UWpEGSWF
         Uczm77DmPAmeOnnnWAgDSgwUY8fe4JNKw817sffpv5HIFTpVMzaWbR/sT5vIPeY8da6L
         e0PBhjek01KByrPjp1mMuv8CCh41II6gCLOIxsMg7fb4LjRapIc7HASufGQHBSs5oTIB
         F4QoGmXKxAfJ6ZlceH4vaS7n0TFsD1P6I76t/ENXa1FEHQCGvPCeAtSH830w9m0S8uUv
         vXCVqIVzJrlPrtS13WjDgzFqN6YyVYJ8DK2NzbdVQiqtePrdd6II3W5pMIUpmx0JbqSx
         LUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DrrjqGab+p4p/FVaQN+02YsQ1AGTo9kzaE3whHe+wEc=;
        b=pppRdTEXWtSvHkW6tmhHRjrHlRnZEU0ur0nQnyYW9LSGyM/+NaE5X/J933cANx961V
         ydtek1FJ8Ad9ol3ukiNxi860MnGTnnwcck2Q0dEiJtfjssS27hY48uqVNWpEVbkajSDL
         FSn8hSydaLGNumYDUBf2UmdJUbz3TzHUr3fOxIxXy4RdrSJqMh0FSVvs4no6SBsEn6au
         o3JKCjdH9ibwo55QHNG2RTR85VSiT10eNzykGty6tHhegJearK4AzsCvQmeL1EapCycM
         kzVn9dp2zIroCx+BeyI4Wt0GbygZFxgmg/3ncLz3nrGzuVCQzMvxq31NQK+eSBVVnh55
         oVpw==
X-Gm-Message-State: AJaThX6v22wtrwAAnwnvZIvSWAk4r1VhOHdhFpvyultNAnH7lhUGTH/i
        rezGokE0c5Str9ZmsldW+u44LybgO3vfPOMA9IU=
X-Google-Smtp-Source: ABhQp+T44DrImEHq/FXdlTTpc6rpZryNvUXFi1XYwsE1ZgUbRt1uBR99h7ulAloNN1yvs8Me4h7ktvzprm+gvooERyw=
X-Received: by 10.36.210.198 with SMTP id z189mr7774958itf.65.1509943309418;
 Sun, 05 Nov 2017 20:41:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.56.67 with HTTP; Sun, 5 Nov 2017 20:41:48 -0800 (PST)
In-Reply-To: <1509571159-4405-22-git-send-email-w@1wt.eu>
References: <1509571159-4405-1-git-send-email-w@1wt.eu> <1509571159-4405-22-git-send-email-w@1wt.eu>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 6 Nov 2017 12:41:48 +0800
Message-ID: <CAAhV-H6aqeSga3bx9SDDXW23KTi=YWHwKCaXoD-kWUYg9JCyzA@mail.gmail.com>
Subject: Re: [PATCH 3.10 021/139] MIPS: Send SIGILL for BPOSGE32 in `__compute_return_epc_for_insn'
To:     Willy Tarreau <w@1wt.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Hi, Willy,

Does these two patches really needed for 3.10? They are marked for 4.4 and 4.6.

ext4: avoid deadlock when expanding inode size

ext4: in ext4_seek_{hole,data}, return -ENXIO for negative offsets



Huacai
