Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Mar 2014 09:46:59 +0100 (CET)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35611 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823060AbaCKIqxph4WN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Mar 2014 09:46:53 +0100
Received: by mail-pd0-f169.google.com with SMTP id fp1so8293381pdb.0
        for <multiple recipients>; Tue, 11 Mar 2014 01:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=If55j25gdereD/prH3lMcnQpjyf69nofs5tPMSkDgoo=;
        b=ddCdLW/qj/o5FEAMQ6GhHMVpLHWeSVENSKYjX/Flbco+T+ReU0EuFl80ZxBNBVfFPV
         RfW7d4zuklauXHve8tbPs37EvGHamXVFklnRFpYhQDyg399TBoO/0eCVQm51jYC9xY1v
         iitkvzWrIJvk2cMiQiXGL0OpboJR7B9+tQ9rT9r9Ww1pkwdr1lltcI0uM+si0jZetqBS
         L6rfQjx/ES3ZLFLMXom/PwgY71vU79T37VJAknRSVLr5XTyuo8FzN3P6v4lRffrAoYy5
         bBEsu0NrHi02uSyDvxsm9Ivb2n4ikxjtGLHEVs1wuuEFepAFH8+iWhveqxFurUZ1MVAN
         x6Tw==
MIME-Version: 1.0
X-Received: by 10.68.136.133 with SMTP id qa5mr46088066pbb.63.1394527603412;
 Tue, 11 Mar 2014 01:46:43 -0700 (PDT)
Received: by 10.70.28.195 with HTTP; Tue, 11 Mar 2014 01:46:43 -0700 (PDT)
Date:   Tue, 11 Mar 2014 09:46:43 +0100
X-Google-Sender-Auth: cwHGwTgSYvNDcrQ6w2l3DYTvCRs
Message-ID: <CAMuHMdVspeUUMCfiuf4g5iQ6uryZMKLqsR9WLHQ6=GygTtv9-Q@mail.gmail.com>
Subject: [-next] error: 'PRID_IMP_M5150' undeclared (first use in this function)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-Next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

Hi Ralf,

http://kisskb.ellerman.id.au/kisskb/buildresult/10701849/
arch/mips/kernel/cpu-probe.c:856:7: error: 'PRID_IMP_M5150' undeclared
(first use in this function)
arch/mips/kernel/cpu-probe.c:857:16: error: 'CPU_M5150' undeclared
(first use in this function)

Apparently you've applied on patch [3/3] of the series, and forgot the 2
prerequisites?

https://patchwork.linux-mips.org/patch/6595/
https://patchwork.linux-mips.org/patch/6596/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
