Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2014 18:37:54 +0100 (CET)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:54498 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009087AbaLWRhxah8YH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Dec 2014 18:37:53 +0100
Received: by mail-wi0-f182.google.com with SMTP id h11so11485527wiw.15;
        Tue, 23 Dec 2014 09:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=iOgS/r43ZPe8lRj39q0f5ymr4DDy6AP5n0Hic2STUEA=;
        b=E6Z6TsrCCVcn1+2kRoOuEhYVC1o6zKujKK1zRC13Zv8r9Ys4x1mFo+qg7pPK3K1g5A
         RVKJaYXrnC5YAGSZbfnOYwavA7ic5eOXBqVFpVdxnE007Tll3H3aA+zwfrNUuOIFhNQ7
         9PzOCIE5LQQscdT2NbjGnEB/7ZSex2Wowk5ruwkXCkKRbR1MRf4cEHrqp9UYFaRceb9S
         Fx4PF1XN3Vkjl5jTgI5DEsMXvf9g8DwKyzrIFhlj/NUj8dLSXyJCMnnycL1xvFIoXSvb
         ax5g8Z8B5U4jV3LR8bVtc5ovsO2aSGt8lriLBCdMgxH0GAz6hcwlANYIg2Sg4/JQ4NnD
         r4rg==
MIME-Version: 1.0
X-Received: by 10.181.13.75 with SMTP id ew11mr42614717wid.69.1419356268028;
 Tue, 23 Dec 2014 09:37:48 -0800 (PST)
Received: by 10.194.17.34 with HTTP; Tue, 23 Dec 2014 09:37:47 -0800 (PST)
Date:   Tue, 23 Dec 2014 11:37:47 -0600
Message-ID: <CACoURw7SaqXtipXQSgp-S0DHognza6W7y=tjUiEskqh8_UB6FA@mail.gmail.com>
Subject: kconfig problem in 3.19-rc1
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
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

When trying to build my .config file in 3.19-rc1, I receive the
following error message:

$ make menuconfig
scripts/kconfig/mconf Kconfig
arch/mips/Kconfig:2681:error: recursive dependency detected!
arch/mips/Kconfig:2681: symbol MIPS32_N32 depends on MIPS32_COMPAT
arch/mips/Kconfig:2658: symbol MIPS32_COMPAT is selected by MIPS32_N32

  This seems to have been introduced in commit f92b81f,
MIPS: Compat: Fix build error if CONFIG_MIPS32_COMPAT but no compat ABI.

Shane McDonald
