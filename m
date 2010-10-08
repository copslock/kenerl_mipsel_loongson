Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2010 16:27:09 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:36228 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491196Ab0JHO1G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Oct 2010 16:27:06 +0200
Received: by pwi5 with SMTP id 5so387321pwi.36
        for <linux-mips@linux-mips.org>; Fri, 08 Oct 2010 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=rr0YZv8VRPB4q2UYkePnCcuNNKAkRvcFcm2pw/nPPsk=;
        b=hJqyASzfW3HZn+iSkssuzeFQyVm0WPDUSjl/ddqJXNJqVytryg0kuCSJUUORHdFy14
         Y3RM2fOocsVGQ6kyyqfUAjx4pcbYJQC7fAza6NV3pfEtG507oiMPCoaVciqASthf7uUD
         T5oyNN+MjLnDSYX+RrERU9XXkOoP/PRUkzWXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=SZusscw2g5FF6b2cgV7TQj8lVdqmzVckAfJu/sjIJnDVObzYTpLvNZ/T9TTFg1wEqU
         UqNK69aEHk47uMYxRS1S9Nnu5BDp/Vll1V/6ZUnVppihc/nNo7vR9z19K8zSLpa5O0LS
         G+E8BP6dIYnm/j50hhfMliYdqqbgvvRthzuIw=
MIME-Version: 1.0
Received: by 10.142.148.18 with SMTP id v18mr2053882wfd.9.1286547393901; Fri,
 08 Oct 2010 07:16:33 -0700 (PDT)
Received: by 10.231.59.77 with HTTP; Fri, 8 Oct 2010 07:16:33 -0700 (PDT)
Date:   Fri, 8 Oct 2010 16:16:33 +0200
Message-ID: <AANLkTikXySeekzpYeGf6wuH5NTMxLCK_oirvBcDu4h63@mail.gmail.com>
Subject: siginfo difference MIPS and other arches
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hello,

current -git build breaks because of upstream commit
a337fdac7a5622d1e6547f4b476c14dfe5a2c892, which introduced
an unconditional check for siginfo_._sifields._sifault._si_addr_lsb field.

Is there a reason why MIPS doesn't use the default siginfo_t structure
as other architectures do?

Manuel
