Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 09:29:24 +0200 (CEST)
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32938 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032223AbcEUH3XSpmhg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 09:29:23 +0200
Received: by mail-wm0-f68.google.com with SMTP id 67so2090916wmg.0
        for <linux-mips@linux-mips.org>; Sat, 21 May 2016 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=albanarts-com.20150623.gappssmtp.com; s=20150623;
        h=sender:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=4p4wRlZ/VxBDe1YT3kcppgdhbmiX/8CaxHlu/BENv8A=;
        b=C9K2Vo8YIbJQrD1WbalIj9HiZqrV2xMoSU0D6ZJE02sTkxs04OkwVhskhGIN7bfLR6
         Hqy/7hK8gOTJA1DKf1BFnapGpQzlSvVxfA+LiK1L7Umk7nfLBWpEc4H4M9jirK4wlud4
         y3CJt0hAggmIzW+XR1oxwzvMpemGl8Ss/ZedqYLvJQmq2srDEcspE+ecuee9LiGMpcAe
         RJsKBDsWezTRTKoYNOFobG4EZVjaQf8RoMKbTmdfDjxqxY4VKeYHDH6ZLVg2pUe9KVBB
         LD3GgCR9We0r58hnoY9PV2EM9/7tkZp3xD5YgPlwaoNtJS03VKt0U3Onbk/otpuEHdRy
         olwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=4p4wRlZ/VxBDe1YT3kcppgdhbmiX/8CaxHlu/BENv8A=;
        b=J/Kh2QNeRHfkaZZUNMeh9Plqo5KcVJaVe/aYLeER8jFsliOShk2h2bIeGOqoU1mFVM
         gJxAkvB3p3icB35GCvPdRXv1LkJzqAtoix5IvFzutBiewBwIP2GZN0PEbiEnIYv+0+n+
         atL5TaciouiPuM+dVgmq4zaRDICEKdznGQvJ3to5jBa5ibAehoQC39S/copbMoOEzuw5
         /9nZs/ywus86GPkuU5JDxHWs0t7GWSrMHv7hvhy3sTISzDzrBCoeF2l3rcZsnIOJNjt+
         2g0xlHgdeMBHdJ+ArZfzuxbja+Fpe/0pc/CHicQLLOYEbIDstNAhK1G02id17tWlVsIN
         nbSw==
X-Gm-Message-State: AOPr4FXWVFWkBfUzZ9pfF5bremGxtbOupeW8VVBfoltzLBlY/CCZ+9LXid/buIV+Vf93Nw==
X-Received: by 10.28.175.143 with SMTP id y137mr7119822wme.21.1463815757976;
        Sat, 21 May 2016 00:29:17 -0700 (PDT)
Received: from Unknown (jahogan.plus.com. [212.159.75.221])
        by smtp.gmail.com with ESMTPSA id f11sm1973599wmf.22.2016.05.21.00.29.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 May 2016 00:29:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1605210742260.6794@tp.orcam.me.uk>
References: <1463783321-24442-1-git-send-email-james.hogan@imgtec.com> <1463783321-24442-6-git-send-email-james.hogan@imgtec.com> <alpine.DEB.2.00.1605210742260.6794@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 5/5] MIPS: Simplify DSP instruction encoding macros
From:   James Hogan <james.hogan@imgtec.com>
Date:   Sat, 21 May 2016 08:29:16 +0100
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Message-ID: <7CA8BFBF-73A8-4699-975E-79BDC383C2E4@imgtec.com>
Return-Path: <james@albanarts.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 21 May 2016 08:11:35 BST, "Maciej W. Rozycki" <macro@imgtec.com> wrote:
>On Fri, 20 May 2016, James Hogan wrote:
>
>> To me this makes it easier to read since it is much shorter, but it
>also
>> ensures .insn is used, preventing objdump disassembling the microMIPS
>> code as normal MIPS.
>
>More importantly the use of `.insn' prevents execution from going
>astray 
>if there's a label being jumped to at the handcoded instruction.

Right. in my builds i couldn't find any examples of this happening, only relative branches (the only diff when adding .insn seemed to be objdump -d printing as microMIPS, but tbh i didn't compare data sections), but perhaps it could still happen with a different configuration or toolchain?

Grepping the disassembly though i did find various other cases of MIPS disassembly amongst microMIPS that i have yet to identify.

thanks
James
