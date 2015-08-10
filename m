Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Aug 2015 21:05:04 +0200 (CEST)
Received: from mail-ob0-f178.google.com ([209.85.214.178]:35661 "EHLO
        mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010825AbbHJTFCq3i5a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Aug 2015 21:05:02 +0200
Received: by obbop1 with SMTP id op1so131518822obb.2
        for <linux-mips@linux-mips.org>; Mon, 10 Aug 2015 12:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=egknVD6hwOkDzNcp3irHlObxNGXGVbloxdlN5i+I+SQ=;
        b=lVAs5e9+R2PYwF9JoR3jEtU04cUmG1qQNSXN/mVSEv0m6fJue2u7gIsPka2/7v5BMv
         7aTEbNL5nTAlkbqvd2NpHkx6smgnfSIzbFN+rBUMFh/BJ7yLN/9nnls1gKO06RTw6rXl
         pEpyE+KsCjOHCTqgytk+Poabi8FdeuZ67tUNAmHiZBF5dTzg4bxacFrgRgfAR2MKqqUA
         Ir/O7lzpErV/yOumN5tYu3m4SGroEIeLU4jg4Ym1ZVuDmLfgLy8maEgFmADoN4wJqIFR
         J/4L4RsNw6skn2krRLbzMzFOY4TpISdXW5l5XbrM0QpgGqexJjabhIkUtT/yG4Nkl/ZU
         O/Dw==
MIME-Version: 1.0
X-Received: by 10.182.252.234 with SMTP id zv10mr9619541obc.68.1439233497114;
 Mon, 10 Aug 2015 12:04:57 -0700 (PDT)
Received: by 10.60.118.137 with HTTP; Mon, 10 Aug 2015 12:04:57 -0700 (PDT)
Date:   Tue, 11 Aug 2015 03:04:57 +0800
Message-ID: <CAKcpw6XSffSzv+5yQMRUaP0FdM-tG444wL75HffstdwLqvfQ9w@mail.gmail.com>
Subject: what's the status of little endian support of Octeon?
From:   YunQiang Su <wzssyqa@gmail.com>
To:     linux-mips <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <wzssyqa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wzssyqa@gmail.com
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

I am wondering about the what the status of Little endian support of
Octeon in upstream kernel,
aka Linus tree.

If not, any plan?

Octeon II:
       Supported now?

Octeon III:
       Supported now?
       How about the FPU?

-- 
YunQiang Su
