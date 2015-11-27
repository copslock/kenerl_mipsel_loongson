Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 09:53:58 +0100 (CET)
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35570 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006607AbbK0Ix5IP0u5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Nov 2015 09:53:57 +0100
Received: by lfdl133 with SMTP id l133so121139280lfd.2
        for <linux-mips@linux-mips.org>; Fri, 27 Nov 2015 00:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:organization:date:message-id:user-agent
         :mime-version:content-type;
        bh=nJyXq/xHb59Vn9uWDCjschEBW4Mhz+OSC6PhJAZfXcw=;
        b=eOgEU/mLwtKrpL6woDfuxxsAMTPaiSK+5HFPmX5YOtI4iXvUOFty+UO/PSVmYbOHS9
         TMhxdDnW+SbntCnvA6iBvVU6DOqgK6K/zV59IOEl8Sb3es7T9+XyL53367YeexEd9VXR
         LCuN4kI7tqxuiLgkR5fcR4YMKdnWTFEeIomsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:organization:date:message-id
         :user-agent:mime-version:content-type;
        bh=nJyXq/xHb59Vn9uWDCjschEBW4Mhz+OSC6PhJAZfXcw=;
        b=LHboGODdmoo68m1q8js56nAsSZldvVsLAS02OFbXLbPa8zc9b7MSXrgD7AQr+fTzb9
         XQ8SvPTNBbavq52q5k+GDdfU+xP2T48gTlLy012dBHrbWEHxcV714aQwZXDsS9OSv9ak
         YhfjHRf5raHlHu/oJBQfvFZZGsnxJh5UMMxF/aAlXkpK2dRLmNo5ceMjW2abX4glyp4U
         VuK+cDKHwKIwIf6fHfhErMvDeJt+loMmnK/vFGWVMoBZy8RoiqDClNUL8OydDM4rNeOy
         0HzbaNqAj8ythgkVElXDdksOU8FoepQVJ2bEEIn1cHp0w3R63ChdqsyTZocIe1ks72hz
         c7rw==
X-Gm-Message-State: ALoCoQlbVcyWiVEbJfoaBU/+IJZbhrabHbNMdCFO22SoQ4M0rKwx+IjSqjrT1niJfe25OSmLXCj5
X-Received: by 10.112.185.71 with SMTP id fa7mr3252230lbc.99.1448614431700;
        Fri, 27 Nov 2015 00:53:51 -0800 (PST)
Received: from morgan.rasmusvillemoes.dk ([130.225.20.51])
        by smtp.gmail.com with ESMTPSA id d2sm4773500lbc.11.2015.11.27.00.53.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Nov 2015 00:53:51 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: no-op delay loops
Organization: D03
Date:   Fri, 27 Nov 2015 09:53:50 +0100
Message-ID: <87si3rbz6p.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <linux@rasmusvillemoes.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50142
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@rasmusvillemoes.dk
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

Hi,

It seems that gcc happily compiles

for (i = 0; i < 1000000000; ++i) ;

into simply

i = 1000000000;

(which is then usually eliminated as a dead store). At least at -O2, and
when i is not declared volatile. So it would seem that the loops at

arch/mips/pci/pci-rt2880.c:235
arch/mips/pmcs-msp71xx/msp_setup.c:80
arch/mips/sni/reset.c:35

actually don't do anything. (In the middle one, i is 'register', but
that doesn't change anything.) Is mips compiled with some special flags
that would make gcc actually emit code for the above?

Rasmus
