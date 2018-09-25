Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2018 20:08:52 +0200 (CEST)
Received: from mail-wr1-x441.google.com ([IPv6:2a00:1450:4864:20::441]:45119
        "EHLO mail-wr1-x441.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993094AbeIYSItOqkVH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Sep 2018 20:08:49 +0200
Received: by mail-wr1-x441.google.com with SMTP id m16so7840500wrx.12;
        Tue, 25 Sep 2018 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CI0hLS/bvI0Hqo/pfglI7FYYUsJ/cwY74alonubtd24=;
        b=auC+OaKCTtg9cJXRa7nmpzJdX50yTxyrVVNvZZnoKthSRJIAXkoq0QJW8U5FvqUbF+
         wUHDJ0HzDVf0tfUlj59ToPdGjq9fH5TMjUHOLzSIzx7aJNXOEbcbPIT2FSicVRaepJet
         1ngKpu4E+3o8RJqRgcVvlLyD9dgD9ifsJdf5fRBnRhcHqE3owMk/Mjt2MptFWHgo2/jJ
         QsMNgO5dxxn0m/81Pfwc2mzfu1t8QmyyUquvaXDeFwotVsl91LgMsnJNTZQiVsv+EwnC
         qf8XWYQX9W56c53iJ091ghM1rKELrOXCaWAZ9nuBGIiOU7OUiLvpWLhKkJTw4zJMOoA1
         xszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CI0hLS/bvI0Hqo/pfglI7FYYUsJ/cwY74alonubtd24=;
        b=YhRhaM0XhxZnJD1gAfFNEiWwmKoAvQhTMfEg5ZnzMNTTvi1DMO0ge2eZ1kHWpbDWqf
         t6eQRUsJZ9r1AZN+mY8923qX8uNcfaayzHcUzel/12F8HIk9OPXGUUxD9KLKkVAz2ypS
         GJRshZa9g6jaAErXzg1zCPkhgFgp5IK729hNaje4ofWBCvNdjIVjWB31IPoX5Suv+1Dt
         zV3FZhjcs16FMlX8vSz4BT1BP6osV5C6IV73Qosmo3vIov5L4JGrzCcT1SUTuTQmes0C
         wjZdjMynCd282/AFl80LGekZJF7K0razVx8TnT2bWdGcFd7rVyi8nahxTg0S+xD6ODNs
         x0TQ==
X-Gm-Message-State: ABuFfogv1kqVnP0IE8Ir1b2luicvB6CzxYbpQmmus1/8huf3xqNd6Guc
        kjr9evms72cakBV/Zx/N8tzv8+6IJUs=
X-Google-Smtp-Source: ACcGV60fRVuHt4vkMnJmbNqf0FIUohzkZQQchrgpkJqKoDBbpKvqDDa8UWYE/X+zukw+qWjKv+c8aA==
X-Received: by 2002:adf:93a5:: with SMTP id 34-v6mr2114197wrp.244.1537898923546;
        Tue, 25 Sep 2018 11:08:43 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v6-v6sm2755827wro.66.2018.09.25.11.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:08:43 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] MIPS: Simplify ELF appended dtb handling
Date:   Tue, 25 Sep 2018 21:08:21 +0300
Message-Id: <20180925180825.24659-1-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <yasha.che3@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yasha.che3@gmail.com
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

This patch series simplifies and cleans up the handling of
CONFIG_MIPS_ELF_APPENDED_DTB in the MIPS tree.

Specifically, it makes sure that the dtb appears in 'fw_passed_dtb'
also under CONFIG_MIPS_ELF_APPENDED_DTB=y.

This allows to remove special platform code that handled the ELF
appended dtb case, and replace it with the generic appended dtb
case (fw_passed_dtb).

There's also a bonus: platforms that already handle 'fw_passed_dtb',
gain now automatic support for detecting a DT blob under
CONFIG_MIPS_ELF_APPENDED_DTB=y.


Patches:
- Patch 1 adds only comments (to make the file more readable for patch 2).
- Patch 2 fixes 'fw_passed_dtb' under CONFIG_MIPS_ELF_APPENDED_DTB=y.
- Patch 3 simplifies CONFIG_MIPS_ELF_APPENDED_DTB handling on the BMIPS platform.
- Patch 4 simplifies CONFIG_MIPS_ELF_APPENDED_DTB handling on the Octeon platform.

Patches 3 and 4 depend on patch 2.

The patches are on top of v4.18.

The patches are also available at:
https://github.com/yashac3/linux-rtl8186/commits/elf_appended_dtb_changes_on_4_18

Please review.

Thanks,
Yasha

Cc: linux-kernel@vger.kernel.org


Yasha Cherikovsky (4):
  MIPS/head: Add comments after #endif and #else
  MIPS/head: Store ELF appended dtb in a global variable too
  MIPS: BMIPS: Remove special handling of CONFIG_MIPS_ELF_APPENDED_DTB=y
  MIPS: Octeon: Remove special handling of
    CONFIG_MIPS_ELF_APPENDED_DTB=y

 arch/mips/bmips/setup.c         |  9 +--------
 arch/mips/cavium-octeon/setup.c | 10 +++-------
 arch/mips/kernel/head.S         | 18 ++++++++++--------
 3 files changed, 14 insertions(+), 23 deletions(-)

-- 
2.19.0
