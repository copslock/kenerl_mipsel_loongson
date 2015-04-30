Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2015 19:34:52 +0200 (CEST)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35093 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012322AbbD3RevZk9ag (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2015 19:34:51 +0200
Received: by iejt8 with SMTP id t8so73135323iej.2;
        Thu, 30 Apr 2015 10:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=JrNonUxSgrr2NLfMWni6499eUXMs4dF8GnPrAhl369E=;
        b=lEa1uWLf2hSFQTeLh0Icn4odFblO1GQKiEzqAwz3yge6TXkb1xBIiXluWbk35ADduU
         Yuew967sjlshDaeCAv8+JwBeklWEe3DQlv7M9SjqMXJCDMUHQVOIvKdKx0Yyr4825Uwz
         QCX9uFUUMc6BKjRpzMoHYsy/FSfn0BupUt/+NOVFsnwiCPVaPTHv9zUfBDoNXh40hSvG
         VzwVht0pvUQ2eJHw072TS1RbxfHxrEjskQTq2a8w5UrbUSvyJFhINJSUf46uqyn/RuI7
         4RJ8x78qj25bU3BfpVUII2Jk2+zuUjLfc2iK81Ei+Xj1p91HojZ+hwCoHhdOnWqcE4lU
         5L2w==
X-Received: by 10.50.43.196 with SMTP id y4mr5115442igl.14.1430415286871; Thu,
 30 Apr 2015 10:34:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.40 with HTTP; Thu, 30 Apr 2015 10:34:06 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Thu, 30 Apr 2015 19:34:06 +0200
Message-ID: <CAOLZvyHPYF2kO2EdijCCX9OSt=hdo8g-tUXzZee0sSXT=-WdDw@mail.gmail.com>
Subject: 4.1: XPA breaks Alchemy
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Hi Steve,

your patch commit c5b367835cfc7a8ef53b9670a409ffcc95194344
("MIPS: Add support for XPA") breaks userspace on my Alchemy systems,
everything is killed with error -14:

Kernel panic - not syncing: Requested init /bin/sh failed (error -14).

Reverting that patch fixes everything.  I bet it's related to the 36bit
address space in some way.

Thanks!
     Manuel
