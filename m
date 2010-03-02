Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Mar 2010 14:54:26 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:34107 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491868Ab0CBNyX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Mar 2010 14:54:23 +0100
Received: by pwj2 with SMTP id 2so123886pwj.36
        for <linux-mips@linux-mips.org>; Tue, 02 Mar 2010 05:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=e+7hUrAoTeTQ89bmtRz5Rs9hFOIBbo0LJxgw9wtlCDI=;
        b=xeki5kE1u0M7QtVk24PoRLSm8knZAZVNvvHadlw34AIMHvMUGAbEUIP6/XBlkYApE9
         UsZwb8sb1lMH+S5ZUivVtVZJSd/b5PwFy7dCyh47u+ij0IWxTEAMpHEr/Gxft9auAJp3
         YlCHP4ybScR5tl/zx9MwBKFPZs7TLR5tm4Bl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=sGlrxz39XJ0nvMH5WbPDJOgxOcfqKnvWCHHfWxlAyDjO4m4Gn4wGMufvlbnp8+FCTy
         Fb9HeKkkh5Fiol7XA2JwyCQ84K1a/nYXas+NCtOenL/zqPbduLhMD/RWIGafnKAxVHYP
         lKS8Z5fWXX5QPPGY6hgl+KXq2+TZoQQhccd+A=
MIME-Version: 1.0
Received: by 10.114.22.12 with SMTP id 12mr252391wav.205.1267538055383; Tue, 
        02 Mar 2010 05:54:15 -0800 (PST)
Date:   Tue, 2 Mar 2010 19:24:15 +0530
Message-ID: <9bde694e1003020554p7c8ff3c2o4ae7cb5d501d1ab9@mail.gmail.com>
Subject: kmemleak for MIPS
From:   naveen yadav <yad.naveen@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <yad.naveen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yad.naveen@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all,

I want to check kmemleak for both ARM/MIPS. i am able to find kernel
patch for ARM at
http://linux.derkeiler.com/Mailing-Lists/Kernel/2009-04/msg11830.html.
But I could not able to trace patch for MIPS.

Kind Regards
Naveen
