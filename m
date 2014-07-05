Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2014 04:59:33 +0200 (CEST)
Received: from mail-ve0-f169.google.com ([209.85.128.169]:56718 "EHLO
        mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818711AbaGEC7a3y6xU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jul 2014 04:59:30 +0200
Received: by mail-ve0-f169.google.com with SMTP id pa12so2254987veb.28
        for <multiple recipients>; Fri, 04 Jul 2014 19:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=gHtKPyZKIJ0Y1A6gKx/RV37iYzXCfcw5zQRLkgintOg=;
        b=STnIaHc7m7M7+Bm2gAb3kMtPgih4tEKLSJfBSYAfsILws7Lqkf7pDCVhJKPBWBEtE6
         oq94kVQUT3uyQcWrPyBHBSulA6gIt3787p+YFM9Pm8XtkNWyAQQ+7Zd1KiT2rJQdrjOs
         c3NRxOd2O+k5dA3WL+L3D9SufGWKRn8W+9lLjIUdLgrUUSyAIAMrdkoQtFpFEyq+LsY3
         XviPyN7c4rhHTWjQcUwgENOciVlTKsnGsBGz0MUMYATiffMops++qX2xMbZj8Ce8I96W
         gW67g+OH5wknFH5skY8PpXCTRs3BGfEWQT+3yZjo2ZxjNVI+3Tz1Z9MQJHikPxyHtqp/
         l+vA==
MIME-Version: 1.0
X-Received: by 10.52.69.172 with SMTP id f12mr10794820vdu.26.1404529164158;
 Fri, 04 Jul 2014 19:59:24 -0700 (PDT)
Received: by 10.221.53.5 with HTTP; Fri, 4 Jul 2014 19:59:24 -0700 (PDT)
Date:   Fri, 4 Jul 2014 22:59:24 -0400
Message-ID: <CAPDOMVj-++wOH38d4setvfGFdsaMkn8Rzo4-3YajgGkV2A-aug@mail.gmail.com>
Subject: mips: FIX ME message in smp_cmp.c
From:   Nick Krause <xerofoify@gmail.com>
To:     ralf@linux-mips.org
Cc:     paul.burton@imgtec.com, markos.chandras@imgtec.com,
        Leonid.Yegoshin@imgtec.com, Steven.Hill@imgtec.com,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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

I am wondering if in this file, arch/mips/kernel/smp-cmp.c the fix me
message in cmp_smp_finish I can remove the line that the fix me
message states below it or
is this part of the function still needed.
Cheers Nick
