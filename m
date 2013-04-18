Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Apr 2013 09:14:04 +0200 (CEST)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:45183 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819996Ab3DRHOCnCGsR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Apr 2013 09:14:02 +0200
Received: by mail-lb0-f179.google.com with SMTP id t1so2388320lbd.10
        for <linux-mips@linux-mips.org>; Thu, 18 Apr 2013 00:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=f/o5I8+GQScxFKhqge/mn+PYyNvJ0XR+8cAA6TbRHIc=;
        b=UQhcIEn1gSlJ72PGaQ/YHlSq0rzK4fMo504QLzKVD+/1ADyaj3ESNxazvThfJyH4P6
         aC7f6G3tcIGHAjYUgngvdgaPKp7lzbAImrcTZWJP9Yy8Nf30VO9u6Oy/VGpoPRDSXJP5
         stlR5c/G0INTG238rg7dir8JD/3BM8W6P6pRfQ0NtDI2GXjKHnPPrhioYTgivWJQnMGU
         06JBw9nmAKJk3t7LnUW3+hzOG7PybL+cV35XX3LvVHsoYGkkNT+LljCxDqd7yZvfTRsF
         RFNUHGh1DlhPxs/1XKDzTe+ZWVmxnMnLMXTHr4Fz//KvuPbttOgK7tnsxJpffp/FrKfk
         I1jQ==
MIME-Version: 1.0
X-Received: by 10.152.6.10 with SMTP id w10mr5139284law.30.1366269235306; Thu,
 18 Apr 2013 00:13:55 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Thu, 18 Apr 2013 00:13:55 -0700 (PDT)
Date:   Thu, 18 Apr 2013 15:13:55 +0800
Message-ID: <CAF1ivSZXGY0dUSTVan-VuMVaQrtUOEZuRqhqmnNe-euCj03XAA@mail.gmail.com>
Subject: hard lockup problem
From:   Lin Ming <minggr@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <minggr@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: minggr@gmail.com
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

Hi list,

I encounter a problem that cpu stuck with irq disabled, which is known
as hard lockup.
I know there is NMI hard lockup detector for x86, which can dump the
back trace of the hard lockup.

Is there any similar feature for MIPS?

Thanks,
Lin Ming
