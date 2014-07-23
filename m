Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2014 06:41:14 +0200 (CEST)
Received: from mail-vc0-f181.google.com ([209.85.220.181]:39565 "EHLO
        mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6821394AbaGWElGR-9nC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2014 06:41:06 +0200
Received: by mail-vc0-f181.google.com with SMTP id lf12so1189334vcb.12
        for <multiple recipients>; Tue, 22 Jul 2014 21:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=SqiyxS1Z1FDiMXbLPms5h1Jc9VC6Dqk6IrU6FOnaQ/o=;
        b=Lh6perGTUhUimoH0tVwztbQ8XNWv42Xw6mOGpRlvcYOt2b4IkyOkuJb4Dpvz30Q1jZ
         Dvgt3rVDLnm6kvjS7ttO+7EZM+Srl7l30ySdXUBiVmvp/hMIe6D3fF2LL3NTFuf7b0m4
         NlEGfLgJjIVBGdjLCJtWdQ7623z50az2xk7HlqVpHThUJygXE54+m42CePve1bV2/kdD
         mc2WTAAfUB9AhVeUXF7MtvvZlwLzS+ntx8QrTFBQKbx3Db/tTrZ8gEk4Qw1gNUOXZOhw
         H5kMDHSL9pQg6B4JAHPtPRcgmPXcNiZSX541CmP/8Gj0vOwy3bS1x/0YNvMe19PNHPzD
         Kl9w==
MIME-Version: 1.0
X-Received: by 10.52.186.103 with SMTP id fj7mr29794355vdc.53.1406090459495;
 Tue, 22 Jul 2014 21:40:59 -0700 (PDT)
Received: by 10.220.187.133 with HTTP; Tue, 22 Jul 2014 21:40:59 -0700 (PDT)
Date:   Wed, 23 Jul 2014 00:40:59 -0400
Message-ID: <CAPDOMVjNyAwo53Coz8MFuUs70M7j1e3QWprus5vGpTfAw=hspg@mail.gmail.com>
Subject: smp-cmp.c: CDFIXMES
From:   Nick Krause <xerofoify@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        John Crispin <blogic@openwrt.org>, markos.chandras@imgtec.com,
        Steven.Hill@imgtec.com, Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41508
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

Are the lines with  CDFIXME still needed? If not please tell me as I
will send in a patch removing these
two from this file in order to help you guys out :).
Cheers Nick
